xquery version "3.0";

import module namespace session ="http://exist-db.org/xquery/session";

import module namespace config="http://exist-db.org/mods/config" at "/apps/cluster-shared/modules/config.xqm";
import module namespace theme="http://exist-db.org/xquery/biblio/theme" at "/apps/cluster-shared/modules/theme.xqm";
import module namespace security="http://exist-db.org/mods/security" at "/apps/cluster-shared/modules/search/security.xqm";

declare namespace exist = "http://exist.sourceforge.net/NS/exist";

declare variable $exist:controller external;
declare variable $exist:root external;
declare variable $exist:prefix external;
declare variable $exist:path external;
declare variable $exist:resource external;

declare variable $local:item-uri-regexp := "/item/([a-z0-9-_]*)";

declare function local:get-item($controller as xs:string, $root as xs:string, $prefix as xs:string?, $path as xs:string, $resource as xs:string?, $username as xs:string?, $password as xs:string?) as element(exist:dispatch) {
    
    let $item-id := fn:replace($path, $local:item-uri-regexp, "$1") return
    
        <dispatch xmlns="http://exist.sourceforge.net/NS/exist">        
            <forward url="{theme:resolve-uri($prefix, $root, 'pages/index.html')}">
                { local:set-user($username, $password) }
            </forward>
            <view>
                <forward url="../modules/search/search.xql">
                    <set-attribute name="xquery.report-errors" value="yes"/>
                    
                    <set-attribute name="exist:root" value="{$root}"/>
                    <set-attribute name="exist:path" value="{$path}"/>
                    <set-attribute name="exist:prefix" value="{$prefix}"/>
                    
                    <add-parameter name="id" value="{$item-id}"/>
        		</forward>
        	</view>
    	</dispatch>
    	(:
    	<add-parameter name="filter" value="ID"/>
        <add-parameter name="value" value="{$item-id}"/>
    	:)
};

declare function local:login($username as xs:string?, $password as xs:string?) {
    let $session-credentials := security:get-user-credential-from-session()
    return
        if ($session-credentials != '' and $session-credentials[1] ne 'guest')
        then (
            true()
        ) else (
            if ($username ne 'guest')
            then (
                let $login := security:login($username, $password)
                let $storer := if($login) then ( security:store-user-credential-in-session($username, $password) ) else()
                return
                    $login
            ) else (
                false()
            )
        )
};

declare function local:set-user($username as xs:string?, $password as xs:string?) {
    session:create(),
    let $session-user-credential := security:get-user-credential-from-session()
    return
        if ($username) then (
            security:store-user-credential-in-session($username, $password),
            <set-attribute xmlns="http://exist.sourceforge.net/NS/exist" name="xquery.user" value="{$username}"/>,
            <set-attribute xmlns="http://exist.sourceforge.net/NS/exist" name="xquery.password" value="{$password}"/>
        ) else if ($session-user-credential != '') then (
            <set-attribute xmlns="http://exist.sourceforge.net/NS/exist" name="xquery.user" value="{$session-user-credential[1]}"/>,
            <set-attribute xmlns="http://exist.sourceforge.net/NS/exist" name="xquery.password" value="{$session-user-credential[2]}"/>
        ) else (
            <set-attribute xmlns="http://exist.sourceforge.net/NS/exist" name="xquery.user" value="{$security:GUEST_CREDENTIALS[1]}"/>,
            <set-attribute xmlns="http://exist.sourceforge.net/NS/exist" name="xquery.password" value="{$security:GUEST_CREDENTIALS[2]}"/>
        )
};

let $origin := request:get-parameter("origin", '')
let $id_http_param := request:get-parameter("id", ())
let $username := if(request:get-parameter("username",()))
                 then (
                    config:rewrite-username(request:get-parameter("username",()))
                 )
                 else(), $password := request:get-parameter("password",())
let $login := local:login($username, $password)
return
    if (request:get-parameter("logout",()))then
    (
        session:clear(),
        session:invalidate(),
        <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
            <redirect url="."/>
        </dispatch>
    ) else if ($exist:path eq "") then
        <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
            <redirect url="{concat(request:get-uri(), '/')}"/>
        </dispatch>
    else if (contains($exist:path, "/$shared/")) then
        <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
            <forward url="/apps/shared-resources/{substring-after($exist:path, '/$shared/')}" absolute="yes"/>
        </dispatch>
    else if (contains($exist:path, "/$cluster-shared/")) then
        <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
            <forward url="/apps/cluster-shared/{substring-after($exist:path, '/$cluster-shared/')}" absolute="yes"/>
        </dispatch>
    else if (contains($exist:path, "/resources/")) then
        <ignore xmlns="http://exist.sourceforge.net/NS/exist">
            <cache-control cache="yes"/>
        </ignore>
    else if (contains($exist:path, "/imageService/")) then
        let $imagerecord := request:get-parameter('imagerecord', 'i_f55c3201-0454-5045-93b4-767e67536fc8')
        return
        <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
            <redirect url="{$config:image-service-url || '/' || $imagerecord|| '?width=32&amp;height=32'}"/>
        </dispatch>
    else if ($login) then (
        if ($exist:path eq "/") then
        <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
            {local:set-user($username, $password)}
              <redirect url="{request:get-context-path()}/{$exist:prefix}/{$exist:controller}/index.xql"/>
        </dispatch>
        else if ( ends-with($exist:resource, ".html") ) then
        <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
            <view>
                <forward url="{$exist:controller}/modules/view.xql">
                    {local:set-user($username, $password)}
                    <set-attribute name="$exist:root" value="{$exist:root}"/>
                    <set-attribute name="$exist:prefix" value="{$exist:prefix}"/>
                    <set-attribute name="$exist:controller" value="{$exist:controller}"/>
                    <set-attribute name="$exist:path" value="{$exist:path}"/>
                    <set-attribute name="$exist:resource" value="{$exist:resource}"/>
                    <set-header name="CacheControl" value="no-cache"/>
                </forward>
            </view>
            <error-handler>
                <forward url="{$exist:controller}/error-page.html" method="get"/>
                <forward url="{$exist:controller}/modules/view.xql"/>
            </error-handler>
        </dispatch>
        else
            (: everything else is passed through :)
            <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
                {local:set-user($username, $password)}
                <cache-control cache="yes"/>
            </dispatch>
    ) else (
        <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
            <forward url="{$exist:controller}/login.xql">
                <add-parameter name="path" value="{$exist:path}"/>
                <add-parameter name="controller" value="{$exist:controller}"/>
                <add-parameter name="prefix" value="{$exist:prefix}"/>
                <set-attribute name="root" value="{$exist:root}"/>
                <set-attribute name="id" value="{$id_http_param}"/>
            </forward>
        </dispatch>
    )
        
(:

     else if ($exist:resource eq 'retrieve') then


	   <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
	       { local:set-user($username, $password) }
		  <forward url="../modules/search/session.xql">
		  </forward>
	   </dispatch>



    else if (starts-with($exist:path, "/item/theme")) then
        let $path := theme:resolve-uri($exist:prefix, $exist:root, substring-after($exist:path, "/item/theme"))
        let $themePath := replace($path, "^(.*)/[^/]+$", "$1")
        return
            <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
                <forward url="{$path}">
                    <set-attribute name="theme-collection" value="{theme:get-path()}"/>
                </forward>
            </dispatch>
            
    else if (starts-with($exist:path, "/item/resources")) then
        let $real-resources-path := fn:concat($exist:controller, "/", substring-after($exist:path, "/item/")) return
            <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
                <forward url="{$real-resources-path}">
                </forward>
            </dispatch>
    
    else if (starts-with($exist:path, "/item/images")) then
        let $real-resources-path := fn:concat("/", substring-after($exist:path, "/item/images"))
        let $log := util:log("ERROR", ("IMAGE: ", $real-resources-path))
        return
            <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
                <forward url="{$real-resources-path}">
                </forward>
            </dispatch>
            
    else if(fn:starts-with($exist:path, "/item/")) then
        local:get-item($exist:controller, $exist:root, $exist:prefix, $exist:path, $exist:resource, $username, $password)
:)
xquery version "3.0";

import module namespace request="http://exist-db.org/xquery/request";
import module namespace xmldb = "http://exist-db.org/xquery/xmldb";
import module namespace session = "http://exist-db.org/xquery/session";

declare variable $exist:path external;
declare variable $exist:resource external;
declare variable $exist:controller external;
declare variable $exist:prefix external;
declare variable $exist:root external;

declare variable $logout := request:get-parameter("logout", ());

declare function local:is-logged-in() {
    exists(local:credentials-from-session())
};

(:~
    Retrieve current user credentials from HTTP session
:)
declare function local:credentials-from-session() as xs:string* {
    (session:get-attribute("app.user"), session:get-attribute("app.password"))
};

(:~
    Store user credentials to session for future use. Return an XML
    fragment to pass user and password to the query.
:)
declare function local:set-credentials($user as xs:string, $password as xs:string?) as element()+ {
    session:set-attribute("app.user", $user),
    session:set-attribute("app.password", $password),
    <set-attribute name="xquery.user" value="{$user}"/>,
    <set-attribute name="xquery.password" value="{$password}"/>
};

(:~
    Check if login parameters were passed in the request. If yes, try to authenticate
    the user and store credentials into the session. Clear the session if parameter
    "logout" is set.

    The function returns an XML fragment to be included into the dispatch XML or
    the empty set if the user could not be authenticated or the
    session is empty.
:)
declare function local:set-user() as element()* {
    session:create(),
    let $user := request:get-parameter("user", ())
    let $password := request:get-parameter("password", ())
    let $sessionCredentials := local:credentials-from-session()
    return
        if ($user) then
            let $loggedIn := xmldb:login("/db", $user, $password)
            return
                if ($loggedIn) then
                    local:set-credentials($user, $password)
                else
                    ()
        else if (exists($sessionCredentials)) then
            local:set-credentials($sessionCredentials[1], $sessionCredentials[2])
        else
            ()
};

declare function local:logout() as empty() {
    session:clear()
};


if ($logout) then
    local:logout()
else
    (),

(:
let $login := xmldb:login("/db", "admin", "admin")
:)
let $origin := request:get-parameter("origin", '')
let $login := local:set-user()
let $id_http_param := request:get-parameter("id", ())
return
if ($origin and $exist:path eq "") then
   <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <redirect url="{$origin}"/>
    </dispatch>
else if ($exist:path eq "") then
   <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <redirect url="{request:get-context-path()}/{$exist:prefix}/{$exist:controller}/index.xql"/>
    </dispatch>
else if ($exist:path eq "/") then
    <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <redirect url="index.xql"/>
    </dispatch>
(:  Protect everthing. :)
else if ($login)
    then (
        if ($origin) then (
            <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
                <redirect url="{$origin}"/>
            </dispatch>
        ) else if ( ends-with($exist:resource, ".html") ) then
            <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
                <view>
                    <forward url="{$exist:controller}/modules/view.xql">
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
        else if (contains($exist:path, "/libs/")) then
            <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
                <forward url="/{substring-after($exist:path, '/libs/')}" absolute="yes"/>
            </dispatch>
        else
            <ignore xmlns="http://exist.sourceforge.net/NS/exist">
                <cache-control cache="yes"/>
            </ignore>
    )
else if (contains($exist:path, "/resources/")) then
    <ignore xmlns="http://exist.sourceforge.net/NS/exist">
        <cache-control cache="yes"/>
    </ignore>
else if (contains($exist:path, "/schema/")) then
    <ignore xmlns="http://exist.sourceforge.net/NS/exist">
        <cache-control cache="yes"/>
    </ignore>
else if (contains($exist:path, "/validations/")) then
    <ignore xmlns="http://exist.sourceforge.net/NS/exist">
        <cache-control cache="yes"/>
    </ignore>
else
    <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <forward url="{$exist:controller}/login.xql">
            <add-parameter name="path" value="{$exist:path}"/>
            <add-parameter name="controller" value="{$exist:controller}"/>
            <add-parameter name="prefix" value="{$exist:prefix}"/>
            <set-attribute name="root" value="{$exist:root}"/>
            <set-attribute name="id" value="{$id_http_param}"/>
        </forward>
    </dispatch>

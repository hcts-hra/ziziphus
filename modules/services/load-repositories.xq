xquery version "3.0";

import module namespace app="http://www.betterform.de/projects/shared/config/app" at "/apps/cluster-shared/modules/ziziphus/config/app.xqm";
import module namespace security="http://exist-db.org/mods/security" at "/apps/cluster-shared/modules/search/security.xqm";

declare variable $user := security:get-user-credential-from-session()[1];
declare variable $userpass := security:get-user-credential-from-session()[2];

declare option exist:serialize "method=json media-type=text/javascript";

(:
    let $user := replace(request:get-parameter("user", ""), "[^0-9a-zA-ZäöüßÄÖÜ\-,. ]", "")
    let $group := replace(request:get-parameter("user", ""), "[^0-9a-zA-ZäöüßÄÖÜ\-,. ]", "")
    xmldb:exist://${remote-host}/exist/xmlrpc/db/test/sync
:)



declare %private function local:getGlobalCollection($type as xs:string) {
    let $name := 
        switch ($type)
            case "names"
            case "organisations"
            case "persons"
                return 'EXC/VIAF'
            case "subjects"
                return 'EXC/AAT'
            default 
                return 'Unknown'
    return
        <repository repotype="global" id="100" termtype="{$type}" name="{$name}" collection="default"/>
};

declare %private function local:getUserCollection($user as xs:string, $type as xs:string) {
    let $collection := $app:users-repositories-collection || $user || '/' || $type
    return
            if ( xmldb:collection-available($collection) and count(xmldb:get-child-resources($collection)) > 0)
            then (
                let $config := doc($collection || $app:repositories-configuration)
                return
                    <repository id="{util:uuid()}" name="{data($config/repository/@name)}" collection="{$collection}" icon="{data($config/repository/@icon)}"></repository>
                    (: <repository repotype="user" id="{util:uuid()}" termtype="{$type}" name="{data($config/repository/@name)}" collection="{$collection}" icon="{data($config/repository/@icon)}"></repository> :)
            )
            else ()
};

declare %private function local:getGroupCollections($group as xs:string, $type as xs:string) {
    let $collection := $app:groups-repositories-collection || $group || '/' || $type || '/'
    let $log1 := util:log('info','colection: ' || $collection)
    return
        if (xmldb:collection-available($collection) and count(xmldb:get-child-resources($collection)) > 0)
        then (
            let $config := doc($collection || $app:repositories-configuration)
            return
                <repository id="{util:uuid()}" name="{$config/repository/@name}" collection="{$collection}" icon="{$config/repository/@icon}"></repository>
                (: <repository repotype="group" id="{util:uuid()}" termtype="{$type}" name="{$config/repository/@name}" collection="{$collection}" icon="{$config/repository/@icon}"></repository> :)
        )
        else () 
};

declare %private function local:getRepositories($user as xs:string, $groups as xs:string*, $type as xs:string, $sgroup as xs:string) {
    let $global := local:getGlobalCollection($type)
    let $local := ( local:getUserCollection($user, $type), for $group in $groups
        return 
            local:getGroupCollections($group, $type) )
    return
   
        if($sgroup eq 'global')
        then (
            $global,
            if(count($local) > 0) then (<repository repotype="custom" id="-1" termtype="{$type}" name="Use custom vocab" collection="local"/>) else ()
        ) else (
            $local
        )
};

let $cors := response:set-header("Access-Control-Allow-Origin", "*")
let $sgroup := replace(request:get-parameter("group", "global"), "[^0-9a-zA-ZäöüßÄÖÜ\-,. ]", "")
let $type := replace(request:get-parameter("type", "subjects"), "[^0-9a-zA-ZäöüßÄÖÜ\-,. ]", "")
let $log1 := util:log('info','user: ' || $user)
let $log1 := util:log('info','userpass: ' || $userpass)
let $user := "admin"
let $userpass := ""
let $groups := system:as-user($user, $userpass, ( sm:get-user-groups($user) ) )
return
   <data><total>0</total>{local:getRepositories($user, $groups, $type, $sgroup)}</data>

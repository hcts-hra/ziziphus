(:~
 : Get Current User
 :
 : @author: Lars Windauer
 : @author: Tobi Krebs
:)
xquery version "3.0";

import module namespace security="http://exist-db.org/mods/security" at "/apps/rosids-shared/modules/search/security.xqm";
import module namespace app="http://github.com/hra-team/rosids-shared/config/app" at "/apps/rosids-shared/modules/ziziphus/config/app.xqm";

let $workdir :=  request:get-parameter('workdir','')
let $workdir := if($workdir eq "") then ($app:ziziphus-default-record-dir) else ($workdir)

let $username := security:get-user-credential-from-session()[1]
let $userpass := security:get-user-credential-from-session()[2]
let $groups := system:as-user($username, $userpass, sm:get-user-groups($username))
return
    <data>
        <!--
            <user name="{$username}" edit="{security:can-write-collection(xmldb:encode($workdir))}"/> :)
        -->
        <user name="{$username}">{$username}</user>
        <groups>{$groups}</groups>
    </data>

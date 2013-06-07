(:~
 : Get Current User
 :
 : @author: Lars Windauer
 : @author: Tobi Krebs
:)
xquery version "3.0";

import module namespace security="http://exist-db.org/mods/security" at "/apps/cluster-shared/modules/search/security.xqm";
import module namespace app="http://www.betterform.de/projects/ziziphus/xquery/app" at "app.xqm";

let $workdir :=  request:get-parameter('workdir','')
 let $workdir := if($workdir eq "") then ($app:record-dir) else ($workdir)

let $username := security:get-user-credential-from-session()[1]
return
    <data>
        <user name="{$username}"edit="{security:can-write-collection($workdir)}"/>
    </data>

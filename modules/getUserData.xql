(:~
 : Get Current User
 :
 : @author: Lars Windauer
:)
xquery version "3.0";


import module namespace security="http://exist-db.org/mods/security" at "/apps/cluster-shared/modules/search/security.xqm";
import module namespace app="http://www.betterform.de/projects/ziziphus/xquery/app" at "app.xqm";

let $username := security:get-user-credential-from-session()[1]
return
    <data>
        <user name="{$username}"edit="{security:can-write-collection( $app:work-record-dir )}"/>
    </data>

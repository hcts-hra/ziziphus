xquery version "1.0";

import module namespace xdb="http://exist-db.org/xquery/xmldb";
import module namespace util="http://exist-db.org/xquery/util";


(: The following external variables are set by the repo:deploy function :)
(: file path pointing to the exist installation directory :)
declare variable $home external;
(: path to the directory containing the unpacked .xar package :)
declare variable $dir external;
(: the target collection into which the app is deployed :)
declare variable $target external;



(:~ ImageDB security - admin user and users group :)
declare variable $biblio-admin-user := "editor";
declare variable $biblio-users-group := "biblio.users";

(:~ Collection names :)
declare variable $data-collection := fn:concat($target, "/data");

declare variable $log-level := "INFO";

(: Helper function manage resource permissions :)
declare function local:set-collection-resource-permissions($collection as xs:string, $owner as xs:string, $group as xs:string, $permissions as xs:int) {
    for $resource in xdb:get-child-resources($collection) return
        xdb:set-resource-permissions($collection, $resource, $owner, $group, $permissions)
};



util:log($log-level, "Permissions: Set permissions for sample data..."),
local:set-collection-resource-permissions($data-collection, $biblio-admin-user, $biblio-users-group, util:base-to-integer(0744, 8)),
util:log($log-level, "...Permission: Done setting security permission.")



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

declare function local:createUser($usersConfiguration, $userName) {
    let $user := $usersConfiguration//user[@name = $userName]
    return
        if( sm:user-exists($user/@name) )
        then (
            let $userGroups := sm:get-user-groups($user/@name)
            let $checkGroups :=
                for $group in tokenize($user/@groups, ' ')
                let $checkMembership := if (contains($userGroups, $group)) then ( '' ) else ( sm:add-group-member($group, $user/@name) )
                return ""
            return
                <user status="present">{string($user/@name)}</user>
        )
        else (
            let $result := sm:create-account(data($user/@name), data($user/@password), data($user/@primarygroup), local:getGroups(data($user/@groups)))
            return
                <user status="created" groups="{tokenize(data($user/@groups),' ')}">{string($user/@name)}</user>
        )
};

declare %private function local:getGroups($groups as xs:string) as xs:string* {
    tokenize(data($groups), ' ')
};


declare function local:createGroups($groupsConfiguration, $usersConfiguration) {
for $group in $groupsConfiguration//group
    return
        if( sm:group-exists($group/@name) ) 
        then (
            <group status="present">{string($group/@name)}</group>
        ) 
        else ( 
            if (sm:user-exists($group/@manager)) 
            then ( 
                let $result := sm:create-group($group/@name, $group/@manager, 'No Description')
                return
                <group status="created" manager="{string($group/@manager)}">{string($group/@name)}</group>
            ) 
            else (
                let $result := ( local:createUser($usersConfiguration, $group/@manager), sm:create-group($group/@name, $group/@manager, 'No Description') )
                return
                <group status="created" manager="{string($group/@manager)}">{string($group/@name)}</group>
            ) 
        )
};
declare function local:createGroups($groupsConfiguration, $usersConfiguration) {
for $group in $groupsConfiguration//group
    return
        if( sm:group-exists($group/@name) ) 
        then (
            <group status="present">{string($group/@name)}</group>
        ) 
        else ( 
            if (sm:user-exists($group/@manager)) 
            then ( 
                let $result := sm:create-group($group/@name, $group/@manager, 'No Description')
                return
                <group status="created" manager="{string($group/@manager)}">{string($group/@name)}</group>
            ) 
            else (
                let $result := ( local:createUser($usersConfiguration, $group/@manager), sm:create-group($group/@name, $group/@manager, 'No Description') )
                return
                <group status="created" manager="{string($group/@manager)}">{string($group/@name)}</group>
            ) 
        )
};


declare function local:createUsers($usersConfiguration) {
        for $user in $usersConfiguration//user
        return
           local:createUser($usersConfiguration, $user/@name)
};

declare function local:setupUsersAndGroups() {
    let $groupsConfiguration := <groups>
                                    <group name="editor" manager="editor"/>
                                    <group name="reader" manager="reader"/>
                                    <group name="admin" manager="admin"/>
                                </groups>
    let $usersConfiguration :=  <users>
                                    <user name="reader" password="reader" primarygroup="readers" groups=""  />
                                    <user name="editor" password="editor" primarygroup="editors" groups="reader"/>
                                    <user name="dbadmin" password="dbadmin" primarygroup="admins" groups="reader editor"/>
                                </users>

    return        
        (
            <groups>{local:createGroups($groupsConfiguration, $usersConfiguration)}</groups>, 
            <users>{local:createUsers($usersConfiguration)}</users>
        )
};




util:log($log-level, "Permissions: Set permissions for sample data..."),
local:set-collection-resource-permissions($data-collection, $biblio-admin-user, $biblio-users-group, util:base-to-integer(0744, 8)),
util:log($log-level, "...Permission: Done setting security permission."),
local:setupUsersAndGroups()


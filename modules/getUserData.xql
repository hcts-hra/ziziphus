(:~
 : Get Current User
 :
 : @author: Lars Windauer
:)
xquery version "3.0";

declare namespace xmldb = "http://exist-db.org/xquery/xmldb";

let $username := session:get-attribute("app.user")
return
    <data>
        <user name="{$username}"/>
    </data>

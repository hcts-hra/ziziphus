(:~
 : Get Current User
 :
 : @author: Lars Windauer
:)
xquery version "3.0";

declare namespace xmldb = "http://exist-db.org/xquery/xmldb";

let $username := session:get-attribute("app.user")
let $password := session:get-attribute("app.password")
return
    <data>
        <user password="{$password}" name="{$username}"/>
    </data>

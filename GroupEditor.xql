xquery version "3.0";

declare namespace httpclient = "http://exist-db.org/xquery/httpclient";
import module namespace security="http://exist-db.org/mods/security" at "/apps/rosids-shared/modules/search/security.xqm";

declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=yes indent=yes";

declare variable $user := security:get-user-credential-from-session()[1];
declare variable $userpass := security:get-user-credential-from-session()[2];

let $data := <data><username>{$user}</username><password>{$userpass}</password><file>/db/resources/commons/Priya Paul Collection/w_000197f8-4f11-5c63-9967-678e75fa6e41.xml</file><file>/db/resources/commons/Priya Paul Collection/w_0011205f-7d3d-5e9f-bf36-662a564d10c0.xml</file><file>/db/resources/commons/Priya Paul Collection/w_0021021b-d32f-5661-87b8-fdb303fedb81.xml</file><file>/db/resources/commons/Priya Paul Collection/w_00588d19-9e77-535c-9966-6963817b659e.xml</file><file>/db/resources/commons/Priya Paul Collection/w_006f40aa-59c7-575a-9e96-8acb57a6e338.xml</file><file>/db/resources/commons/Priya Paul Collection/w_007399f9-4f73-55e6-88c7-0674e8aa106b.xml</file></data>
return 
    httpclient:post(xs:anyURI('http://localhost:8080/exist/restxq/ziziphus/group'), $data, false(), ())//httpclient:body/*


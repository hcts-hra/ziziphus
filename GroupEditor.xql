xquery version "3.0";

declare namespace httpclient = "http://exist-db.org/xquery/httpclient";
declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=yes indent=yes";

let $data := <data><file>/db/resources/commons/Priya_Paul_Collection/w_000197f8-4f11-5c63-9967-678e75fa6e41.xml</file><file>/db/resources/commons/Priya_Paul_Collection/w_0011205f-7d3d-5e9f-bf36-662a564d10c0.xml</file><file>/db/resources/commons/Priya_Paul_Collection/w_0021021b-d32f-5661-87b8-fdb303fedb81.xml</file><file>/db/resources/commons/Priya_Paul_Collection/w_00588d19-9e77-535c-9966-6963817b659e.xml</file><file>/db/resources/commons/Priya_Paul_Collection/w_006f40aa-59c7-575a-9e96-8acb57a6e338.xml</file><file>/db/resources/commons/Priya_Paul_Collection/w_007399f9-4f73-55e6-88c7-0674e8aa106b.xml</file></data>

(: TODO: get running host via xquery :)             
let $headers := <headers><header name="myHeader" value="myValue"/></headers>
return 
    httpclient:post(xs:anyURI('http://localhost:8080/exist/restxq/ziziphus/group'), $data, false(), $headers)//httpclient:body/*


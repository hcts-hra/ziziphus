xquery version "3.0";

declare namespace httpclient = "http://exist-db.org/xquery/httpclient";
declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=yes indent=yes";

let $data := <data xmlns="">
                <uuid>w_000197f8-4f11-5c63-9967-678e75fa6e41</uuid>
                <uuid>w_0011205f-7d3d-5e9f-bf36-662a564d10c0</uuid>
                <uuid>w_0021021b-d32f-5661-87b8-fdb303fedb81</uuid>
                <uuid>w_00588d19-9e77-535c-9966-6963817b659e</uuid>
                <uuid>w_006f40aa-59c7-575a-9e96-8acb57a6e338</uuid>
                <uuid>w_007399f9-4f73-55e6-88c7-0674e8aa106b</uuid>
                <uuid>w_0091a862-d8f9-5fd6-a574-c6be1d965687</uuid>
                <uuid>w_00989ac8-f7a1-5940-bc22-e42514a463a2</uuid>
                <uuid>w_00b6ad08-8adc-5142-b4fa-12f701957d2e</uuid>
                <uuid>w_00e2ecfc-54d0-5e0c-8afe-915f188b2e39</uuid>
             </data>
             
let $headers := <headers><header name="myHeader" value="myValue"/></headers>

return 
    httpclient:post(xs:anyURI('http://localhost:8080/exist/restxq/ziziphus/group'), $data, false(), $headers)//httpclient:body/*


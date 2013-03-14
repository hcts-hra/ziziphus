xquery version "3.0";
declare namespace vra="http://www.vraweb.org/vracore4.htm";
declare namespace xf="http://www.w3.org/2002/xforms"; 

let $uuid := request:get-parameter('uuid', 'w_000197f8-4f11-5c63-9967-678e75fa6e41')
let $setname := request:get-parameter('setname', 'agentSet')
let $record := collection('/db/apps/ziziphusData')//vra:vra/*[@id = $uuid]
(: Only the part of the record we are interested in :)
let $snippet := $record//*[local-name() eq $setname]
let $stylesheet := doc('/db/apps/ziziphus/resources/xsl/vra-record.xsl')
return
    transform:transform($snippet, $stylesheet, ())

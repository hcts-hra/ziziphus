xquery version "3.0";
declare namespace vra="http://www.vraweb.org/vracore4.htm";
declare namespace xf="http://www.w3.org/2002/xforms"; 

let $uuid := request:get-parameter('uuid', 'w_000197f8-4f11-5c63-9967-678e75fa6e41')
let $setname := request:get-parameter('setname', 'agentSet')
let $currentform := request:get-parameter('currentform', 'w_Agent')

let $vraWorkRecord  := collection('/db/apps/ziziphusData/priyapaul/files/work')/vra:vra/vra:work[@id = $uuid]
let $imageRecordId  := if(exists($vraWorkRecord/vra:relationSet/vra:relation/@pref[.='true']))
                                then $vraWorkRecord/vra:relationSet/vra:relation[@pref='true']/@relids
                                else $vraWorkRecord/vra:relationSet/vra:relation[1]/@relids
(: Get work or image record depending on currentform :)
let $root  := if (starts-with($currentform, 'w'))
              then ( $vraWorkRecord)
              else ( collection('/db/apps/ziziphusData/priyapaul/files/images')/vra:vra/vra:image[@id = $imageRecordId] )
(: Only the part of the record we are interested in :)
let $snippet := $root//*[local-name() eq $setname]
let $stylesheet := doc('/db/apps/ziziphus/resources/xsl/vra-record.xsl')
return
    transform:transform($snippet, $stylesheet, ())
    


xquery version "3.0";

(: XQuery File used for debug querries :)

declare namespace vra = "http://www.vraweb.org/vracore4.htm";

import module namespace request="http://exist-db.org/xquery/request";

let $uuid        := "w_01"
let $sectionName := "agentSet"

for $agent in collection('ziziphus/data')/vra:vra/vra:work[@id = $uuid]/*[local-name(.)=$sectionName]
    return <div>{$agent}</div>
   

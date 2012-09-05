xquery version "3.0";

declare namespace vra = "http://www.vraweb.org/vracore4.htm";

import module namespace request="http://exist-db.org/xquery/request";
import module namespace system="http://exist-db.org/xquery/system";


system:enable-tracing(true()),
let $contextPath := request:get-context-path()
let $uuid        := request:get-parameter("id", "")
let $sectionName := request:get-parameter("section", "")
let $data        := request:get-data()
let $section     := collection('ziziphus/records')/vra:vra/*[@id = $uuid]/*[local-name(.)=$sectionName]

return
    try {
        update replace $section with $data
    } 
    catch * {
        $err:description
    }
        

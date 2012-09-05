xquery version "3.0";

declare namespace vra = "http://www.vraweb.org/vracore4.htm";

import module namespace request="http://exist-db.org/xquery/request";
import module namespace system="http://exist-db.org/xquery/system";
import module namespace xmldb="http://exist-db.org/xquery/xmldb";

system:enable-tracing(true()),
let $contextPath := request:get-context-path()
let $uuid        := request:get-parameter("id", "")
let $sectionName := request:get-parameter("section", "test")
let $data        := request:get-data()
let $logFile     := collection('ziziphus/data/tracklog')/tracklog/workrecord[@id = $uuid]

let $sectionlog :=  element {$sectionName} { attribute {'id'} {$uuid}, attribute {'status'} {'inProgress'}, attribute {'user'} {xmldb:get-current-user()}, attribute {'date'} {current-date()} } 
let $worklog :=
<tracklog>
   <workrecord id="{$uuid}" status="inProgress" user="{xmldb:get-current-user()}" date="{current-date()}">
        {$sectionlog}
   </workrecord>
</tracklog>
       
return
    if (not($logFile))
       then (
         let $store-return-status := xmldb:store('ziziphus/data/tracklog', concat('tracklog', $uuid), $worklog)
         return
            <message>New Document Created</message>
       )
       else (
         let $document := collection('ziziphus/tracklog')/tracklog/workrecord[@id = $uuid]
         let $update := update insert $sectionlog into $document
         return
            <message>Document has been successfully updated</message>
       )

    

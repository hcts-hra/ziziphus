xquery version "3.0";
import module namespace request="http://exist-db.org/xquery/request";

let $id := request:get-parameter('id','')
let $vraSet := request:get-parameter('set','')

let $foo := util:log('info',concat('id=',$id,' vraSet=',$vraSet))

(: get the new data from the form :)
let $newData := request:get-data()

(: fetch original record from database :)
let $record := collection('/apps/ziziphusData')//*[@id=$id]

(: update old data with new data :)
let $update := update replace $record//*[local-name(.)='agentSet'] with $newData

return $record
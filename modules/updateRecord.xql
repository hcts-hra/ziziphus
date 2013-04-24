xquery version "3.0";
import module namespace request="http://exist-db.org/xquery/request";
declare namespace vra = "http://www.vraweb.org/vracore4.htm";

let $id := request:get-parameter('id','')
let $vraSet := request:get-parameter('set','')

let $foo := util:log('info',concat('id=',$id,' vraSet=',$vraSet))

(: get the new data from the form :)
let $newData := request:get-data()

(: fetch original record from database :)
let $record := collection('/db/apps/ziziphusData')//vra:vra/*[./@id=$id]

(: update old data with new data :)
let $update := update replace $record/*[local-name(.)=$vraSet] with $newData

return $record

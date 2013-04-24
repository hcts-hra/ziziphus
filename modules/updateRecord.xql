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
let $test1 := if(exists($record/*[local-name() eq $vraSet])) 
              then ( update replace $record/*[local-name(.)=$vraSet] with $newData )
              else ( 
                  if(exists($record/*[local-name(.) > $vraSet][1]))
                     then ( update insert $newData preceding $record/*[local-name(.) > $vraSet][1] )
                     else ( update insert $newData following ($record/vra:*[local-name(.) < $vraSet])[last()])
                )
(:   :let $update := update replace $record/*[local-name(.)=$vraSet] with $newData :)

return ""

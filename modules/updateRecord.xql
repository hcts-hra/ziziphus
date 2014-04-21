xquery version "3.0";

declare namespace vra = "http://www.vraweb.org/vracore4.htm";

import module namespace request="http://exist-db.org/xquery/request";
import module namespace app="http://www.betterform.de/projects/ziziphus/xquery/app" at "app.xqm";
import module namespace security="http://exist-db.org/mods/security" at "../../cluster-shared/modules/search/security.xqm";

let $id := request:get-parameter('id','')
let $workdir :=  request:get-parameter('workdir','')
let $workdir := if($workdir eq "") then ($app:record-dir) else ($workdir)
let $vraSet := request:get-parameter('set','')

let $log1 := util:log('info',concat('id=',$id,' vraSet=',$vraSet))

(: get the new data from the form :)
let $newData := request:get-data()

(: fetch original record from database :)
let $record := collection($workdir)//vra:vra/*[./@id=$id]


let $log2 := util:log('info', "RECORD ID: " || data($record/@id))
let $log2 := util:log('info', "WORKDIR: " || $workdir)
let $log3 := util:log("info", "Current user: " || xmldb:get-current-user())
let $log4 := util:log("info", "Can write collection: " || starts-with(data(sm:get-permissions(xs:anyURI(xmldb:encode-uri($workdir)))/sm:permission/@mode), 'rw'))
let $log9 := util:log("info", "Permissions Collection: " ||  sm:get-permissions(xs:anyURI(xmldb:encode-uri($workdir)))/sm:permission/@mode)
let $log10 := util:log("info", "Permissions File: " ||  sm:get-permissions(xs:anyURI(xmldb:encode-uri(util:collection-name($record) || "/" || util:document-name($record))))/sm:permission/@mode)
let $something := security:apply-parent-collection-permissions(xs:anyURI(concat(util:collection-name($record), "/", util:document-name($record))))
let $log11 := util:log("info", "Permissions File: " ||  sm:get-permissions(xs:anyURI(xmldb:encode-uri(util:collection-name($record) || "/" || util:document-name($record))))/sm:permission/@mode)

(: update old data with new data :)
let $update := if(exists($record/*[local-name() eq $vraSet])) 
              then ( 
                    let $log5 := util:log("info", "Update replace!")
                    return 
                        update replace $record/*[local-name(.)=$vraSet] with $newData )
              else ( 
                  if(exists($record/*[local-name(.) > $vraSet][1]))
                     then ( 
                        let $log6 := util:log("info", "Update insert preceding!")
                        return 
                            update insert $newData preceding $record/*[local-name(.) > $vraSet][1] )
                     else ( 
                        let $log7 := util:log("info", "Update insert following!")
                        return 
                            update insert $newData following ($record/vra:*[local-name(.) < $vraSet])[last()])
                )
(:   :let $update := update replace $record/*[local-name(.)=$vraSet] with $newData :)

let $log8 := util:log("info", "Update returned: " || $update)
return ""

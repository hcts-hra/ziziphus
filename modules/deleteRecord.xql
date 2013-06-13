xquery version "3.0";

declare namespace vra = "http://www.vraweb.org/vracore4.htm";

import module namespace request="http://exist-db.org/xquery/request";
import module namespace app="http://www.betterform.de/projects/ziziphus/xquery/app" at "/apps/ziziphus/modules/app.xqm";

declare function local:deleteImageRecords($id as xs:string, $workdir as xs:string, $workrecord) {
let $imageDir as xs:string := $workdir || $app:image-record-dir-name
let $workrecord := collection($workdir)//vra:vra/*[./@id=$id]
let $imagerecordIds := data($workrecord//vra:relationSet//vra:relation[@type = "imageIs"]//@relids)
return
    for $imagerecordId in $imagerecordIds
    let $imagerecord := util:document-name(collection($imageDir)//vra:vra/*[./@id=$imagerecordId])
    let $log := util:log("ERROR", "imagerecordId: " || $imagerecordId || " imageDir: " || $imageDir)
    return
        xmldb:remove($imageDir, $imagerecord)
};


let $id := request:get-parameter('id','')
let $workdir :=  request:get-parameter('workdir','')
let $workdir := if($workdir eq "") then ($app:record-dir) else ($workdir)
let $workrecord := collection($workdir)//vra:vra/*[./@id=$id]
let $log := util:log("ERROR", "id: " || $id || " workdir: " || $workdir)
return
    if(exists($workrecord))
    then (
        let $imageRecords := local:deleteImageRecords($id, $workdir, $workrecord)
        return
            xmldb:remove($workdir, util:document-name($workrecord))
    ) else (
        response:set-status-code( 500 )
    )




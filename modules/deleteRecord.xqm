xquery version "3.0";

module namespace deleteRedcord="http://www.betterform.de/projects/ziziphus/xquery/deleteRedcord";

declare namespace vra = "http://www.vraweb.org/vracore4.htm";

import module namespace request="http://exist-db.org/xquery/request";

declare function deleteRedcord:deleteImageRecords($id as xs:string, $workdir as xs:string, $workrecord) {
let $imageDir as xs:string := $workdir || "VRA_images"
let $workrecord := collection($workdir)//vra:vra/*[./@id=$id]
let $imagerecordIds := data($workrecord//vra:relationSet//vra:relation[@type = "imageIs"]//@relids)
return
    for $imagerecordId in $imagerecordIds
    let $imagerecord := util:document-name(collection($imageDir)//vra:vra/*[./@id=$imagerecordId])
    let $log := util:log("ERROR", "imagerecordId: " || $imagerecordId || " imageDir: " || $imageDir)
    return
        xmldb:remove($imageDir, $imagerecord)
};

declare function deleteRedcord:deleteWorkRecord($id as xs:string, $workdir as xs:string) {
let $log := util:log("ERROR", "Id: " || $id || " imageDir: " || $workdir)
let $workrecord := collection($workdir)//vra:vra/*[./@id=$id]
return
    if(exists($workrecord))
    then (
        let $imageRecords := deleteRedcord:deleteImageRecords($id, $workdir, $workrecord)
        return
            xmldb:remove($workdir, util:document-name($workrecord))
    ) else ()
};








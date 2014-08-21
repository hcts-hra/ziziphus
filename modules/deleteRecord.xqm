xquery version "3.0";

module namespace deleteRedcord="http://www.betterform.de/projects/ziziphus/xquery/deleteRedcord";

declare namespace vra = "http://www.vraweb.org/vracore4.htm";

import module namespace request="http://exist-db.org/xquery/request";
import module namespace record-utils="http://www.betterform.de/projects/ziziphus/xquery/record-utils" at "utils/record-utils.xqm";

declare function deleteRedcord:deleteImageRecords($id as xs:string, $workdir as xs:string, $workrecord) {
let $workrecord := record-utils:get-work-record($id)
let $imageDir as xs:string := record-utils:get-image-record-collection-by-work-record-id($id)
let $imagerecordIds := data($workrecord//vra:relationSet//vra:relation[@type = "imageIs"]//@relids)
return
    for $imagerecordId in $imagerecordIds
    let $imagerecord := util:document-name(collection($imageDir)//vra:vra/*[./@id=$imagerecordId])
    let $log := util:log("INFO", "imagerecordId: " || $imagerecordId || " imageDir: " || $imageDir)
    return
        xmldb:remove($imageDir, $imagerecord)
};

declare function deleteRedcord:deleteWorkRecord($id as xs:string) {
let $log := util:log("INFO", "Id: " || $id || " work-dir: " || $workdir)
let $workrecord := record-utils:get-work-record($id)
return
    if(exists($workrecord))
    then (
        let $imageRecords := deleteRedcord:deleteImageRecords($id, $workdir, $workrecord)
        return
            xmldb:remove($workdir, util:document-name($workrecord))
    ) else ()
};








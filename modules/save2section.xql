xquery version "3.0";

declare namespace vra = "http://www.vraweb.org/vracore4.htm";

import module namespace request="http://exist-db.org/xquery/request";
import module namespace system="http://exist-db.org/xquery/system";
import module namespace app="http://github.com/hra-team/rosids-shared/config/app" at "/apps/rosids-shared/modules/ziziphus/config/app.xqm";


declare %private function local:update($uuid, $sectionName, $data) as xs:boolean {
    let $section     := app:get-resource($uuid)/*[local-name(.)=$sectionName]
    let $update :=
        try {
            let $xupdate := update replace $section with $data
            return true()
        } catch * {
            let $log := util:log("ERROR", "Ziziphus: Update of record " || $uuid || " failed: " || $err:description)
            return false()
        }
};


declare %private function local:dataDate($record) {
    let $transform := "xmldb:exist:///db/apps/ziziphus/resources/xsl/save-dataDate.xsl"
    return
        transform:transform($root, $transform, ())
};

declare %private function local:cleanupData($record) {
    let $transform := "xmldb:exist:///db/apps/ziziphus/resources/xsl/save-cleanup.xsl"
    return
        transform:transform($root, $transform, ())
};

let $contextPath := request:get-context-path()
let $uuid        := request:get-parameter("id", "")
let $sectionName := request:get-parameter("section", "")
let $data        := request:get-data()
let $update := local:update($uuid, $sectionName, $data)
return
    if($update)
    then (
        let $record := app:get-resource($uuid)
        let $dataDate := local:dataDate($record)
        let $cleanup := local:cleanupData($dataDate)
        let $return :=
            try {
                let $store := system:as-user($app:dba-credentials[1], $app:dba-credentials[2], xmldb:store(util:collection-name($record), util:document-name($record), $cleanup) )
                return true()
            catch * {
                let $log := util:log("ERROR", "Ziziphus: Savining of cleaned record " || $uuid || " failed: " || $err:description)
                return false()
            }
        return
            if($return)
            then (
            ) else (
                (: TODO: FAILURE! :)
            )
    ) else (
        (: TODO: FAILURE! :)
    )
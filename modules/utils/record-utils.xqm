xquery version "3.0";

module namespace record-utils="http://www.betterform.de/projects/ziziphus/xquery/record-utils";

declare namespace vra="http://www.vraweb.org/vracore4.htm";

declare %private variable $record-utils:db := "/db";


(: 
    ##### RECORDS #####
    ##### RECORDS #####
    ##### RECORDS #####
:)
declare function record-utils:get-record($record-id) as node() {
    record-utils:get-record($record-id, $record-utils:db)
};

declare function record-utils:get-record($record-id, $base-collection) as node() {
    collection(xmldb:encode($base-collection))//vra:vra/*[@id = $record-id]
};

(: 
    ##### WORK RECORDS #####
    ##### WORK RECORDS #####
    ##### WORK RECORDS #####
:)
declare function record-utils:get-work-record($work-record-id) as node() {
    record-utils:get-work-record($work-record-id, $record-utils:db)
};

declare function record-utils:get-work-record($work-record-id, $base-collection) as node() {
    collection(xmldb:encode($base-collection))//vra:vra/vra:work[@id = $work-record-id]
};

declare function record-utils:get-work-record-collection-by-id($work-record-id) as xs:string {
        record-utils:get-work-record-collection-by-id($work-record-id, $record-utils:db)
};

declare function record-utils:get-work-record-collection-by-id($work-record-id, $base-collection) as xs:string {
    let $record := record-utils:get-work-record($work-record-id, $base-collection)
    return
        util:collection-name($record)
};

declare function record-utils:get-work-record-path-by-id($work-record-id) as xs:string {
    record-utils:get-work-record-path-by-id($work-record-id, $record-utils:db)
};

declare function record-utils:get-work-record-path-by-id($work-record-id, $base-collection) as xs:string {
    let $work-record := record-utils:get-work-record($work-record-id, $base-collection)
    return 
        util:collection-name($work-record) || '/' || util:document-name($work-record)
};

declare function record-utils:delete-work-record($work-record-id) {
    record-utils:delete-work-record($work-record-id, $record-utils:db)
};

declare function record-utils:delete-work-record($work-record-id, $base-collection) {
    let $work-record := collection(xmldb:encode($base-collection))//vra:vra/vra:work[@id = $work-record-id]
    
    return 
        if(exists($work-record))
        then (
            let $log := util:log("INFO", "record-utils:delete-work-record: $work-record-id: " || $work-record-id || " collection: " || util:collection-name($work-record) || " file:" || util:document-name($work-record))
            let $image-records := 
                for $image-record-id in data($work-record//vra:relationSet//vra:relation[@type = "imageIs"]//@relids)
                return 
                    record-utils:delete-image-record($image-record-id)
            return 
                xmldb:remove(util:collection-name($work-record), util:document-name($work-record))
        ) else (
            response:set-status-code(404)      
        ) 
    
};

(: 
    ##### IMAGE RECORDS #####
    ##### IMAGE RECORDS #####
    ##### IMAGE RECORDS #####
:)

declare function record-utils:get-image-record($image-record-id) as node() {
    record-utils:get-work-record($image-record-id, $base-collection)
};

declare function record-utils:get-image-record($image-record-id, $base-collection) as node() {
    collection(xmldb:encode($base-collection))//vra:vra/vra:image[@id = $image-record-id]
};

declare function record-utils:get-image-record-id-by-work-record-id($work-record-id) as xs:string {
    record-utils:get-image-record-id-by-work-record-id($work-record-id, $record-utils:db)
};

declare function record-utils:get-image-record-id-by-work-record-id($work-record-id, $base-collection) as xs:string {
    let $work-record     := collection(xmldb:encode($base-collection))//vra:vra/vra:work[@id = $work-record-id]
    let $image-record-id := if(exists($work-record/vra:relationSet/vra:relation/@pref[.='true']))
                            then $work-record/vra:relationSet/vra:relation[@pref='true']/@relids
                            else $work-record/vra:relationSet/vra:relation[1]/@relids
    return
        $image-record-id
};

declare function record-utils:get-image-record-collection-by-id($image-record-id) as xs:string {
        record-utils:get-image-record-collection-by-id($image-record-id, $record-utils:db) 
};

declare function record-utils:get-image-record-collection-by-id($image-record-id, $base-collection) as xs:string {
        util:collection-name(record-utils:get-image-record($image-record-id, $base-collection))
};

declare function record-utils:get-image-record-collection-by-work-record-id($work-record-id) as xs:string {
        record-utils:get-image-record-collection-by-work-record-id($work-record-id, $record-utils:db)
};

declare function record-utils:get-image-record-collection-by-work-record-id($work-record-id, $base-collection) as xs:string {
    let $image-record-id := record-utils:get-image-record-id-by-work-record-id($work-record-id, $base-collection)
    let $image-record := collection(xmldb:encode($base-collection))//vra:vra/vra:image[@id = $image-record-id]
    return 
        util:collection-name($image-record)
};

declare function record-utils:get-image-record-path-by-work-record-id($work-record-id) as xs:string {
    record-utils:get-image-record-path-by-work-record-id($work-record-id, $record-utils:db)
};

declare function record-utils:get-image-record-path-by-work-record-id($work-record-id, $base-collection) as xs:string {
    let $image-record-id := record-utils:get-image-record-id-by-work-record-id($work-record-id, $base-collection)
    let $image-record    := collection(xmldb:encode($base-collection))//vra:vra/vra:image[@id = $image-record-id]
    return 
        util:collection-name($image-record) || '/' || util:document-name($image-record)
};


declare function record-utils:get-image-record-path-by-id($image-record-id) as xs:string {
    record-utils:get-image-record-path-by-id($image-record-id, $record-utils:db)
};

declare function record-utils:get-image-record-path-by-id($image-record-id, $base-collection) as xs:string {
    let $image-record := collection($base-collection)//vra:vra/vra:image[@id = $image-record-id]
    return 
        util:collection-name($image-record) || '/' || util:document-name($image-record)
};

declare function record-utils:delete-image-record($image-record-id) {
    record-utils:delete-image-record($image-record-id, $record-utils:db)
};

declare function record-utils:delete-image-record($image-record-id, $base-collection) {
    let $image-record := collection($base-collection)//vra:vra/vra:image[@id = $image-record-id]
    
    return
        if(exists($image-record))
        then (
            let $log := util:log("INFO", "record-utils:delete-image-record: $image-record-id: " || $image-record-id || " collection: " || util:collection-name($image-record) || " file:" || util:document-name($image-record))
            return
                xmldb:remove(util:collection-name($image-record), util:document-name($image-record))
        ) else (
            response:set-status-code(404)      
        ) 
};
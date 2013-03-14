xquery version "3.0";

declare default element namespace "http://www.w3.org/1999/xhtml";
declare namespace vra = "http://www.vraweb.org/vracore4.htm";
declare namespace xs = "http://www.w3.org/2001/XMLSchema";

import module namespace v = "http://exist-db.org/versioning";

declare option exist:serialize "method=xhtml media-type=application/xhtml+xml";

declare variable $uuid as xs:string := request:get-parameter("uuid", "NONE");

(: Change here location of collections to adjust to your installation layout. :)
declare variable $ziziphusDataRoot as xs:string := "/db/apps/ziziphusData";
declare variable $collectionPath as xs:string := $ziziphusDataRoot || "/priyapaul/files";
declare variable $workPath as xs:string := $collectionPath || "/work";
declare variable $imagesPath as xs:string := $collectionPath || "/images";

declare function local:makeWorkPath($uuid as xs:string) {
    $workPath || "/" || $uuid || ".xml"
};

declare function local:makeImagePath($imageId as xs:string) {
    $imagePath || "/" || $imageId || ".xml"
};

declare function local:showHistory($uuid as xs:string) {
    let $workDoc := doc($workPath || "/" || $uuid || ".xml") return
    if ($workDoc) then (
        <div> {
        local:showFileHistory($workDoc)
        } </div>,
        for $imageId in $workDoc/vra:vra/vra:work/vra:relationSet/vra:relation[@type="imageIs"]/@relids
        return <p style="color:red">{xs:string($imageId)}</p>
    ) else
        <p class="warning">No document for uuid <strong>{$uuid}</strong></p>
};

declare function local:showFileHistory($doc as document-node()) {
    v:history($doc)
};

(: main :)
<html>
    <head>
        <title>Versions listing for ...</title>
    </head>
    <body>
        <h1>Versions listing for uuid {$uuid}</h1>
        <div> {
            local:showHistory($uuid)
        } </div>
    </body>
</html>

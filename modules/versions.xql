xquery version "3.0";

declare namespace vra = "http://www.vraweb.org/vracore4.htm";
declare namespace xs = "http://www.w3.org/2001/XMLSchema";

import module namespace v = "http://exist-db.org/versioning";

declare option exist:serialize "method=xhtml media-type=application/xhtml+xml";

declare variable $uuid as xs:string? := request:get-parameter("uuid", ());

(: Change here location of collections to adjust to your installation layout. :)
declare variable $ziziphusRoot as xs:string := "/db/apps/ziziphus";
declare variable $ziziphusDataRoot as xs:string := "/db/apps/ziziphusData";
declare variable $urlRoot as xs:string := "/exist/apps/ziziphusData";
declare variable $filesPath as xs:string := "/priyapaul/files";
declare variable $xsl as xs:string := $ziziphusRoot || "/resources/xsl/versions.xsl";

declare function local:makeWorkPath($uuid as xs:string) {
    $ziziphusDataRoot || $filesPath || "/work/" || $uuid || ".xml"
};

declare function local:makeImagePath($imageId as xs:string) {
    $ziziphusDataRoot || $filesPath || "/images/" || $imageId || ".xml"
};

declare function local:makeWorkURL($uuid as xs:string) {
    $urlRoot || $filesPath || "/work/" || $uuid || ".xml"
};

declare function local:makeImageURL($imageId as xs:string) {
    $urlRoot || $filesPath || "/images/" || $imageId || ".xml"
};

declare function local:createXmlResult($uuid as xs:string?) {
    <result uuid="{$uuid}"> {
        if (not($uuid)) then
            <error>No uuid given.</error>
        else
            let $wURL := local:makeWorkURL($uuid)
            let $wPath := local:makeWorkPath($uuid)
            let $wDoc := doc($wPath)
            return
            if (not($wDoc)) then
                <error>No document for uuid {$uuid}.</error>
            else (
                <work id="{$uuid}" path="{$wPath}" url="{$wURL}"> {
                    v:history($wDoc)
                } </work>,
                for $imageId in xs:string($wDoc/vra:vra/vra:work/vra:relationSet/vra:relation[@type="imageIs"]/@relids)
                return
                let $iURL := local:makeImageURL($imageId)
                let $iPath := local:makeImagePath($imageId)
                let $iDoc := doc($iPath)
                return
                    <image id="{$imageId}" path="{$iPath}" url="{$iURL}"> {
                        v:history($iDoc)
                    } </image>
            )
    } </result>
};

(: main :)
let $result := local:createXmlResult($uuid)
return transform:transform($result, doc($xsl), ())

xquery version "3.0";

declare namespace vra = "http://www.vraweb.org/vracore4.htm";
declare namespace xs = "http://www.w3.org/2001/XMLSchema";

import module namespace v = "http://exist-db.org/versioning";

declare option exist:serialize "method=xhtml media-type=application/xhtml+xml";

(: This query obtains and presents version history of a given file stored by eXists-DB version tracking mechanism. :)
(: The file to be presented can be identified by one of the followinf methods,
 : for each there is a corresponding HTTP query parameter. :)

(: Called in AJAX mode? (then raw HTML content to be pasted into a div returned, otherwise a regular HTML document is generated) :)
declare variable $ajax as xs:string := request:get-parameter("ajax", "no");

(: Record id :)
declare variable $rid as xs:string? := request:get-parameter("rid", ());

(: Image id :)
declare variable $iid as xs:string? := request:get-parameter("iid", ());

(: Relative path, inside collection :)
declare variable $relPath as xs:string? := request:get-parameter("rel_path", ());

(: Absolute path to file :)
declare variable $absPath as xs:string? := request:get-parameter("path", ());

(: Change here location of collections to adjust to your installation layout. :)
declare variable $ziziphusRoot as xs:string := "/db/apps/ziziphus";
declare variable $ziziphusDataRoot as xs:string := "/db/apps/ziziphusData";
declare variable $urlRoot as xs:string := "/exist/apps/ziziphusData";
declare variable $filesPath as xs:string := "/priyapaul/files";
declare variable $xsl as xs:string := $ziziphusRoot || "/resources/xsl/versions.xsl";

declare function local:makePathFromArgs() as xs:string ? {
    if($absPath)
      then $absPath
    else if($relPath)
      then $ziziphusDataRoot || $relPath
    else if($rid)
      then $ziziphusDataRoot || $filesPath || "/work/" || $rid || ".xml"
    else if($iid)
      then $ziziphusDataRoot || $filesPath || "/images/" || $iid || ".xml"
    else ()
};

declare function local:createXmlResult($path as xs:string?) as element() {
    <result> {
        if (not($path)) then
            <error>No path given.</error>
        else
            let $doc := doc($path)
            let $url := $path (:FIXME:)
            return
            if (not($doc)) then
                <error>No document for path {$path}.</error>
            else (
                <file path="{$path}" url="{$url}"> {
                    v:history($doc)
                } </file>
            )
    } </result>
};

(: main :)
let $path := local:makePathFromArgs()
let $result := local:createXmlResult($path)
let $xsltParameters := <parameters><param name="ajax" value="{$ajax}"/></parameters>
return transform:transform($result, doc($xsl), $xsltParameters)

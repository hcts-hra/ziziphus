xquery version "3.0";

(: @author Patryk Czarnik
 : For a given resource (work or image record) this script generates
 : a list of versions stored by eXists-DB version tracking mechanism
 : and presents it as a HTML table using versions.xsl stylesheet.
 :)

declare namespace vra = "http://www.vraweb.org/vracore4.htm";
declare namespace xs = "http://www.w3.org/2001/XMLSchema";

import module namespace v = "http://exist-db.org/versioning";
import module namespace app="http://www.betterform.de/projects/ziziphus/xquery/app" at "app.xqm";

declare option exist:serialize "method=xhtml media-type=application/xhtml+xml";

(:** External parameters **:)
(: Called in AJAX mode? (then returns raw HTML content to be pasted into a div returned, otherwise a regular HTML document is generated) :)
declare variable $ajax as xs:string := request:get-parameter("ajax", "no");

(: The file to be presented can be identified by one of the following methods,
 : for each there is a corresponding HTTP query parameter. :)

(: Record id :)
declare variable $rid as xs:string? := request:get-parameter("rid", ());

(: Image id :)
declare variable $iid as xs:string? := request:get-parameter("iid", ());

(: Change here location of collections to adjust to your installation layout. :)
declare variable $ziziphusRoot as xs:string := $app:app-dir;
declare variable $ziziphusDataRoot as xs:string := $app:data-dir;
declare variable $defaultPath as xs:string := $app:record-dir;
declare variable $urlBase as xs:string := "/exist/rest/";
declare variable $xsl as xs:string := $app:app-resources-dir || "xsl/versions.xsl";

(: Absolute path of resource on server :)
declare variable $absPath as xs:string? := request:get-parameter("resource", ());
declare variable $filesPath as xs:string? := request:get-parameter("workdir", $defaultPath);

declare function local:makePathFromArgs() as xs:string ? {
    if($absPath)
      then $absPath
    else if($rid)
      then $filesPath || $rid || ".xml"
    else if($iid)
      then $filesPath || $app:image-record-dir-name || $iid || ".xml"
    else ()
};

declare function local:createXmlResult($path as xs:string?) as element() {
    <result> {
        if (not($path)) then
            <error>No path given.</error>
        else
            let $doc := doc($path)
            let $url := $urlBase || $path
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

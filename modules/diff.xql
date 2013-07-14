xquery version "3.0";

(: @author Patryk Czarnik
 : Script calculates and presents differences between two versions of a (work or image) record.
 :)

declare namespace diffs = "http://betterform.de/ziziphus/diff";
declare namespace vra = "http://www.vraweb.org/vracore4.htm";
declare namespace xs = "http://www.w3.org/2001/XMLSchema";

import module namespace v = "http://exist-db.org/versioning";

(:** External parameters **:)
(: Resource path :)
declare variable $resource as xs:string? := request:get-parameter("resource", ());
  
(: Version number of older document :)
declare variable $rev1 as xs:string := request:get-parameter("rev1", "0");

(: Version number of newer document :)
declare variable $rev2 as xs:string :=  request:get-parameter("rev2", "last");

(:** Settings **:)
(: By default (false()) elements/attributes that are missing in both compared documents are not presented.
 : Change to true() to allow missing optional elements (but specified in schema and template instance) in the result.
 :)
declare variable $showMissingElements := false();
declare variable $showMissingAttributes := false();

declare variable $recursiveDiff := false();

(: Format of result.
 : Available values:
 : * html (default) - use XSLT to convert result to HTML,
 : * xml - return raw XML result (with diff annotations).
 :)
declare variable $format := request:get-parameter("format", "html");

(: Change here location of collections to adjust to your installation layout. :)
declare variable $ziziphusRoot as xs:string := "/db/apps/ziziphus";
declare variable $ziziphusDataRoot as xs:string := "/db/apps/ziziphusData";
declare variable $urlRoot as xs:string := "/exist/apps/ziziphusData";
declare variable $filesPath as xs:string := "/priyapaul/files";
declare variable $xsl as xs:string := $ziziphusRoot || "/view-diff/root.xsl";

declare variable $instance-path as xs:string := '../resources/xsd/vra-instance.xml';

declare function local:obtain-document($resource-path as xs:string, $rev as xs:string) as document-node() {
    if($rev = 'last')
    then
        doc($resource-path)
    else
        let $rev-no := xs:integer($rev)
        return document {v:doc(doc($resource-path), $rev-no)}
};

declare function local:elementDiffStatus($doc1-node as node()?, $doc2-node as node()?) as xs:string {
    let $n1 as xs:integer := count($doc1-node)
    let $n2 as xs:integer := count($doc2-node)
    return
        if($n1 = 0 and $n2 = 0) then 'missing'
        else if($n1 = 1 and $n2 = 0) then 'deleted'
        else if($n1 = 0 and $n2 = 1) then 'inserted'
        else if($n1 = 1 and $n2 = 1) then 'both'
        else 'shouldNeverHappen'
};

declare function local:text-diff($doc1-nodes as node()*, $doc2-nodes as node()*) as node()* {
    let $txt1 := string($doc1-nodes)
    let $txt2 := string($doc2-nodes)
    return
        if($txt1 = $txt2)
        then text {$txt1}
        else (
            if($txt1) then
                <diffs:del>{text {$txt1}}</diffs:del>
            else (),
            if($txt2) then
                <diffs:ins>{text {$txt2}}</diffs:ins>
            else ()
        )
};

declare function local:element-diff($template-node as node(), $doc1-node as node()?, $doc2-node as node()?) as node() {
    let $status := local:elementDiffStatus($doc1-node, $doc2-node) return
    element {node-name($template-node)} {
        attribute diffs:element-change { $status },
        if ($status = 'both' or $recursiveDiff)
        then (
            local:attr-diff($template-node, $doc1-node, $doc2-node),
            let $subelements := $template-node/* return
            if(count($subelements) = 0) (: leaf; may contain text data :)
            then local:text-diff($doc1-node/node(), $doc2-node/node())
            else (: element content :)
                for $subelement in $subelements
                let $name := node-name($subelement)
                let $doc1-children := $doc1-node/*[node-name(.) = $name]
                let $doc2-children := $doc2-node/*[node-name(.) = $name]
                let $minimalN := if($showMissingElements) then 1 else 0
                let $n := max(($minimalN, count($doc1-children), count($doc2-children)))
                for $i in (1 to $n)
                    let $doc1-child := $doc1-children[$i]
                    let $doc2-child := $doc2-children[$i]
                    return (local:element-diff($subelement, $doc1-child, $doc2-child))
        ) else if($status = 'deleted') then (
            $doc1-node/node()
        ) else if($status = 'inserted') then (
            $doc2-node/node()
        ) else if($showMissingElements) then (
            $template-node/node()
        ) else ()
    }
};

(: TODOs:
 : * heidicon extensions
 : * error handling
 :   - missing document or revision
 :)

declare function local:attr-diff($template as element(), $elem1 as element()?, $elem2 as element()?) as node()* {
    let $attrs1 := $elem1/@*
    let $attrs2 := $elem2/@*
    (: let $all-names := (for $a in $attrs1 | $attrs2 return node-name($a)) :)
    let $all-names := (for $a in $template/@* return node-name($a))
    let $names := distinct-values($all-names)
    for $name in $names
    let $attr1 := $attrs1[node-name(.) = $name]
    let $attr2 := $attrs2[node-name(.) = $name]
    let $val1 := string($attr1)
    let $val2 := string($attr2)
    return
        if($showMissingAttributes or $attr1 or $attr2)
        then
            <diffs:attr name="{$name}">{
                if(not($attr1 or $attr2)) then
                    attribute none {""}
                else if($val1 eq $val2) then
                    attribute both {string($attr1)}
                else (
                    if($attr1) then attribute before {$val1} else (),
                    if($attr2) then attribute after  {$val2} else ()
                )
            }</diffs:attr>
        else ()
};

declare function local:document-diff($template as document-node(), $doc1 as document-node(), $doc2 as document-node()) as document-node() {
    document {
    local:element-diff($template/*, $doc1/*, $doc2/*)
    }
};

(: main :)
let $template := doc($instance-path)
let $doc1 := local:obtain-document($resource, $rev1)
let $doc2 := local:obtain-document($resource, $rev2)
let $result := local:document-diff($template, $doc1, $doc2)
return
    switch ($format)
    case "xml" return $result
    case "html" return
        (:FIXME Just to remember how to pass a param ti XSLT. :)
        let $xsltParameters := <parameters><param name="a" value="'a'"/></parameters>
        return transform:transform($result, doc($xsl), $xsltParameters) 
   default return ()

xquery version "3.0";


(: 
  Load one specific vra set from record given by id param and merge it with template instance.
  The template instance will be send as post data to this query. The rootnode of that instance
  will determine the vra set to be loaded.
:)

declare namespace exist = "http://exist.sourceforge.net/NS/exist";
declare namespace xmldb="http://exist-db.org/xquery/xmldb";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace vra="http://www.vraweb.org/vracore4.htm";
declare namespace merge="http://www.betterform.de/merge";

import module namespace app="http://www.betterform.de/projects/ziziphus/xquery/app" at "app.xqm";

declare option exist:serialize "method=xml media-type=text/xml indent=yes";

declare function local:getSetData($id as xs:string,$setName as xs:string, $workdir as xs:string) as node() * {
    let $record := collection($workdir)//vra:vra/*[@id = $id]
    for $set in $record//vra:*[local-name()=$setName]
    return $set
};
declare function local:mergeVraRecord($root as node()) as node() {
    let $transform := "xmldb:exist:///db/apps/ziziphus/resources/xsl/mergeData.xsl"
    
    return
        transform:transform($root, $transform, ())
};

declare function local:mergeXMLFragments($templateInstance as node(), $data as node()) as node() {
    <merge:data>
        <merge:templateInstance>
            {$templateInstance}
        </merge:templateInstance>
        <merge:importInstance>
            {$data}
        </merge:importInstance>
    </merge:data>
};


(: the id of a vra record :)
let $id := request:get-parameter('id', 'w_000197f8-4f11-5c63-9967-678e75fa6e41')
let $workdir :=  request:get-parameter('workdir','')
let $workdir := if($workdir eq "") then ($app:record-dir) else ($workdir)


(: the post data will contain the template instance to be merged with the (potentially) incomplete dataset in the database :)
let $templateInstance := request:get-data()

(: the name of the set to be loaded is determined by the root element of the template instance :)

let $setName := local-name($templateInstance/*[1])
let $data := local:getSetData($id,$setName, $workdir)
let $data2process := local:mergeXMLFragments($templateInstance, $data) 

return 
local:mergeVraRecord($data2process)

    


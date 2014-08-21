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

import module namespace app="http://www.betterform.de/projects/shared/config/app" at "/apps/cluster-shared/modules/ziziphus/config/app.xqm";
import module namespace record-utils="http://www.betterform.de/projects/ziziphus/xquery/record-utils" at "utils/record-utils.xqm";
import module namespace security="http://exist-db.org/mods/security" at "../../cluster-shared/modules/search/security.xqm";

declare option exist:serialize "method=xml media-type=text/xml indent=yes";


declare variable $user := security:get-user-credential-from-session()[1];
declare variable $userpass := security:get-user-credential-from-session()[2];

declare function local:getSetData($id as xs:string,$setName as xs:string) as node() * {
    (: let $log := util:log("info", "LoadData getSetData") :)
    let $record := system:as-user($user, $userpass, 
        (   
            let $temp := 
                try {
                record-utils:get-record($id)    
                } catch * {
                    let $log := util:log("info", "record-utils:get-record failed! <"|| $err:code ||'>:<'|| $err:description ||'>:<'|| $err:value || '>')
                    return <error>$err:description</error>
                }
            (: let $log := util:log("info", "LoadData getSetData record:" || count($temp)) :)
            for $set in $temp//vra:*[local-name()=$setName]
                return $set
        )
    )
    (: let $log := util:log("info", "LoadData getSetData:" || count($record)) :)
    return $record
};

declare function local:mergeVraRecord($root as node()) as node() {
    let $transform := "xmldb:exist:///db/apps/ziziphus/resources/xsl/mergeData.xsl"
    
    return
        transform:transform($root, $transform, ())
};

declare function local:mergeXMLFragments($templateInstance as node(), $data as node()) as node() {
(: 
    let $log := util:log("info", "LoadData mergeXMLFragments templateInstance: " || count($templateInstance))
    let $log := util:log("info", "LoadData mergeXMLFragments data: " || count($data))
    return
:)
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
let $id := request:get-parameter('id', 'w_311e183b-9555-5f64-a63c-3df244db63d0')
(: let $log := util:log("info", "LoadData id: " || $id) :)
(: the post data will contain the template instance to be merged with the (potentially) incomplete dataset in the database :)
let $templateInstance := request:get-data()
(: the name of the set to be loaded is determined by the root element of the template instance :)
let $setName := local-name($templateInstance/*[1])
(: let $log := util:log("info", "LoadData setName: " || $setName) :)

let $data := local:getSetData($id, $setName)
let $data := if($data) then $data else $templateInstance
let $data2process := local:mergeXMLFragments($templateInstance, $data)
return 
    local:mergeVraRecord($data2process)
    
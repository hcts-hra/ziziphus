xquery version "3.0";
(:~
 : Templating functions for the main page of Ziziphus
 :)
module namespace main="http://exist-db.org/xquery/apps/ziziphus";

declare namespace ev="http://www.w3.org/2001/xml-events";
declare namespace vra="http://www.vraweb.org/vracore4.htm";
declare namespace bf="http://betterform.sourceforge.net/xforms";
declare namespace bfc="http://betterform.sourceforge.net/xforms/controls";
declare namespace xf="http://www.w3.org/2002/xforms"; 

import module namespace config="http://exist-db.org/xquery/apps/config" at "config.xqm";
import module namespace app="http://www.betterform.de/projects/ziziphus/xquery/app" at "app.xqm";
import module namespace templates="http://exist-db.org/xquery/templates";

declare %templates:wrap %templates:default("workdir", "") function main:createVraRecord($node as node()*, $model as map(*), $id as xs:string?, $workdir as xs:string) {
    let $uuid := $id
    let $workRecordDir as xs:string := if($workdir eq "") then ($app:record-dir) else ($workdir)
    let $imageDir as xs:string := $workRecordDir || $app:image-record-dir-name
    let $vraWorkRecord  := collection($workRecordDir)/vra:vra/vra:work[@id = $uuid]
    let $imageRecordId  := if(exists($vraWorkRecord/vra:relationSet/vra:relation/@pref[.='true']))
                                then $vraWorkRecord/vra:relationSet/vra:relation[@pref='true']/@relids
                                else $vraWorkRecord/vra:relationSet/vra:relation[1]/@relids
     let $vraImageRecord := collection($imageDir)/vra:vra/vra:image[@id = $imageRecordId]
     let $resultMap := map:new(($model,map{
                            "workRecord":= $vraWorkRecord,
                            "uuid":= $uuid,
                            "imageRecordId":= $imageRecordId,
                            "vraImageRecord":= $vraImageRecord                
            }))
    return
        templates:process($node/node(),$resultMap)
        
};


declare 
function main:getid($node as node()*, $model as map(*)) {
   <div id="heidiconWindow" current="{$model('uuid')}"></div>
};

declare %templates:wrap function main:displayWorkRecord($node as node()*, $model as map(*)) {
    let $vraWorkRecord := $model("workRecord")
    let $uuid := $model("uuid")
    (: templates:process($node/node(),$resultMap) :)
    return
        if (exists($vraWorkRecord))
        then (
            main:transformVraRecord($vraWorkRecord, $uuid, 'work')
            ) else (
            <div/>
        )
};

declare %templates:wrap function main:displayImageArea($node as node()*, $model as map(*)) {
    <div class="imagePanel">
        {
            let $vraWorkRecord := $model("workRecord")
            return
                if (exists($vraWorkRecord))
                then (
                    for $image in $vraWorkRecord/vra:relationSet
                    let $imageId  := if(exists($vraWorkRecord/vra:relationSet/vra:relation/@pref[.='true']))
                                     then $vraWorkRecord/vra:relationSet/vra:relation[@pref='true'][1]/@relids
                                     else $vraWorkRecord/vra:relationSet/vra:relation[1]/@relids
                    return
                        <img src="http://kjc-ws2.kjc.uni-heidelberg.de/images/service/download_uuid/{$imageId}" alt="" class="relatedImage"/>
                    ) else ()
        }
    </div>
};

declare %templates:wrap function main:displayImageRecord($node as node()*, $model as map(*)) {
    let $vraImageRecord := $model("vraImageRecord")
    let $imageRecordId := $model("imageRecordId")
    return
    if (exists($vraImageRecord))
    then (
        main:transformVraRecord($vraImageRecord, $imageRecordId, 'image')
    ) else (
        <div/>
    )
};


declare %private function main:transformVraRecord($root as node(), $id as xs:string, $vraRecordType as xs:string) {
    let $parameters := <parameters>
                        <param  name="recordType" value="{$vraRecordType}"/>
                        <param name="recordId" value="{$id}"/>
                    </parameters>
    let $transform := transform:transform($root, doc($app:app-resources-dir ||  "/xsl/vra-record.xsl"), $parameters)
    return
        $transform
};


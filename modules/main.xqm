(:~
 : Templating functions for the main page of Ziziphus
 :)
module namespace main="http://exist-db.org/xquery/apps/ziziphus";

import module namespace config="http://exist-db.org/xquery/apps/config" at "config.xqm";

import module namespace templates="http://exist-db.org/xquery/templates";
declare namespace ev="http://www.w3.org/2001/xml-events";
declare namespace vra="http://www.vraweb.org/vracore4.htm";
declare namespace bf="http://betterform.sourceforge.net/xforms";
declare namespace bfc="http://betterform.sourceforge.net/xforms/controls";
declare namespace xf="http://www.w3.org/2002/xforms"; 


declare %templates:wrap function main:createVraRecord($node as node()*, $model as map(*), $id as xs:string?) {
    let $uuid := $id
    let $vraWorkRecord  := collection('/db/apps/ziziphusData/priyapaul/files/work')/vra:vra/vra:work[@id = $uuid]
    let $imageRecordId  := if(exists($vraWorkRecord/vra:relationSet/vra:relation/@pref[.='true']))
                                then $vraWorkRecord/vra:relationSet/vra:relation[@pref='true']/@relids
                                else $vraWorkRecord/vra:relationSet/vra:relation[1]/@relids
     let $vraImageRecord := collection('/db/apps/ziziphusData/priyapaul/files/images')/vra:vra/vra:image[@id = $imageRecordId]
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
        main:transformVraRecord($vraWorkRecord, $uuid, 'work')

};

declare %templates:wrap function main:displayImageArea($node as node()*, $model as map(*)) {
    <div class="imagePanel">
        {
            let $vraWorkRecord := $model("workRecord")            
            for $image in $vraWorkRecord/vra:relationSet
            let $imageId := substring($image/vra:relation/@relids,3)
            return
                <img src="http://kjc-ws2.kjc.uni-heidelberg.de:83/images/service/download_uuid/priya_paul/{$imageId}.jpg" alt="" class="relatedImage"/>
            
        }
    </div>
};

declare 
%templates:wrap 
function main:displayImageRecord($node as node()*, $model as map(*)) {
        let $vraImageRecord := $model("vraImageRecord")            
        let $imageRecordId := $model("imageRecordId")            
        return 
            main:transformVraRecord($vraImageRecord, $imageRecordId, 'image')
};




declare %private function main:transformVraRecord($root as node(), $id as xs:string, $vraRecordType as xs:string) {
        let $parameters := <parameters>
                                <param  name="type" value="{$vraRecordType}"/>
                                <param  name="recordId" value="{$id}"/>
                            </parameters>
        return
            transform:transform($root, doc("/db/apps/ziziphus/resources/xsl/vra-record.xsl"), $parameters)
};


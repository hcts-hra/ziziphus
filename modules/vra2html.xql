module namespace vra2html="http://exist-db.org/xquery/vra2html";

import module namespace request="http://exist-db.org/xquery/request";
import module namespace transform = "http://exist-db.org/xquery/transform";

declare namespace vra = "http://www.vraweb.org/vracore4.htm";

declare function vra2html:createVraRecords($uuid as xs:string) {
     let $vraWorkRecord  := collection('ziziphus/records')/vra:vra/vra:work[@id = concat('w_',$uuid)]
     let $imageRecordId  := if(exists($vraWorkRecord/vra:relationSet/vra:relation/@pref[.='true']))
                                then $vraWorkRecord/vra:relationSet/vra:relation[@pref='true']/@relids
                                else $vraWorkRecord/vra:relationSet/vra:relation[1]/@relids
     let $vraImageRecord := collection('ziziphus/records')/vra:vra/vra:image[@id = $imageRecordId]
     let $vraImageId    := $vraImageRecord/@refid
     return
         
        <div id="mainpanel" data-dojo-type="dijit.layout.BorderContainer" data-dojo-props="design:'sidebars', gutters:true">
            <!--  render work record -->
            {vra2html:transformVraRecord($vraWorkRecord, concat('w_',$uuid), 'work')}
            
            <!-- render image according to image record -->
            <div id="imagepane" data-dojo-type="dijit.layout.ContentPane" data-dojo-props="region:'center'">
                <div style="color:black;background:white;display:none;">
                    <div>Debug Output</div>                    
                    <div><span>UUID:</span><span>{$uuid}</span></div>
                    <div><span>WorkRecord:</span><span>{$vraWorkRecord}</span></div>
                    <div><span>WorkRecord ID:</span><span>{$vraWorkRecord/@id}</span></div>
                    <div><span>relids ID:</span><span>{$vraWorkRecord/vra:relationSet/vra:relation[1]/@relids}</span></div>
                    <div><span>ImageRecord ID:</span><span>{$imageRecordId}</span></div>
                    <div><span>ImageRecord:</span><span>{$vraImageRecord}</span></div>
                    <span><span>vraImageId:</span><span>{$vraImageId}</span></span>
                </div>
                <div class="currentImage">
                    <a href="records/{concat($vraImageId,'-big.jpg')}" target="_blank">
                        <img id="vraImage" src="records/{concat($vraImageId,'.jpg')}" alt="image title" />
                    </a>
                </div>
                
            </div>
            <!-- render image record -->
            {vra2html:transformVraRecord($vraImageRecord, $imageRecordId, 'image')}
            
        </div>
};

declare function vra2html:transformVraRecord($root as node(), $id as xs:string, $vraRecordType as xs:string) {

        let $parameters := <parameters>
                                <param  name="type" value="{$vraRecordType}"/>
                                <param  name="recordId" value="{$id}"/>
                            </parameters>
        return
            transform:transform($root, doc("/db/ziziphus/resources/xsl/vra-record.xsl"), $parameters)
};


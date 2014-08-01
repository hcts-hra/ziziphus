 
xquery version "3.0";

module namespace vraGroupEditor = "http://exist-db.org/xquery/vraGroupEditor";

import module namespace rest = "http://exquery.org/ns/restxq";
import module namespace app="http://www.betterform.de/projects/shared/config/app" at "/apps/cluster-shared/modules/ziziphus/config/app.xqm";
import module namespace csconfig="http://exist-db.org/mods/config" at "/apps/cluster-shared/modules/config.xqm";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare namespace vra="http://www.vraweb.org/vracore4.htm";

declare %private function vraGroupEditor:extract-uuids($body) {
    let $files:= $body//file
    for $file in $files
    return data(doc($file)//vra:work/@id)
};

declare
%rest:POST("{$body}")
%output:method("html5")
%rest:path("/ziziphus/group")    
function vraGroupEditor:init($body ) {
      let $uuids := vraGroupEditor:extract-uuids($body)
      return
        <html>
            <head>
                <title>Ziziphus Image DB - Group editor</title>
                <link rel="stylesheet" type="text/css" href="/exist/apps/ziziphus/resources/css/bootstrap.min.css"/>
                <link rel="stylesheet" type="text/css" href="/exist/apps/ziziphus/resources/css/layout.css"/>
                <link rel="stylesheet" type="text/css" href="/exist/apps/ziziphus/resources/css/record.css"/>
                <link rel="stylesheet" type="text/css" href="/exist/apps/ziziphus/resources/script/mingos-uwindow/themes/ziziphus/style.css"/>
                <link rel="stylesheet" type="text/css" href="/exist/apps/ziziphus/resources/script/layout-default-latest.css"/>
                <link rel="stylesheet" type="text/css" href="/exist/apps/ziziphus/resources/css/jquery-ui.css"/>
                <link rel="stylesheet" type="text/css" href="/exist/apps/cluster-shared/resources/css/autocomplete.css"/>
                <link rel="stylesheet" type="text/css" href="/exist/apps/ziziphus/resources/css/group.css"/>
            </head>
            <body>
                <div class="ui-layout-center outer-center">
                    <div class="full" style="height:100%">
                        <iframe id="iEditor" src="/exist/apps/ziziphus/record.html?id={$uuids[1]}&amp;workdir={$app:ziziphus-default-record-dir}"></iframe>
                    </div>
                </div>
                <div class="ui-layout-south outer-south">
                    <div class="scroll-pane ui-widget ui-widget-header ui-corner-all">
                        <ul class="scroll-content">
                            {vraGroupEditor:thumBar($uuids)}
                        </ul>
                    </div>
                     <div class="scroll-bar-wrap ui-widget-content ui-corner-bottom" style="overflow:hidden;">
                        <div class="scroll-bar"></div>
                    </div>
                </div>
            
                <script type="text/javascript" src="/exist/apps/ziziphus/resources/script/jquery-1.9.1.js"/>
                <script type="text/javascript" src="/exist/apps/ziziphus/resources/script/jquery-ui-1.10.2.custom.min.js"/>
                <script type="text/javascript" src="/exist/apps/ziziphus/resources/script/jquery.layout-latest.min.js"/>
                <script type="text/javascript" src="/exist/apps/ziziphus/resources/script/group/group.js"/> 
            </body>
        </html>
};

declare function vraGroupEditor:thumBar($uuids) { 
  
    for $uuid in $uuids
    let $vraWorkRecord  := collection('/db/resources')//vra:vra/vra:work[@id = $uuid]
    let $imageRecordId  := if(exists($vraWorkRecord/vra:relationSet/vra:relation/@pref[.='true']))
                                then $vraWorkRecord/vra:relationSet/vra:relation[@pref='true']/@relids
                                else $vraWorkRecord/vra:relationSet/vra:relation[1]/@relids
    return
        <li><img src="{$csconfig:image-service-url || '/' || $imageRecordId|| '?width=96&amp;height=96'}" alt="{$imageRecordId}" title="{$imageRecordId}" class="relatedImage" onclick="loadRecord('{$uuid}')"/></li>
};
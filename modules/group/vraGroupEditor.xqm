xquery version "3.0";

module namespace vraGroupEditor = "http://exist-db.org/xquery/vraGroupEditor";

import module namespace rest = "http://exquery.org/ns/restxq";
import module namespace csconfig="http://exist-db.org/mods/config" at "/apps/cluster-shared/modules/config.xqm";
import module namespace app="http://www.betterform.de/projects/ziziphus/xquery/app" at "../app.xqm";
import module namespace record-utils="http://www.betterform.de/projects/ziziphus/xquery/record-utils" at "../utils/record-utils.xqm";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare namespace vra="http://www.vraweb.org/vracore4.htm";

declare
    %rest:POST("{$body}")
    %output:method("html5")
    %rest:path("/ziziphus/group")
function vraGroupEditor:init($body ) {
    let $uuids := $body//uuid
    
    return
        <html>
            <head>
                <title>Ziziphus Image DB - Group editor</title>
                <link rel="stylesheet" type="text/css" href="/exist/apps/ziziphus/resources/css/bootstrap.min.css"/>
                <link rel="stylesheet" type="text/css" href="/exist/apps/ziziphus/resources/css/group.css"/>
                <link rel="stylesheet" type="text/css" href="/exist/apps/ziziphus/resources/css/layout.css"/>
                <link rel="stylesheet" type="text/css" href="/exist/apps/ziziphus/resources/css/record.css"/>
                <link rel="stylesheet" type="text/css" href="/exist/apps/ziziphus/resources/script/mingos-uwindow/themes/ziziphus/style.css"/>
                <link rel="stylesheet" type="text/css" href="/exist/apps/ziziphus/resources/script/layout-default-latest.css"/>
                <link rel="stylesheet" type="text/css" href="/exist/apps/ziziphus/resources/css/jquery-ui.css"/>
                <link rel="stylesheet" type="text/css" href="/exist/apps/cluster-shared/resources/css/autocomplete.css"/>
            </head>
            <body>
                <div class="ui-layout-center">
                    <div class="full">
                        <iframe id="iEditor" src="record.html?id={$uuids[1]}&amp;workdir={$app:record-dir}&amp;imagepath={record-utils:get-image-record-path-by-work-record-id($uuids[1], $app:record-dir)}">
                        
                        </iframe>
                    </div>
                </div>
                <div class="ui-layout-south">
                    <div id="thumbBar">{vraGroupEditor:thumBar($uuids)}</div>    
                </div>
            
                <script type="text/javascript" src="resources/script/jquery-1.9.1.js"/>
                <script type="text/javascript" src="resources/script/jquery-ui-1.10.2.custom.min.js"/>
                <script type="text/javascript" src="resources/script/jquery.layout-latest.min.js"/>
                <script>
                    $(document).ready(function () {{
                        $('body').layout({{ applyDefaultStyles: true }});
                    }});
                    
                    function loadRecord(uuid) {{
                        alert("record.html?id=" + uuid);
                        $('#iEditor').attr('src',"record.html?id=" + uuid);
                    }}
                </script>
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
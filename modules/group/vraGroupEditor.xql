xquery version "3.0";

import module namespace app="http://github.com/hra-team/rosids-shared/config/app" at "/apps/rosids-shared/modules/ziziphus/config/app.xqm";
import module namespace security="http://exist-db.org/mods/security" at "/apps/tamboti/modules/search/security.xqm";
import module namespace console="http://exist-db.org/xquery/console";

declare namespace vra="http://www.vraweb.org/vracore4.htm";
declare namespace functx = "http://www.functx.com";

declare option exist:serialize "method=html5 media-type=text/html omit-xml-declaration=yes indent=yes";


(:  FUNCTX :)
declare function functx:substring-before-last($arg as xs:string? , $delim as xs:string) as xs:string {
   if (matches($arg, functx:escape-for-regex($delim)))
   then (
       replace($arg, concat('^(.*)', functx:escape-for-regex($delim),'.*'), '$1')
   ) else (
       ''
   )
};

declare function functx:escape-for-regex($arg as xs:string?) as xs:string {
   replace($arg, '(\.|\[|\]|\\|\||\-|\^|\$|\?|\*|\+|\{|\}|\(|\))','\\$1')
};

declare variable $local:user := security:get-user-credential-from-session()[1];
declare variable $local:userpass := security:get-user-credential-from-session()[2];
declare variable $local:temp-db := "/db/data/temp/";

declare %private function local:create-uuid-doc($uuid as xs:string) {
    let $uuids-as-string := util:binary-to-string(util:binary-doc($local:temp-db  || $uuid || ".js"))
    let $uuid-strings := tokenize(substring($uuids-as-string, 2, string-length($uuids-as-string) - 2), ",")
    let $uuid-document :=
        <data>
            {
                for $uuid-string at $pos in $uuid-strings
                let $uuid := replace(replace($uuid-string, "&quot;:1", ""), "&quot;", "")
                let $document-uri := document-uri(root(app:get-resource($uuid)))
                let $collection := substring-before($document-uri, "/" || $uuid)
                return
                    if(security:can-read-collection($collection))
                    then (
                        <record position="{$pos}">
                            <id>{$uuid}</id>
                            <collection>{$collection}</collection>
                        </record>
                    ) else ( () )
            }
        </data>
    let $store := xmldb:store($local:temp-db, $uuid-document || ".xml", $uuid-document)
    (: let $remove-id-document := xmldb:remove($local:temp-db, $uuid || ".js") :)
    return $uuid-document
};

declare %private function local:get-uuids-doc($uuid as xs:string) {
    let $uuid-doc :=
        if(doc-available($local:temp-db  || $uuid || ".xml"))
        then(doc($local:temp-db || $uuid || ".xml"))
        else (local:create-uuid-doc($uuid))
    return $uuid-doc
};

declare %private function local:extract-uuids-and-workdir($uuid as xs:string, $start, $page_limit) {
    let $uuids := <data>{subsequence(local:get-uuids-doc($uuid)//record, $start, $page_limit)}</data>
    return $uuids
};

declare %private function local:run($uuid as xs:string, $start, $page_limit) {
      let $uuid-workdir := local:extract-uuids-and-workdir($uuid, $start, $page_limit)
      return
          if( count( $uuid-workdir/record) > 0 )
          then (
            let $first-tupel := $uuid-workdir/record[1]
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
                        <link rel="stylesheet" type="text/css" href="/exist/apps/rosids-shared/resources/css/autocomplete.css"/>
                        <link rel="stylesheet" type="text/css" href="/exist/apps/ziziphus/resources/css/group.css"/>
                    </head>
                    <body>
                        <div class="ui-layout-center outer-center">
                            <div class="full" style="height:100%">
                                <iframe id="iEditor" src="/exist/apps/ziziphus/record.xql?id={$first-tupel/id}&amp;workdir={$first-tupel/collection}"></iframe>
                            </div>
                        </div>
                        <div class="ui-layout-south outer-south">
                            <div class="scroll-pane ui-widget ui-widget-header ui-corner-all">
                                <ul class="scroll-content">
                                    {local:thumBar($uuid-workdir)}
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
            ) else (
                local:error-page(<div>No readable records found. Only VRA records are supported within Ziziphus</div>)
            )
};

declare function local:thumBar($uuid-workdir) {
    for $record in $uuid-workdir/record
    let $vraWorkRecord  := app:get-resource($record/id)
    let $imageRecordId  := if(exists($vraWorkRecord/vra:relationSet/vra:relation/@pref[.='true']))
                                then $vraWorkRecord/vra:relationSet/vra:relation[@pref='true'][1]/@relids
                                else $vraWorkRecord/vra:relationSet/vra:relation[1]/@relids
    return
        <li><img src="/exist/apps/tamboti/modules/display/image.xql?schema=IIIF&amp;call=/{$imageRecordId}/full/150,150/0/default.jpg" alt="{$imageRecordId}" class="relatedImage" onclick="loadRecord('{$record/id}', '{$record/collection}')" title="{$imageRecordId}" /></li>
};

declare %private function local:groupeditor($uuid as xs:string, $start, $page_limit) {

        if(util:binary-doc-available($local:temp-db  || $uuid || ".js"))
        then (
            system:as-user($local:user, $local:userpass, local:run($uuid, $start, $page_limit))
        ) else (
            local:error-page('could not read id file')
        )
};

declare %private function local:error-page($error-text) {
    <html>
        <head>
            <title>Ziziphus Image DB - Group editor</title>
            <link rel="stylesheet" type="text/css" href="/exist/apps/ziziphus/resources/css/bootstrap.min.css"/>
        </head>
        <body>
            <div class="container">
                <h2 class="text-center">An error occured:</h2>
                <div class="text-center text-error">{$error-text}</div>
            </div>
            <script type="text/javascript" src="/exist/apps/ziziphus/resources/script/jquery-1.9.1.js"/>
        </body>
    </html>
};

let $uuid := request:get-parameter('id', '2014-12-04-15-17-56-299')
let $start := request:get-parameter('start', '1')
let $page_limit := request:get-parameter('page_limit', '10')
return
    if($uuid != '')
    then (
        local:groupeditor($uuid, $start, $page_limit)
    ) else (
        local:error-page('id parameter missing')
    )



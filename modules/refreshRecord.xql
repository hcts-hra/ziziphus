xquery version "3.0";
declare namespace vra="http://www.vraweb.org/vracore4.htm";

import module namespace app="http://www.betterform.de/projects/shared/config/app" at "/apps/cluster-shared/modules/ziziphus/config/app.xqm";

let $uuid := request:get-parameter('uuid', 'w_000197f8-4f11-5c63-9967-678e75fa6e41')
let $workdir :=  request:get-parameter('workdir','')
let $workdir := if($workdir eq "") then ($app:ziziphus-default-record-dir) else ($workdir)
let $record := collection(xmldb:encode($workdir))//vra:vra/*[@id = $uuid]
let $vraRecordType := local-name($record)
let $stylesheet := doc('/db/apps/ziziphus/resources/xsl/vra-record.xsl')
let $baseUri := substring-before(request:get-url(), '/apps')
let $parameters :=  <parameters>
                        <param  name="recordType" value="{$vraRecordType}"/>
                        <param name="recordId" value="{$uuid}"/>
                        <param  name="codetables-uri" value="{$baseUri || $app:code-tables}"/>
                        <param  name="resources-uri" value="{$baseUri || $app:ziziphus-resources-dir || 'lang/'}"/>
                        <param  name="lang" value="de"/>
                    </parameters>

return
    transform:transform($record, $stylesheet, $parameters)

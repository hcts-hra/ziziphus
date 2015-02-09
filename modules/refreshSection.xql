xquery version "3.0";
declare namespace vra="http://www.vraweb.org/vracore4.htm";

import module namespace app="http://www.betterform.de/projects/shared/config/app" at "/apps/cluster-shared/modules/ziziphus/config/app.xqm";

let $uuid := request:get-parameter('uuid', 'w_000197f8-4f11-5c63-9967-678e75fa6e41')
let $setname := request:get-parameter('setname', 'agentSet')

let $workdir :=  request:get-parameter('workdir','')
let $workdir := if($workdir eq "") then ($app:ziziphus-default-record-dir) else ($workdir)

let $record := collection(xmldb:encode($workdir))//vra:vra/*[@id = $uuid]
(: Only the part of the record we are interested in :)
let $snippet := $record//*[local-name() eq $setname]
let $stylesheet := doc('/db/apps/ziziphus/resources/xsl/vra-record.xsl')

let $tmpName := substring-before(local-name($snippet),'Set')
let $tmpNameUpperCase := concat(upper-case(substring($tmpName,1,1)), substring($tmpName,2))
let $setType := substring($uuid,1,1)
let $name := concat('table-',$setType,'_',$tmpNameUpperCase)
let $lang := request:get-parameter('language', 'en')
let $parameters :=  <parameters>
                        <param name="setname"  value="{$name}"/>
                        <param  name="codetables-uri" value="{$app:code-tables}"/>
                        <param  name="resources-uri" value="{ $app:ziziphus-resources-dir || 'lang/'}"/>
                        <param  name="lang" value="{$lang}"/>
                    </parameters>

return
    transform:transform($snippet, $stylesheet, $parameters)
xquery version "3.0";
declare namespace vra="http://www.vraweb.org/vracore4.htm";

import module namespace app="http://www.betterform.de/projects/shared/config/app" at "/apps/cluster-shared/modules/ziziphus/config/app.xqm";

let $workdir :=  request:get-parameter('workdir','')
let $workdir := if($workdir eq "") then ($app:ziziphus-default-record-dir) else ($workdir)
for $record in collection($workdir)//vra:relationSet
let $cnt := count($record/vra:relation)
return
if ($cnt gt 1)
then string($record/@id)
else ()

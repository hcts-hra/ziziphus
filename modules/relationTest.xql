xquery version "3.0";
declare namespace vra="http://www.vraweb.org/vracore4.htm";

import module namespace app="http://www.betterform.de/projects/ziziphus/xquery/app" at "app.xqm";

for $record in collection($app:work-record-dir)//vra:relationSet
let $cnt := count($record/vra:relation)
return
if ($cnt gt 1)
then string($record/@id)
else ()

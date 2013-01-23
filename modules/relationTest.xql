xquery version "3.0";
declare namespace vra="http://www.vraweb.org/vracore4.htm";

for $record in collection('/db/apps/ziziphusData/priyapaul/files/work')//vra:relationSet
let $cnt := count($record/vra:relation)
return
if ($cnt gt 1)
then string($record/@id)
else ()

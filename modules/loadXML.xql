xquery version "3.0";

declare namespace request="http://exist-db.org/xquery/request";
declare namespace vra="http://www.vraweb.org/vracore4.htm";

import module namespace record-utils="http://www.betterform.de/projects/ziziphus/xquery/record-utils" at "utils/record-utils.xqm";
import module namespace app="http://github.com/hra-team/rosids-shared/config/app" at "/apps/rosids-shared/modules/ziziphus/config/app.xqm";

declare option exist:serialize "method=xml media-type=text/xml indent=yes";

(: the id of a vra record :)
let $id := request:get-parameter('id', 'w_f265ddd4-0b05-5319-98a6-376b2875e33b')
let $type := request:get-parameter('type', 'work')
let $work := record-utils:get-record($id, $app:data-dir)
let $imageRecordId  := if(exists($work/vra:relationSet/vra:relation/@pref[.='true']))
                                then $work/vra:relationSet/vra:relation[@pref='true'][1]/@relids
                                else $work/vra:relationSet/vra:relation[1]/@relids

let $data := if($type = 'image') then (record-utils:get-record($imageRecordId, $app:data-dir)) else ($work)
return
    $data




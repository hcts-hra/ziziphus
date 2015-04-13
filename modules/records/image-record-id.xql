xquery version "3.0";

import module namespace record-utils="http://www.betterform.de/projects/ziziphus/xquery/record-utils" at "/apps/ziziphus/modules/utils/record-utils.xqm";

let $uuid := request:get-parameter('uuid', 'w_000197f8-4f11-5c63-9967-678e75fa6e41')
return record-utils:get-image-record-id-by-work-record-id($uuid)
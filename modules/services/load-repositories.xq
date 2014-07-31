xquery version "3.0";

let $user := request:get-parameter('user', '')
let $group := request:get-parameter('group', '')

return <data>{$user} {$group}</data>

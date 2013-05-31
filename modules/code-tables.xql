xquery version "3.0";

import module namespace app="http://www.betterform.de/projects/ziziphus/xquery/app" at "app.xqm";

declare %private variable $table-map := map {
                                              "lang" := "language-3-type-sorted-short-codes.xml",
                                              "script" := "script-short-codes.xml",
                                              "transliteration" := "transliteration-short-codes.xml",
                                              "role" := "role-short-codes.xml"
                                          };

let $table := xs:string(request:get-parameter("table", "role"))
let $data := if($table ne "") then ( doc($app:code-tables || $table-map($table)) ) else ( <data xmlns=""><item><label>Not found</label><value>0</value></item></data> )
return
    $data
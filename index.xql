xquery version "3.0";
declare namespace xmldb="http://exist-db.org/xquery/xmldb";
declare namespace vra="http://www.vraweb.org/vracore4.htm";

declare option exist:serialize "method=xhtml media-type=text/html";
let $start := xs:integer(request:get-parameter("start", "0"))
let $num := xs:integer(request:get-parameter("num", "20"))
let $query-base := request:get-url()
let $context := request:get-context-path()

return
<html>
   <head>
        <title>Priya Paul Collection</title>
       <link rel="stylesheet" type="text/css" href="resources/css/bootstrap.min.css"/>
       
   </head>

   <body style="padding:30px;">
      <h1>Priya Paul Collection</h1>
      <h2>Work Records from {$start} to {$start + $num}</h2>
      
      <input class="btn" type="button" onClick="parent.location='{$query-base}?start={$start - $num}&amp;num={$num}'" value="Previous" />
      <input class="btn" type="button" onClick="parent.location='{$query-base}?start={$start + $num}&amp;num={$num}'" value="Next"/>

      <table class="table table-striped">
           <thead>
                <tr>
                    <th></th>
                    <th>uuid</th> 
                    <th>source</th>
                    <th>1. agent name</th>
                </tr>
          </thead>
          <tbody>
          {
          for $record  in subsequence(collection('/db/apps/ziziphusData/priyapaul/files/work'), $start, $num)//vra:vra/vra:work
            let $uuid := string($record/@id)
            let $source := string($record/@source)
            let $agent := string($record/vra:agentSet/vra:agent[1]/vra:name)
            order by $uuid
            return
            <tr>
                <td></td>
                <td><a href="{$context}/apps/ziziphus/record.xql?id={$uuid}">{$uuid}</a></td>
                <td>{$source}</td>
                <td>{$agent}</td>
            </tr>
          }
          </tbody>
    </table>
  </body>
</html>

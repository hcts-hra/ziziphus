xquery version "3.0";

declare namespace xmldb="http://exist-db.org/xquery/xmldb";
declare namespace vra="http://www.vraweb.org/vracore4.htm";
declare namespace ext="http://exist-db.org/vra/extension";

import module namespace app="http://www.betterform.de/projects/ziziphus/xquery/app" at "modules/app.xqm";
import module namespace security="http://exist-db.org/mods/security" at "/apps/cluster-shared/modules/search/security.xqm";

declare option exist:serialize "method=html5 media-type=text/html";
let $start := xs:integer(request:get-parameter("start", "1"))
let $num := xs:integer(request:get-parameter("num", "20"))
let $query-base := request:get-url()
let $context := request:get-context-path()
let $user := request:get-attribute("xquery.user")
let $workdir :=  request:get-parameter('workdir','')
let $workdir := if($workdir eq "") then ($app:record-dir) else ($workdir)

let $cnt := if($start gt ($num)) then $start + $num -1 else $num
return
<html>
   <head>
        <title>Priya Paul Collection</title>
       <link rel="stylesheet" type="text/css" href="resources/css/bootstrap.min.css"/>
   </head>
   <body style="padding:30px;">
      <h1>Priya Paul Collection</h1>
    {
        if ($user ne 'guest')
        then (
          <form action="HeidiconSearch.xql" class="form-search">
            <label class="control-label" for="idSearch">Heidicon Id:</label>
            <input id="idSearch" type="search" name="heidiconId"/>
            <input  type="hidden" name="workdir" value="{$workdir}"/>
            <button type="submit" class="btn">Search</button>
          </form>,

          <form action="WorkrecordSearch.xql" class="form-search">
            <label class="control-label" for="idSearch">Work Record Id:</label>
            <input id="idSearch" type="search" name="workrecord"/>
            <input  type="hidden" name="workdir" value="{$workdir}"/>
            <button type="submit" class="btn">Search</button>
          </form>
        ) else ()
    }


      <h2>Work Records from {$start} to {$cnt}</h2>
      
      <input class="btn" type="button" onClick="parent.location='{$query-base}?start={$start - $num}&amp;num={$num}'" value="Previous" />
      <input class="btn" type="button" onClick="parent.location='{$query-base}?start={$start + $num}&amp;num={$num}'" value="Next"/>

      <table class="table table-striped">
           <thead>
                <tr>
                    <th></th>
                    <th>uuid</th>
                    <th>work record data</th>
                    <th>image record data</th>
                    <th>Heidicon Id</th>
                    <th>1. agent name</th>
                </tr>
          </thead>
          <tbody>
          {
          for $record  at $count in subsequence(collection($workdir)//vra:vra/vra:work, $start, $num )
            let $uuid := string($record/@id)
            let $agent := string($record/vra:agentSet/vra:agent[1]/vra:name)
            let $vraWorkRecord  := collection($workdir)/vra:vra/vra:work[@id = $uuid]
            let $imageRecordId  := if(exists($vraWorkRecord/vra:relationSet/vra:relation/@pref[.='true']))
                                then $vraWorkRecord/vra:relationSet/vra:relation[@pref='true']/@relids
                                else $vraWorkRecord/vra:relationSet/vra:relation[1]/@relids
            let $heidiconId := $vraWorkRecord//ext:heidicon/ext:item[@type='f_id_heidicon']/ext:value[2]
            
            let $counter := if($start gt ($num)) then $start+$count -1 else $count
            return
            <tr>
                <td>{$counter}</td>
                <td><a href="{$context}/apps/ziziphus/record.html?id={$uuid}&amp;workdir={$workdir}" target="_blank">{$uuid}</a></td>
                <td><a href="{$context}/rest/{$workdir || $uuid}.xml" target="_blank">work</a></td>
                <td><a href="{$context}/rest/{$workdir || $app:image-record-dir-name || $imageRecordId}.xml" target="_blank">image</a></td>
                <td>{$heidiconId}</td>
                <td>{$agent}</td>
            </tr>
          }
          </tbody>
    </table>
  </body>
</html>

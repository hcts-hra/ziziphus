xquery version "3.0";

declare namespace xmldb="http://exist-db.org/xquery/xmldb";
declare namespace vra="http://www.vraweb.org/vracore4.htm";
declare namespace hra="http://cluster-schemas.uni-hd.de";

import module namespace app="http://www.betterform.de/projects/shared/config/app" at "/apps/cluster-shared/modules/ziziphus/config/app.xqm";

declare option exist:serialize "method=xhtml media-type=text/html";
let $query-base := request:get-url()
let $context := request:get-context-path()
let $searchId := request:get-parameter("heidiconId","118874")
let $workdir :=  request:get-parameter('workdir','')
let $workdir := if($workdir eq "") then ($app:ziziphus-default-record-dir) else ($workdir)

return
<html>
   <head>
        <title>Priya Paul Collection - Heidicon Id Search</title>
       <link rel="stylesheet" type="text/css" href="resources/css/bootstrap.min.css"/>
       
   </head>

   <body style="padding:30px;">
      <h1>Priya Paul Collection - Heidicon Id Search</h1>

      <form action="HeidiconSearch.xql" class="form-search">
        <label class="control-label" for="idSearch">Heidicon Id:</label>
        <input id="idSearch" type="search" name="heidiconId" placeholder="please specify a Heidicon Id"/>
        <button type="submit" class="btn">Search</button>
      </form>
      
      <div>
      {
         
      for $record in collection(xmldb:encode($workdir))//vra:vra[.//hra:heidicon/hra:item[@type='f_id_heidicon']/hra:value=$searchId]
        let $theId := $record//hra:item[@type="f_id_heidicon" ]/hra:value[2]/text()
        let $workid := string($record/vra:work/@id)
        let $title := string($record/vra:work/vra:titleSet/vra:title)
        let $agent := string($record/vra:work/vra:agentSet/vra:agent[1])
        return
        <table class="table table-striped">
            <tr>
                <td>Heidicon Id:</td>
                <td>{$theId}</td>
            </tr>
            <tr>
                <td>Workrecord id</td>
                <td><a href="{$context}/apps/ziziphus/record.html?id={$workid}">{$workid}</a></td>
            </tr>
            <tr>
                <td>Title</td>
                <td>{$title}</td>
            </tr>
            <tr>
                <td>first agent</td>
                <td>{$agent}</td>
            </tr>
        </table>
        
        
      }
      </div>
      <button class="btn" onclick="history:back();">back</button>
  </body>
</html>

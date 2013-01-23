xquery version "3.0";
declare namespace xmldb="http://exist-db.org/xquery/xmldb";
declare namespace vra="http://www.vraweb.org/vracore4.htm";
declare namespace hra="http://cluster-schemas.uni-hd.de";

declare option exist:serialize "method=xhtml media-type=text/html";
let $query-base := request:get-url()
let $context := request:get-context-path()
let $searchId := request:get-parameter("heidiconId","118874")

return
<html>
   <head>
        <title>Priya Paul Collection</title>
       <link rel="stylesheet" type="text/css" href="resources/css/bootstrap.min.css"/>
       
   </head>

   <body style="padding:30px;">
      <h1>Priya Paul Collection</h1>

      <form action="HeidiconSearch.xql" class="form-search">
        <label class="control-label" for="idSearch">Heidicon Id:</label>
        <input id="idSearch" type="search" name="heidiconId" placeholder="please specify a Heidicon Id"/>
        <button type="submit" class="btn">Search</button>
      </form>
      
      <div>
      {
         
      for $record in collection('/db/apps/ziziphusData/priyapaul/files/work')//vra:vra[.//hra:heidicon/hra:item[@type='f_id_heidicon']/hra:value=$searchId]
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
                <td><a href="{$context}/apps/ziziphus/record.xql?id={$workid}">{$workid}</a></td>
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

xquery version "3.0";
declare namespace xmldb="http://exist-db.org/xquery/xmldb";
declare namespace vra="http://www.vraweb.org/vracore4.htm";

declare option exist:serialize "method=xhtml media-type=text/html";
let $start := xs:integer(request:get-parameter("start", "1"))
let $num := xs:integer(request:get-parameter("num", "20"))
let $query-base := request:get-url()
let $context := request:get-context-path()

return
<html>
   <title>Priya Paul Collection</title>
   <body>
      <h1>Priya Paul Collection</h1>
      <h2>Work Records</h2>
      <table>
           <thead>
                <tr>
                    <th>uuid</th> 
                    <th>source</th>
                </tr>
          </thead>
          <tbody>
          {
          for $record in subsequence(collection('/db/apps/ziziphus/records/priyapaul/files/work'), $start, $num)//vra:vra/vra:work
            let $uuid := string($record/@id)
            let $source := string($record/@source)
            order by $uuid
            return
            <tr>
                <td><a href="{$context}/apps/ziziphus/index.xql?id={$uuid}">{$uuid}</a></td>
                <td>{$source}</td>
            </tr>
          }
          </tbody>
    </table>
  </body>
</html>

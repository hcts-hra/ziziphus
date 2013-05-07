xquery version "3.0";
declare namespace vra="http://www.vraweb.org/vracore4.htm";
declare option exist:serialize "method=xhtml media-type=application/xhtml+xml";


(: the id of a vra record :)
let $id := request:get-parameter('id', 'w_000197f8-4f11-5c63-9967-678e75fa6e41')
let $input := collection('/apps/ziziphusData/priyapaul/files/work')//vra:vra[vra:work/@id=$id]

let $result := transform:transform($input, doc("/db/apps/ziziphus/resources/xsl/heidicon.xsl"), ())
return $result


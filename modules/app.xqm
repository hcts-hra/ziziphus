xquery version "3.0";

module namespace app="http://www.betterform.de/projects/ziziphus/xquery/app";

declare %private  variable $app:collection-name as xs:string := "Priya_Paul_Collection";

declare %private  variable $app:app-name as xs:string := "ziziphus";
declare %private  variable $app:app-dir as xs:string := "/exist/apps/" || $app:app-name;
        
declare  %private  variable $app:shared-dir as xs:string := "/apps/cluster-shared";

declare %private  variable $app:data-dir as xs:string := "/db/resources/";
declare %private variable $app:common-data-dir as xs:string := $app:data-dir || "commons/";
declare %private variable $app:users-data-dir as xs:string := $app:data-dir || "users/";

declare  variable $app:code-tables as xs:string := $app:shared-dir || "/modules/edit/code-tables/";
declare  variable $app:legends as xs:string := $app:shared-dir || "/modules/edit/code-tables/legends/";

declare variable $app:app-resources-dir as xs:string := "/apps/" || $app:app-name || "/resources/";
declare variable $app:record-dir as xs:string := $app:common-data-dir || $app:collection-name || "/";
declare variable $app:image-record-dir-name as xs:string := "VRA_images/";

declare  variable $app:user-work-record-dir := $app:users-data-dir || xmldb:get-current-user() || "/" ||  $app:collection-name || "/work/";
declare  variable $app:user-image-record-dir := $app:users-data-dir || xmldb:get-current-user() || $app:collection-name || "/image/";

(: TODO: Remove me .... :)
declare  variable $app:work-record-dir as xs:string := $app:record-dir;

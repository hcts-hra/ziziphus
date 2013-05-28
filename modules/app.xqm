xquery version "3.0";

module namespace app="http://www.betterform.de/projects/ziziphus/xquery/app";

declare %private  variable $app:collection-name := encode-for-uri("Priya Paul Collection");

declare  %private  variable $app:app-dir := " /exist/apps/ziziphus";

declare  %private  variable $app:data-dir := "/db/resources/";
declare   %private variable $app:common-data-dir := $app:data-dir || "commons/";
declare   %private variable $app:users-data-dir := $app:data-dir || "users/";

declare  variable $app:record-dir := $app:common-data-dir || $app:collection-name || "/";
declare  variable $app:work-record-dir := $app:common-data-dir || $app:collection-name || "/work/";
declare  variable $app:image-record-dir := $app:common-data-dir || $app:collection-name || "/image/";

declare  variable $app:user-work-record-dir := $app:users-data-dir || xmldb:get-current-user() || "/" ||  $app:collection-name || "/work/";
declare  variable $app:user-image-record-dir := $app:users-data-dir || xmldb:get-current-user() || $app:collection-name || "/image/";


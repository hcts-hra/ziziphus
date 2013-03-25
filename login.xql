xquery version "3.0";
declare namespace functx = "http://www.functx.com";
import module namespace request = "http://exist-db.org/xquery/request";

declare function functx:substring-before-last  ( $arg as xs:string? , $delim as xs:string )  as xs:string {

   if (fn:matches($arg, functx:escape-for-regex($delim)))
   then fn:replace($arg,
            fn:concat('^(.*)', functx:escape-for-regex($delim),'.*'),
            '$1')
   else ''
 };

 declare function functx:escape-for-regex( $arg as xs:string? )  as xs:string {

   fn:replace($arg,
           '(\.|\[|\]|\\|\||\-|\^|\$|\?|\*|\+|\{|\}|\(|\))','\\$1')
 };

let $user := request:get-parameter("app.user",'guest')
let $path := request:get-parameter('path', '')
let $controller := request:get-parameter('controller', '')
let $prefix := request:get-parameter('prefix', '')
let $origin :=  concat('/exist', $prefix, $controller, $path)
return
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:ev="http://www.w3.org/2001/xml-events" xmlns:exist="http://exist.sourceforge.net/NS/exist" xmlns:xf="http://www.w3.org/2002/xforms">
    <head>
        <title>PSI Configuration Wizard {$origin}</title>
        <link rel="stylesheet" href="{request:get-context-path()}/apps/configwizard/resources/css/psi.css" type="text/css" media="screen" title="no title" charset="utf-8"/>
    </head>
    <body>
    <div class="container container_12" style="background-color:#fff;padding:15px 1em 60px 1em">
        <div class="grid_12">
            <table>
                <tr>
                    <td>
                        <!-- a href="index.xql" >
                            <img style="float:left;padding-right:15px"
                                    src="{request:get-context-path()}/apps" width="153" height="55" title=""/></a-->
                    </td>
                    <td>
                        <h1>Login</h1>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div class="clear margintop"/>
    <div class="container_12 container">
        <div class="grid_10" style="padding-left:120px;">
            <p>This resource is protected. Only registered users are allowed to login. To register an account please contact the <a href="mailto:ziziphus@betterform.de">database admin</a>.</p>
            <form method="POST" class="login" action="{$origin}">
                <input type="hidden" name="origin" value="{$origin}" autocomplete="off"/>
                <table class="login" cellpadding="5">
                    <tbody>
                        <tr>
                            <td class="text" align="left">Username:</td>
                            <td>
                                <input type="text" name="user" size="20" required="required" placeholder="username"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="text" align="left">Password:</td>
                            <td>
                                <input type="password" name="password" size="20" placeholder="password"/>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="left">
                                <input type="submit" value="Login"/>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </div>
        <div style="width:90%;margin:20px;padding:10px;background:lightyellow;border:1px solid darkred;">
            <div style="font-size:24pt;font-weight:bold;padding-bottom:20px;">Please note!</div>
            <div  style="font-size:14pt;">Currently Ziziphus is optimized for<b style="color:darkred;">
                <a href="http://www.mozilla.org/firefox" style="color:darkred">Firefox</a> (Version 18 or higher)</b>
                    and a display resolution of at least <b style="color:darkred;"> 1280 x 1024 pixel</b>.</div>
        </div>
    </div>
</body>
</html>
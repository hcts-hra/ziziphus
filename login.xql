xquery version "3.0";

import module namespace request = "http://exist-db.org/xquery/request";


declare option exist:serialize "method=xhtml media-type=text/html";

(: REMOVE ME:)
(:
    import module namespace config="http://exist-db.org/xquery/apps/config" at "modules/config.xqm";
:)

declare %private function local:buildRequestURL() {
    let $parameter-names := request:get-parameter-names()
    for $parameter-name in $parameter-names
    return
        if($parameter-name = "id" or $parameter-name = "controller" or $parameter-name = "prefix" or $parameter-name = "path")
        then ()
        else (
            "&amp;" || $parameter-name || "=" || request:get-parameter($parameter-name, "")
        )
};

let $user := request:get-parameter("app.user",'guest')
let $path := request:get-parameter('path', '')
let $controller := request:get-parameter('controller', '')
let $prefix := request:get-parameter('prefix', '')
let $id := request:get-parameter('id', '')
let $rootContext := '/exist'
let $appPath := concat($rootContext, $prefix, $controller)

let $origin :=  concat($appPath, $path)
let $requestURL := concat($origin, if($id) then ( concat('?id=',$id) ) else (), string-join(local:buildRequestURL(), '') ) 
return
<html>
    <head>
        <title>Ziziphus Image DB</title>
        <link rel="stylesheet" type="text/css" href="resources/css/bootstrap.min.css"/>
        <link rel="stylesheet" type="text/css" href="resources/css/layout.css"/>
        <link rel="stylesheet" type="text/css" href="resources/css/record.css"/>
        <link rel="stylesheet" type="text/css" href="resources/script/mingos-uwindow/themes/ziziphus/style.css"/>
        <link rel="stylesheet" type="text/css" href="resources/script/layout-default-latest.css"/>
        
        <style type="text/css">
            .login input {{
                height: 30px;
            }}
        </style>
    </head>
    <body class="login">
        <div class="ui-layout-north" style="overflow:hidden;">
            <div class="row-fluid">
                <div class="span7">
                    <a href="index.xql" >
                        <img style="border:0;height:80px;width: 500px;" src="resources/images/logo.jpg" height="10em" title="Ziziphus Home"/>                            
                    </a>
                    <!-- h1>Ziziphus Image Database</h1-->
                </div>
                <div class="span5">
                    <form method="POST" class="form-search" action="{$requestURL}">
                        <input type="hidden" name="origin" value="{$requestURL}" autocomplete="off"/>
                        <input type="text" name="username"  required="required" placeholder="username"/>
                        <input type="password" name="password" placeholder="password"/>
                        <button type="submit" value="Login" class="btn btn-success">Login</button>
                    </form>
                </div>
            </div>
        </div>
        <div class="ui-layout-south">Copyright</div>
        <div class="ui-layout-center">
            <div class="row-fluid">
                <div class="span6">
                    <p class="lead">The Ziziphus Image Database .... some text about Ziziphus</p>
                    <ul>
                        <li>vra support</li>
                        <li>tamboti</li>
                        <li>heidicon</li>
                    </ul>
                </div>
                <div class="span6">
                    <form class="form-horizontal" on-submit="return false;">
                        <fieldset>
                            <legend>Sign up for free</legend>
                            <div class="control-group">
                                <input type="text" name="username" required="required" placeholder="Username"/>
                            </div>
                            <div class="control-group">
                                <input type="text" name="email" required="required" placeholder="Email"/>
                            </div>
                            <div class="control-group">
                                <input type="text" name="email" required="required" placeholder="Re-enter Email"/>
                            </div>
                            <div class="control-group">
                                <input type="password" name="password" required="required" placeholder="Password"/>                            
                            </div>
                            <div class="control-group">
                                <button type="submit" value="Login" class="btn btn-primary">Register</button>
                            </div>
                        </fieldset>
                    </form>
                </div>
            </div>
            <div class="row">
                <div class="span12">        
                    <h3>Debug Information:</h3>
                </div>
            </div>
            <div class="row">
                <div class="span6">        
                    <p>Tested browsers:</p>
                    <ul>
                        <li><b><a href="http://www.mozilla.org/firefox" style="color:darkred">Firefox</a> (Version 18++)</b></li>
                    </ul>
                    <p>and resolutions:</p>
                    <ul>
                        <li><b style="color:darkred;"> 1440 x 900</b></li>
                    </ul>
                </div>
                <div class="span6">        
                    <table>
                        <tr>
                            <td>User</td>
                            <td>{$user}</td>
                        </tr>
                        <tr>
                            <td>Path</td>
                            <td>{$path}</td>
                        </tr>
                        <tr>
                            <td>Controll</td>
                            <td>{$controller}</td>
                        </tr>
                        <tr>
                            <td>Prefix</td>
                            <td>{$prefix}</td>
                        </tr>
                        <tr>
                            <td>Origin</td>
                            <td>{$origin}</td>
                        </tr>
                        <tr>
                            <td>requestURL</td>
                            <td>{$requestURL}</td>
                        </tr>
                    </table>
                </div>
            </div>        
        </div>        
        <script type="text/javascript" src="resources/script/jquery-1.9.1.js"/>
        <script type="text/javascript" src="resources/script/jquery-ui-1-1.10.0.custom/js/jquery-ui-1.10.0.custom.min.js"/>
        <script type="text/javascript" src="resources/script/mingos-uwindow/jWindow.js"/>
        <script type="text/javascript" src="resources/script/jquery.layout-latest.min.js"/>
        <script type="text/javascript">
            $(document).ready(function () {{
                var layout = $('body').layout({{
                    defaults:{{
                        applyDefaultStyles:true
                    }},
                    north:{{
                        resizable:false,
                        closable:false,
                        spacing_open:0
                    }},
                    west:{{
                        resizable:true,
                        closable:true,
                        size:420
                    }},
                    east:{{
                        resizable:true,
                        closable:true,
                        size:420
                    }},
                    south:{{
                        resizable:false,
                        closable:true,
                        spacing_open:0,
                        spacing_closed:6
                    }}
                }});
            }});
        </script>    
</body>
</html>
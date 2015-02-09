xquery version "3.0";

import module namespace security="http://exist-db.org/mods/security" at "/apps/cluster-shared/modules/search/security.xqm";
import module namespace app="http://www.betterform.de/projects/shared/config/app" at "/apps/cluster-shared/modules/ziziphus/config/app.xqm";

declare function local:check-login() {
    let $session-credentials := security:get-user-credential-from-session()
    return
        if ($session-credentials != '' and $session-credentials[1] ne 'guest')
        then (
            true()
        ) else(
            false()
        )
};

let $login := local:check-login()
return
<html>
    <head>
        <title>Ziziphus - VRA editor</title>
        
        <script src="//code.jquery.com/jquery-2.1.1.min.js"></script>
        
        <!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css"/>

        <!-- Optional theme -->
        <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css"/>

        <!-- Latest compiled and minified JavaScript -->
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
        
        

        <link href='http://fonts.googleapis.com/css?family=Vollkorn:400,700' rel='stylesheet' type='text/css'/>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <div class="col-xs-12">
                    <div class="col-xs-6 col-md-1">
                        <img src="resources/images/logo.jpg" class="img-responsive" alt="Responsive image"/>
                    </div>
                    <div class="col-xs-6 col-md-2">
                        <h1 style="font-family: 'Vollkorn', serif; font-weight: 700;">Z I Z I P H U S</h1>
                    </div>
                    <div class="col-xs-12 col-md-4 col-md-offset-5">
                        {
                        if ($login)
                        then (
                        <form method="POST" role="form" class="form-inline pull-right" action="">
                            <div class="form-group">
                                <label for="username">Username</label>
                                <input type="text" name="username" readonly="readonly" placeholder="username" value="{security:get-user-credential-from-session()[1]}"/>    
                            </div>
                            <div class="form-group">
                                <button type="submit" value="Logout" class="btn btn-danger">Logout</button>
                            </div>
                        </form>
                        ) else (
                        <form method="POST" role="form" class="form-inline pull-right" action="">
                            <div class="form-group">
                                <label for="username">Username</label>
                                <input type="text" name="username"  required="required" placeholder="username"/>    
                            </div>
                            <div class="form-group">
                                <label for="password">Password</label>
                                <input type="text" name="password"  required="required" placeholder="password"/>    
                            </div>
                            <div class="form-group">
                                <button type="submit" value="Login" class="btn btn-success">Login</button>
                            </div>
                        </form>
                        )
                        }
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-12">
                    <div class="panel panel-success">
                        <div class="panel-heading">
                            <h3 class="panel-title">Searches</h3>
                        </div>
                        <div class="panel-body">
                            <div class="panel-group" id="searches">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            <a data-toggle="collapse" data-parent="#searches" href="#workrecord">
                                                Workrecord
                                            </a>
                                        </h4>
                                    </div>
                                    <div id="workrecord" class="panel-collapse collapse">
                                        <div class="panel-body">
                                        <form role="form" action="WorkrecordSearch.xql" class="form-inline">
                                        <input  type="hidden" name="workdir" value="{$app:ziziphus-default-record-dir}"/>
                                            <div class="form-group">
                                                <label class="control-label" for="idSearch">Work Record Id:</label>
                                                <input id="idSearch" type="search" name="workrecord"/>
                                            </div>
                                            <div class="form-group">
                                                <button type="submit" class="btn btn-success">Search</button>
                                            </div>
                                        </form>    
                                        </div>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            <a data-toggle="collapse" data-parent="#searches" href="#heidicon">
                                                Heidicon
                                            </a>
                                        </h4>
                                    </div>
                                    <div id="heidicon" class="panel-collapse collapse">
                                        <div class="panel-body">
                                            <form role="form" action="HeidiconSearch.xql" class="form-inline">
                                                <input  type="hidden" name="workdir" value="{$app:ziziphus-default-record-dir}"/>
                                                <div class="form-group">
                                                    <label class="control-label" for="idSearch">Heidicon Id:</label>
                                                    <input id="idSearch" type="search" name="heidiconId"/>
                                                </div>
                                                <div class="form-group">
                                                    <button type="submit" class="btn btn-success">Search</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-12">
                    <div class="panel panel-success">
                        <div class="panel-heading">
                            <h3 class="panel-title">Browse collection</h3>
                        </div>
                        <div class="panel-body">
                           
                        </div>
                        <table class="table table-striped">
                            <tbody>
                                <tr>
                                    <td><input type="checkbox" value=""/></td>
                                    <td><img src="..." alt="..." class="img-thumbnail"/></td>
                                    <td>3</td><td>4</td><td>5</td><td>6</td><td>7</td><td>8</td>
                                </tr>
                                <tr>
                                    <td><input type="checkbox" value=""/></td><td><img src="..." alt="..." class="img-thumbnail"/></td>
                                    <td>3</td><td>4</td><td>5</td><td>6</td><td>7</td><td>8</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
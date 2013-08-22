xquery version "3.0";


import module namespace app="http://www.betterform.de/projects/ziziphus/xquery/app" at "modules/app.xqm";

declare option exist:serialize "method=xhtml media-type=application/xhtml+xml";

<html xmlns="http://www.w3.org/1999/xhtml" xmlns:xf="http://www.w3.org/2002/xforms">
    <head>
        <title>Autocomplete</title>
        <link rel="stylesheet" type="text/css" href="resources/css/jquery-ui.css"/>
        <script type="text/javascript" src="resources/script/jquery-1.9.1.js"/>
        <script type="text/javascript" src="resources/script/jquery-ui-1.10.2.custom.min.js"/>
        <script type="text/javascript" src="{ concat("/exist" , $app:shared-dir , "/resources/scripts/jquery.autocomplete.js")}"/>
        
        <style type="text/css">
            .autocomplete-suggestions {{ border: 1px solid #999; background: #FFF; overflow: auto; }}
            .autocomplete-suggestion {{ padding: 2px 5px; white-space: nowrap; overflow: hidden; }}
            .autocomplete-selected {{ background: #F0F0F0; }}
            .autocomplete-suggestions strong {{ font-weight: normal; color: #3399FF; }}
        </style>
        
       
    </head>
    <body>
        <div style="display:none;">
            <xf:model id="test">
                <xf:instance id="person" xmlns="">
                    <data>
                        <person>a</person>
                    </data>
                </xf:instance>
            </xf:model>
            
            <xf:input id="person" ref="person">
                <xf:label>Output</xf:label>
            </xf:input>
        </div>
        
       
       
        <br/>
        
        <label for="personAutoComplete">Name:</label>
        <input type="text" name="person" id="personAutoComplete" placeholder=""/>
        
        <span id="indicator"><img src="resources/images/indicator.gif"/></span>
        
         <script type="text/javascript" defer="defer">
           $('#personAutoComplete').autocomplete({{
                serviceUrl: '{concat("/exist" , $app:shared-dir , "/modules/service/lookup.xql")}',
                minChars: "1",
                paramName: "person",
                width: "450",
                onSelect: function (suggestion) {{
                    //console.log("suggestion:", suggestion);
                    fluxProcessor.sendValue("person", suggestion.data);
                }},
                onSearchStart: function (query) {{
                    $("#indicator img").css("display", "block");
                }},
                onSearchComplete: function (query) {{
                    $("#indicator img").css("display", "none");
                }}
            }});
            $("#indicator img").css("display", "none");
        </script>
    </body>
</html>
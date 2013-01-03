(:
  This is not used currently but it might be a later option. The form markup itself will likely be outdated by then.

  The idea behind this effort was to generate the XForms markup by XQuery to handle the output sections in plain
  html. This does not work due to the fact that the outputs have to be in a repeated section.

  Nevertheless the markup generation might still be an interesting option later on to e.g. inline instance data
  and thus avoiding at least some of the xf:submissions (which of course add some latency to the overall application).
:)



xquery version "3.0";

declare option exist:serialize "method=xhtml media-type=application/xhtml+xml encoding=UTF-8";

let $recordId := request:get-parameter('recordId', 'w_40ca74a3-3e6c-5749-b0a0-b42afbadff01') 
let $recordType := if(starts-with($recordId, 'w')) then ('work') else ('image')
let $instance := doc(concat("/db/apps/ziziphus/records/", $recordId, '.xml'))//*:agentSet

(: 
<xf:submission id="s-load-data" resource="records?_query=//*[@id='{$recordId}']/*:agentSet&amp;_wrap=no"
                                   replace="instance" instance="i-agentSet" method="get" serialize="false" validate="false">
                        <xf:message ev:event="xforms-submit-error">Could not load AgentSet data</xf:message>
                    </xf:submission>
:)

return
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:ev="http://www.w3.org/2001/xml-events"
      xmlns:xsd="http://www.w3.org/2001/XMLSchema"
      xmlns:vra="http://www.vraweb.org/vracore4.htm"
      xmlns:bfc="http://betterform.sourceforge.net/xforms/controls"
      xmlns:xf="http://www.w3.org/2002/xforms"
        >
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <title>Ziziphus_Image_DB</title>
    </head>
    <body>
        <div id="xforms">
            <!-- ###################### MODEL ################################## -->
            <!-- ###################### MODEL ################################## -->
            <!-- ###################### MODEL ################################## -->
            <div style="display:none">
                <xf:model id="m-child-model" schema="resources/xsd/vra-types.xsd">
                    <xf:instance id="i-agentSet" xmlns="">
                        {$instance}
                        
                    </xf:instance>
                    <xf:bind nodeset="instance()">
                        <xf:bind nodeset="vra:agent">
                            <xf:bind nodeset="@pref" type="boolean"/>

                            <xf:bind nodeset="vra:name" required="true()">
                                <xf:bind nodeset="@type" type="vra:agentNameTypeType"/>
                            </xf:bind>

                            <xf:bind nodeset="vra:dates/*/@circa" type="boolean"/>
                        </xf:bind>
                    </xf:bind>
                    <xf:instance id="i-templates">
                        <templates xmlns="http://www.vraweb.org/vracore4.htm">
                            <!-- todo: clarify: are agent attributes required? They are present in the schema but are they use for ziziphus? -->
                            <agent dataDate="" extent="" href="" xml:lang="" pref="" refid="" rules="" source="" vocab="" script=""
                                   transliteration="">
                                <attribution dataDate="" extent="" href="" xml:lang="" pref="" refid="" rules="" source="" vocab=""
                                             script="" transliteration=""/>
                                <culture dataDate="" extent="" href="" xml:lang="" pref="" refid="" rules="" source="" vocab="" script=""
                                         transliteration=""/>
                                <dates type="">
                                    <earliestDate circa=""/>
                                    <latestDate circa=""/>
                                </dates>
                                <name type="" pref="false" vocab="" xml:lang="" script="" dataDate="" extent="" href="" refid="" rules=""
                                      source="" transliteration=""/>
                                <role dataDate="" extent="" href="" xml:lang="" pref="" refid="" rules="" source="" vocab="" script=""
                                      transliteration=""/>
                            </agent>
                            <notes dataDate="" extent="" href="" xml:lang="" pref="" refid="" rules="" source="" vocab="" script=""
                                  transliteration=""/>
                            <display dataDate="" extent="" href="" xml:lang="" pref="" refid="" rules="" source="" vocab="" script=""
                                  transliteration=""/>
                        </templates>
                    </xf:instance>

                </xf:model>
            </div>

            <!-- ####################################### VISIBLE UI ####################################### -->
            <!-- ####################################### VISIBLE UI ####################################### -->
            <!-- ####################################### VISIBLE UI ####################################### -->
            <div class="toolbar">
                <xf:trigger class="t-save" model="m-child-model" title="Save">
                    <xf:label>save</xf:label>
                    <!--<xf:send submission="s-save-data"/>-->
                </xf:trigger>
                <xf:trigger class="t-plus" model="m-child-model" title="Add Agent">
                    <xf:label>+</xf:label>
                    <xf:insert nodeset="instance()/vra:agent[last()]" origin="instance('i-templates')/vra:agent"
                               model="m-child-model"/>
                </xf:trigger>
            </div>
            <div>{$recordId}</div>
            <xf:group appearance="minimal" ref="instance('i-agentSet')" model="m-child-model">
                <xf:label/>

                <table class="table table-condensed" border="1">
<!--
                    <thead>
                        <tr>
                            <th rowspan="2"></th>
                            <th>Type</th>
                            <th>Name</th>
                            <td rowspan="2"/>
                        </tr>
                    </thead>
-->
                    <tbody  id="r-vraAgent" xf:repeat-nodeset="vra:agent" model="m-child-model">
                        <!-- ### the name element ### -->
                        <tr>
                            <td rowspan="5">
                                <xf:input ref="@pref">
                                    <xf:label>pref</xf:label>
                                </xf:input>
                            </td>
                            <td>Name</td>
                            <td>
                                <xf:input ref="vra:name" type="nodeValue" class="elementName">
                                    <xf:label>Name</xf:label>
                                </xf:input>
                                <xf:select1 ref="vra:name/@type">
                                    <xf:label>Type</xf:label>
                                    <xf:item>
                                        <xf:label>Personal</xf:label>
                                        <xf:value>personal</xf:value>
                                    </xf:item>
                                    <xf:item>
                                        <xf:label>Corporate</xf:label>
                                        <xf:value>corporate</xf:value>
                                    </xf:item>
                                    <xf:item>
                                        <xf:label>Family</xf:label>
                                        <xf:value>family</xf:value>
                                    </xf:item>
                                    <xf:item>
                                        <xf:label>Other</xf:label>
                                        <xf:value>other</xf:value>
                                    </xf:item>
                                </xf:select1>
                                <div class="vraAttributes">
                                    <xf:output ref="vra:name/@dataDate">
                                        <xf:label>dataDate</xf:label>
                                    </xf:output>
                                    <xf:output ref="vra:name/@extent">
                                        <xf:label>extent</xf:label>
                                    </xf:output>
                                    <xf:output ref="vra:name/@href">
                                        <xf:label>href</xf:label>
                                    </xf:output>
                                    <xf:output ref="vra:name/@xml:lang">
                                        <xf:label>lang</xf:label>
                                    </xf:output>
                                    <xf:output ref="vra:name/@pref">
                                        <xf:label>pref</xf:label>
                                    </xf:output>
                                    <xf:output ref="vra:name/@refid">
                                        <xf:label>refid</xf:label>
                                    </xf:output>
                                    <xf:output ref="vra:name/@rules">
                                        <xf:label>rules</xf:label>
                                    </xf:output>
                                    <xf:output ref="vra:name/@source">
                                        <xf:label>source</xf:label>
                                    </xf:output>
                                    <xf:output ref="vra:name/@vocab">
                                        <xf:label>vocab</xf:label>
                                    </xf:output>

                                </div>
                            </td>

<!--
                            <td>
                                <xf:select1 ref="vra:name/@vocab">
                                    <xf:label>vocab</xf:label>
                                    <xf:item>
                                        <xf:label>ULAN</xf:label>
                                        <xf:value>ULAN</xf:value>
                                    </xf:item>
                                    <xf:item>
                                        <xf:label>GND</xf:label>
                                        <xf:value>GND</xf:value>
                                    </xf:item>
                                    <xf:item>
                                        <xf:label>(AKL)</xf:label>
                                        <xf:value>(AKL)</xf:value>
                                    </xf:item>
                                </xf:select1>
                            </td>
-->
                            <td rowspan="5">
                                <xf:trigger>
                                    <xf:label>x</xf:label>
                                    <xf:delete nodeset="instance('i-agentSet')/vra:agent[index('r-vraAgent')]"/>
                                </xf:trigger>
                            </td>
                        </tr>

                        <!-- ### the role element #### -->
                        <tr>
                            <td>Role</td>
                            <td>
                                <xf:input ref="vra:role">
                                    <xf:label>Role</xf:label>
                                </xf:input>
                            </td>
                        </tr>

                        <tr>
                            <td>Attribution</td>
                            <td>
                                <xf:input ref="vra:attribution">
                                    <xf:label>Attribution</xf:label>
                                </xf:input>
                            </td>
                        </tr>

                        <tr>
                            <td>Culture</td>
                            <td>
                                <xf:input ref="vra:culture">
                                    <xf:label>Culture</xf:label>
                                </xf:input>

                            </td>
                        </tr>
                        <tr>
                            <td>Dates</td>
                            <td>
                                <xf:input ref="vra:dates/@type">
                                    <xf:label>Dates</xf:label>
                                </xf:input>
                                Earliest Date
                                <xf:input ref="vra:dates/vra:earliestDate">
                                    <xf:label>earliest Date</xf:label>
                                </xf:input>
                                circa
                                <xf:input ref="vra:dates/vra:earliestDate/@circa">
                                    <xf:label>circa</xf:label>
                                </xf:input>
                                Latest Date
                                <xf:input ref="vra:dates/vra:latestDate">
                                    <xf:label>latest Date</xf:label>
                                </xf:input>
                                circa
                                <xf:input ref="vra:dates/vra:latestDate/@circa">
                                    <xf:label>circa</xf:label>
                                </xf:input>
                            </td>
                        </tr>
                    </tbody>
                </table>


                <!-- ############################## NOTES ####################################### -->
                <!-- ############################## NOTES ####################################### -->
                <!-- ############################## NOTES ####################################### -->
                <xf:group class="showNotesDisplay">
                    <xf:trigger class="notesDisplayTrigger">
                        <xf:label>Show/Hide Notes and Display</xf:label>
                        <xf:setvalue ref="instance('i-agentSetController')/showNotesDisplay"
                                     value="not(boolean-from-string(instance('i-agentSetController')/showNotesDisplay))"/>
                    </xf:trigger>
                    <xf:group ref="instance('i-agentSetController')/showNotesDisplay">
                        <xf:group appearance="minimal" class="elementGroup" ref="instance('i-agentSet')">
                            <xf:label/>
                            <xf:textarea ref="vra:display" type="nodeValue" model="m-child-model">
                                <xf:label>Display:</xf:label>
                            </xf:textarea>
                        </xf:group>
                        <xf:group appearance="minimal" class="elementGroup" ref="instance('i-agentSet')">
                            <xf:label/>
                            <xf:textarea ref="vra:notes" type="nodeValue" model="m-child-model">
                                <xf:label>Notes</xf:label>
                            </xf:textarea>
                        </xf:group>
                    </xf:group>
                </xf:group>
            </xf:group>


        </div>
    </body>
</html>


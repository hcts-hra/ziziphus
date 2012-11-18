<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:vra="http://www.vraweb.org/vracore4.htm"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xmlns:functx="http://www.functx.com"
                xmlns:xf="http://www.w3.org/2002/xforms"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:ev="http://www.w3.org/2001/xml-events"
                xmlns:bfc="http://betterform.sourceforge.net/xforms/controls"
                xpath-default-namespace="http://www.w3.org/2002/xforms" exclude-result-prefixes="functx">

    <!--
    This transform is used to tailor the subforms to the needs of the Ziziphus project. For efficiency
    reasons the subforms are kept as small as possible meaning that redundant parts as the attribute handling
    are put into their own subforms.
    -->
    <xsl:include href="ignores.xsl" />
    <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>
    <xsl:strip-space elements="*"/>


    <!--
        ########################################################################################
            EXTERNAL PARAMETERS
        ########################################################################################
    -->
    <xsl:param name="debug" select="'TAKEN_FROM_BUILD.XML'" as="xsd:string"/>
    <xsl:param name="path_2_vra_types_schema" select="'TAKEN_FROM_BUILD.XML'" as="xsd:string"/>
    <xsl:param name="path_2_xf_instance" select="'TAKEN_FROM_BUILD.XML'" as="xsd:string"/>
    <xsl:param name="vraSection" select="'TAKEN_FROM_BUILD.XML'" as="xsd:string"/>
    <xsl:variable name="vraSectionNode" select="functx:lowercase-first($vraSection)"/>



    <!--
        ########################################################################################
            GLOBAL VARIABLES
        ########################################################################################
    -->

    <!-- Here we assume the naming convention in VRA that agentSet core item is called agent, etc. -->
    <xsl:variable name="vraArtifact" select="substring($vraSection, 1, (string-length($vraSection)-3))"/>
    <xsl:variable name="vraArtifactNode" select="functx:lowercase-first($vraArtifact)"/>

    <xsl:variable name="debugEnabled" as="xsd:boolean">
        <xsl:choose>
            <xsl:when test="$debug eq 'true' or $debug eq 'true()' or number($debug) gt 0">true</xsl:when>
            <xsl:otherwise>false</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <xsl:variable name="vraTypes" select="doc($path_2_vra_types_schema)"/>
    <xsl:variable name="vraInstance" select="doc($path_2_xf_instance)"/>


<!--
    ########################################################################################
        TEMPLATE RULES
    ########################################################################################
-->
    <xsl:template match="xf:bind[@nodeset='vra:vra']">
        <!-- Check if referenced resources are available -->

        <xsl:if test="not(exists($vraInstance))">
            <xsl:message terminate="yes">XSD with schema redefinition rules is missing</xsl:message>
        </xsl:if>
        <xsl:variable name="result">
        <html>
            <head>
                <title>Ziziphus_Image_DB</title>

                <!-- TODO: externalize this -->
                <style type="text/css">
                    .xfRequired .xfLabel:after{
                        content:'';
                    }
                    .xfRequired > .xfLabel:after{
                        content:'*';
                    }

                    table, td {
                        border: thin solid #999999;
                        border-collapse: collapse;
                        padding: 3px;
                    }

                    tbody {
                        font-size: 0.85em;
                    }
                    tbody .xfGroup > .xfControl .xfLabel {
                        float: left;
                        padding: 0;
                        margin: 3px 3px 0 7px;
                        min-width: 80px;
                        text-align: right;
                    }
                    tbody tr td > .xfGroup {
                        background: #fafafa;
                        border-top: thin solid;
                        border-bottom: thin solid #cdcdcd;
                        padding: 5px 0;
                    }
                    tbody tr td .xfGroup:last-child {
                        border-bottom: none;
                    }
                    .xfRepeatItem {
                        background: whitesmoke;
                    }

                    .xfRepeatIndex .contentCol {
                        background-color: whitesmoke;
                    }
                    .bf .xfRepeatIndex {
                        background: #dddddd !important;
                    }
                    td{
                        vertical-align: top;
                    }
                    .vraAttributes .xfControl{
                        float:left;
                    }

                    .prefCol, .triggerCol {
                        width: 10px;
                    }
                    .prefCol .xfLabel{
                        display: none;
                    }
                    .contentCol > .xfGroup {
                        width: 100%;
                        display: inline-block;
                        padding-bottom: 5px;
                        border-top: none !important;
                    }
                    .vraAttributes .xfControl {
                        border: thin solid #aaaaaa;
                        border-radius: 3px;
                        margin: 5px 5px 5px 0;
                        padding: 3px;
                        background: #eeeeee;
                        text-align: center;
                    }
                    .vraAttributes .xfLabel, .vraAttributes .xfValue{
                        font-size: 0.85em;
                    }
                    .vraAttributes .xfLabel {
                        margin: 0 !important;
                        padding: 0 !important;
                        border-bottom: thin solid #aaaaaa;
                    }

                    .prefCol .xfLabel {
                        display: none !important;
                    }
                    .vraAttributeTrigger {
                        float: right;
                    }
                    #attrDialog .xfControl {
                        float: none;
                    }
                    .buttonBar .xfTrigger{
                        display: inline-block !important;
                        font-size: 0.85em;
                        margin: 5px;
                    }
                </style>

            </head>
            <body>
                <div id="xforms">

<xsl:comment> ###################### MODEL ################################## </xsl:comment>
<xsl:comment> ###################### MODEL ################################## </xsl:comment>
<xsl:comment> ###################### MODEL ################################## </xsl:comment>

                    <div style="display:none">
                        <xf:model id="m-child-model" schema="../resources/xsd/vra-types.xsd">
                            <xf:instance id="i-{$vraSectionNode}">
                                    <xsl:apply-templates select="$vraInstance/vra:vra/vra:work/*[local-name(.)=$vraSectionNode]" mode="instance">
                                        <xsl:with-param name="path" select="'instance()'"/>
                                    </xsl:apply-templates>
                            </xf:instance>

                            <xf:bind nodeset="instance()">
                                <xsl:apply-templates select="xf:bind[@nodeset='vra:work']/xf:bind[@nodeset=concat('vra:',$vraSectionNode)]/*" mode="bind">
                                    <xsl:with-param name="path" select="'instance()'"/>
                                </xsl:apply-templates>
                            </xf:bind>

                            <xf:instance id="i-templates">
                                <templates xmlns="http://www.vraweb.org/vracore4.htm">
                                    <xsl:apply-templates select="$vraInstance/vra:vra/vra:work/*[local-name()=$vraSectionNode]/*[local-name()=$vraArtifactNode]" mode="instance">
                                        <xsl:with-param name="path" select="'instance()'"/>
                                    </xsl:apply-templates>

                                    <notes/>
                                    <display/>
                                </templates>
                            </xf:instance>

                            <xi:include href="bricks/vraAttributesInstance.xml"/>

                            <xf:instance id="i-util">
                                <data xmlns="">
                                    <currentElement/>
                                </data>
                            </xf:instance>
                        </xf:model>
                    </div>

<xsl:comment> ####################################### VISIBLE UI ####################################### </xsl:comment>
<xsl:comment> ####################################### VISIBLE UI ####################################### </xsl:comment>
<xsl:comment> ####################################### VISIBLE UI ####################################### </xsl:comment>

                    <div class="toolbar">
                        <xf:trigger class="t-save" model="m-child-model" title="Save">
                            <xf:label>save</xf:label>
                        </xf:trigger>
                        <xf:trigger class="t-plus" model="m-child-model">
                            <xsl:attribute name="title">Add <xsl:value-of select="$vraArtifact"/></xsl:attribute>
                            <xf:label>+</xf:label>
                            <xf:insert model="m-child-model">
                                <xsl:attribute name="nodeset">instance()/vra:<xsl:value-of select="$vraArtifactNode"/>[last()]</xsl:attribute>
                                <xsl:attribute name="origin">instance('i-templates')/vra:<xsl:value-of select="$vraArtifactNode"/></xsl:attribute>
                            </xf:insert>
                        </xf:trigger>
                    </div>

                    <xsl:apply-templates select="xf:bind[@nodeset='vra:work']/xf:bind[@nodeset=concat('vra:',$vraSectionNode)]" mode="ui">
                        <xsl:with-param name="path" select="'instance()'"/>
                    </xsl:apply-templates>

                    <bfc:dialog id="attrDialog">
                        <xf:label>Attributes</xf:label>
                        <xf:group appearance="full" ref="instance('i-vraAttributes')/vra:vraElement">
                            <xf:label/>
                            <xf:input ref="@dataDate" id="first">
                                <xf:label>dataDate</xf:label>
                            </xf:input>
                            <xf:input ref="@extent">
                                <xf:label>extent</xf:label>
                            </xf:input>
                            <xf:input ref="@href">
                                <xf:label>href</xf:label>
                            </xf:input>
                            <xf:input ref="@refid">
                                <xf:label>refid</xf:label>
                            </xf:input>
                            <xf:input ref="@rules">
                                <xf:label>rules</xf:label>
                            </xf:input>
                            <xf:input ref="@source">
                                <xf:label>source</xf:label>
                            </xf:input>
                            <xf:select1 ref="@vocab">
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
                            <xf:input ref="@lang">
                                <xf:label>Language</xf:label>
                            </xf:input>
                            <xf:input ref="@transliteration">
                                <xf:label>Transliteration</xf:label>
                            </xf:input>
                            <xf:input ref="@script">
                                <xf:label>Script</xf:label>
                            </xf:input>
                            <xf:group class="buttonBar">
                                <xf:trigger>
                                    <xf:label>Ok</xf:label>
                                    <xf:action>
                                        <xf:insert origin="instance('i-vraAttributes')/vra:vraElement[1]/@*[string-length(.) != 0]">
                                            <xsl:attribute name="context">instance('i-<xsl:value-of select="$vraSectionNode"/>')/vra:<xsl:value-of select="$vraArtifactNode"/>[index('r-vra<xsl:value-of select="$vraArtifact"/>')]/*[local-name()=instance('i-util')/currentElement]</xsl:attribute>
                                        </xf:insert>
                                    </xf:action>
                                    <bfc:hide dialog="attrDialog"></bfc:hide>
                                </xf:trigger>
                                <xf:trigger appearance="minimal">
                                    <xf:label>Cancel</xf:label>
                                    <bfc:hide dialog="attrDialog"></bfc:hide>
                                </xf:trigger>
                            </xf:group>
                        </xf:group>
                    </bfc:dialog>
                </div>
            </body>
        </html>
        </xsl:variable>

        <xsl:copy-of select="$result"/>
    </xsl:template>



    <!--
        ########################################################################################
            MODE: INSTANCE - CREATION OF XFORMS INSTANCES
        ########################################################################################
    -->
    <xsl:template match="vra:*" mode="instance">
        <xsl:param name="path" select="''"/>
        <xsl:variable name="vraNodeName" select="local-name(.)"/>
        <xsl:variable name="currentPath" select="concat($path,'/vra:',$vraNodeName)"/>

        <xsl:copy>
            <!-- Common VRA attributes get ignored in ignores.xsl, so here
                 goes the special case for top-level @pref
                 (agentSet/agent/@pref etc.)
            -->
            <xsl:if test="(local-name()=$vraArtifactNode) and (..[local-name()=$vraSectionNode])">
                <xsl:copy-of select="@pref"/>
            </xsl:if>

            <xsl:apply-templates select="@*|text()" mode="instanceAttrs"/>
            <xsl:apply-templates mode="instance">
                <xsl:with-param name="path" select="$currentPath"/>
            </xsl:apply-templates>
        </xsl:copy>
    </xsl:template>


    <!--
        ########################################################################################
            MODE: BIND - CREATION OF XFORMS BINDS
        ########################################################################################
    -->

    <xsl:template match="xf:bind[@nodeset=concat('vra:',$vraSectionNode)]" mode="bind" priority="40">
        <xsl:param name="path" select="''"/>

        <xsl:variable name="vraNodeName" select="@nodeset"/>
        <xsl:variable name="currentPath" select="concat($path,'/',$vraNodeName)"/>
        
        <xf:bind>
            <xsl:attribute name="nodeset" select="$vraNodeName"/>
            <xsl:apply-templates mode="bind" select="*[not(starts-with(@nodeset,'@'))]">
                <xsl:with-param name="path" select="$currentPath"/>
            </xsl:apply-templates>
        </xf:bind>
    </xsl:template>

    <xsl:template match="xf:bind[@xfType = 'complexType']" mode="bind" priority="20">
        <xsl:param name="path" select="''"/>
        <xsl:variable name="vraNodeName" select="@nodeset"/>
        <xsl:variable name="currentPath" select="concat($path,'/',$vraNodeName)"/>

        <xsl:variable name="nodesetValue" select="@nodeset"/>
        <xf:bind>
            <xsl:attribute name="nodeset" select="$nodesetValue"/>
            <xsl:if test="exists(@type) and not(@type = 'xsd:string')">
                <xsl:attribute name="type" select="@type"/>
            </xsl:if>

            <!-- Common VRA attributes get ignored in ignores.xsl, so here
                 goes the special case for top-level @pref
                 (agentSet/agent/@pref etc.)
            -->
            <xsl:if test="..[(local-name()='bind') and (@nodeset=concat('vra:',$vraSectionNode))]">
                <xf:bind>
                    <xsl:attribute name="nodeset">@pref</xsl:attribute>
                    <xsl:attribute name="type">boolean</xsl:attribute>
                </xf:bind>
            </xsl:if>

            <xsl:apply-templates mode="bind">
                <xsl:with-param name="path" select="$currentPath"/>
            </xsl:apply-templates>
        </xf:bind>
    </xsl:template>

    <xsl:template match="xf:bind" mode="bind" >
        <xsl:param name="path" select="''"/>

        <xsl:variable name="vraNodeName" select="@nodeset"/>
        <xsl:variable name="currentPath" select="concat($path,'/',$vraNodeName)"/>

        <xf:bind>
            <xsl:attribute name="nodeset" select="$vraNodeName"/>
            <xsl:if test="exists(@type) and not(@type = 'xsd:string')">
                <xsl:attribute name="type" select="@type"/>
            </xsl:if>
            <xsl:apply-templates mode="bind">
                <xsl:with-param name="path" select="$currentPath"/>
            </xsl:apply-templates>
        </xf:bind>
    </xsl:template>    



    <!--
        ########################################################################################
            MODE: UI - CREATION OF XFORMS UI CONTROLS
        ########################################################################################
    -->
    
    <!-- section (like AgentSet) -->
    <xsl:template match="xf:bind[@nodeset=concat('vra:',$vraSectionNode)]" mode="ui" priority="40">
        <xsl:param name="path" select="''"/>
        
        <xsl:variable name="vraNodeName" select="@nodeset"/>
        <xsl:variable name="currentPath" select="concat($path,'/',$vraNodeName)"/>
        
        <xf:group appearance="minimal" class="vraRecord" model="m-child-model">
            <xsl:attribute name="ref">instance('i-<xsl:value-of select="$vraSectionNode"/>')</xsl:attribute>

            <xsl:if test="$debugEnabled">
                <xsl:message>UI root</xsl:message>
            </xsl:if>

            <table>
                <tbody model="m-child-model">
                    <xsl:attribute name="id">r-vra<xsl:value-of select="$vraArtifact"/></xsl:attribute>
                    <xsl:attribute name="xf:repeat-nodeset">vra:<xsl:value-of select="$vraArtifactNode"/></xsl:attribute>

                    <xsl:apply-templates mode="ui" select="*[not(starts-with(@nodeset,'@'))]">
                        <xsl:with-param name="path"  select="$currentPath"/>
                        <xsl:with-param name="depth" select="1"/>
                    </xsl:apply-templates>
                </tbody>
            </table>

            <xf:group class="showNotesDisplay">
                <xf:trigger class="notesDisplayTrigger">
                    <xf:label>Show/Hide Notes and Display</xf:label>
                    <xf:setvalue>
                        <xsl:attribute name="ref">instance('i-<xsl:value-of select="$vraSectionNode"/>Controller')/showNotesDisplay</xsl:attribute>
                        <xsl:attribute name="value">not(boolean-from-string(instance('i-<xsl:value-of select="$vraSectionNode"/>Controller')/showNotesDisplay))</xsl:attribute>
                    </xf:setvalue>
                </xf:trigger>
                <xf:group>
                    <xsl:attribute name="ref">instance('i-<xsl:value-of select="$vraSectionNode"/>Controller')/showNotesDisplay</xsl:attribute>
                    <xf:group appearance="minimal" class="elementGroup">
                        <xsl:attribute name="ref">instance('i-<xsl:value-of select="$vraSectionNode"/>')</xsl:attribute>
                        <xf:label/>
                        <xf:textarea ref="vra:display" type="nodeValue" model="m-child-model">
                            <xf:label>Display:</xf:label>
                        </xf:textarea>
                    </xf:group>
                    <xf:group appearance="minimal" class="elementGroup">
                        <xsl:attribute name="ref">instance('i-<xsl:value-of select="$vraSectionNode"/>')</xsl:attribute>
                        <xf:label/>
                        <xf:textarea ref="vra:notes" type="nodeValue" model="m-child-model">
                            <xf:label>Notes</xf:label>
                        </xf:textarea>
                    </xf:group>
                </xf:group>
            </xf:group>
        </xf:group>
    </xsl:template>

    <xsl:template match="xf:bind[@xfType = 'complexType']" mode="ui" priority="20">
        <xsl:param name="path" select="''" />
        <xsl:param name="depth" select="''"/>
        <xsl:variable name="vraNodeName" select="@nodeset"/>
        <xsl:variable name="currentPath" select="concat($path,'/',$vraNodeName)"/>

        <!-- artifact node: agent etc. -->
        <xsl:variable name="artifactNode" select="(1=number($depth)) and ($vraNodeName=concat('vra:',$vraArtifactNode))"/>

        <xsl:if test="$debugEnabled">
            <xsl:message>UI-2 (<xsl:value-of select="$depth"/>, <xsl:value-of select="$artifactNode"/>): create xf:group for '<xsl:value-of select="$vraNodeName"/>' xpath is: '<xsl:value-of select="$currentPath"/>'</xsl:message>
        </xsl:if>

        <xsl:choose>
            <xsl:when test="$artifactNode">
                <tr>
                    <td class="prefCol">
                        <xf:input ref="@pref">
                            <xf:label>pref</xf:label>
                            <xf:hint>preferred</xf:hint>
                        </xf:input>
                    </td>
                    <td class="contentCol">
                        <xsl:apply-templates select="*[@nodeset='vra:name']" mode="ui">
                            <xsl:with-param name="path" select="$vraNodeName"/>
                            <xsl:with-param name="depth" select="1+$depth"/>
                        </xsl:apply-templates>
                        <xsl:apply-templates select="*[@nodeset!='vra:name']" mode="ui">
                            <xsl:with-param name="path" select="$vraNodeName"/>
                            <xsl:with-param name="depth" select="1+$depth"/>
                        </xsl:apply-templates>
                    </td>
                    <td class="triggerCol">
                        <xf:trigger>
                            <xf:label>x</xf:label>
                            <xf:delete>
                                <xsl:attribute name="nodeset">instance('i-<xsl:value-of select="$vraSectionNode"/>')/vra:<xsl:value-of select="$vraArtifactNode"/>[index('r-vra<xsl:value-of select="$vraArtifact"/>')]</xsl:attribute>
                            </xf:delete>
                        </xf:trigger>
                    </td>
                </tr>
            </xsl:when>
            <xsl:otherwise>
                <xf:group ref="{$vraNodeName}" appearance="minimal" class="vraComplex" model="m-child-model">
                    <xf:label><xsl:value-of select="functx:capitalize-first($vraNodeName)"/></xf:label>
                    <xsl:apply-templates mode="ui">
                        <xsl:with-param name="path" select="$vraNodeName"/>
                        <xsl:with-param name="depth" select="1+$depth"/>
                    </xsl:apply-templates>
                </xf:group>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="xf:bind[not(exists(xf:bind/xf:bind)) and not(starts-with(@nodeset,'@'))]" mode="ui" priority="10">
        <xsl:param name="path" select="''" />
        <xsl:variable name="vraNodeName" select="@nodeset"/>

        <xsl:if test="$debugEnabled">
            <xsl:message>UI-3: create xf:control for '<xsl:value-of select="$vraNodeName"/>' xpath is: '<xsl:value-of select="$path"/>'</xsl:message>
        </xsl:if>

        <xf:group appearance="minimal">
            <xf:input ref="{$vraNodeName}" type="nodeValue">
                <xsl:if test="'vra:name'=$vraNodeName">
                    <xsl:attribute name="class">elementName</xsl:attribute>
                </xsl:if>
                <xf:label>
                    <xsl:value-of select="functx:capitalize-first($vraNodeName)"/>
                </xf:label>
            </xf:input>

            <xsl:apply-templates select="*[@nodeset='@type' and @attrName='type' and starts-with(@type,'vra:') and @xfType='attribute']" mode="ui"/>

            <xf:group class="vraAttributes" appearance="minimal">
                <xsl:attribute name="ref" select="$vraNodeName"/>
                <xi:include href="bricks/vraAttributesViewUI.xml"/>
            </xf:group>

            <xf:trigger class="vraAttributeTrigger">
                <xf:label>...</xf:label>
                <xf:setvalue ref="instance('i-util')/currentElement">
                    <xsl:attribute name="value">'<xsl:value-of select="functx:remove-vra-prefix($vraNodeName)"/>'</xsl:attribute>
                </xf:setvalue>
                <xf:insert context="instance('i-vraAttributes')/vra:vraElement[1]">
                    <xsl:attribute name="origin">instance('i-<xsl:value-of select="$vraSectionNode"/>')/vra:<xsl:value-of select="$vraArtifactNode"/>[index('r-vra<xsl:value-of select="$vraArtifact"/>')]/<xsl:value-of select="$vraNodeName"/>/@*</xsl:attribute>
                </xf:insert>
                <bfc:show dialog="attrDialog" ev:event="DOMActivate"/>
            </xf:trigger>
        </xf:group>

<!--
        <div class="agentSet-{substring-after($vraNodeName,'vra:')}-attributes hiddenAttributes" style="display:none;">
            <xsl:apply-templates mode="ui">
                <xsl:with-param name="path" select="$vraNodeName"/>
            </xsl:apply-templates>
        </div>
-->
    </xsl:template>

    <xsl:template match="xf:bind[starts-with(@nodeset,'@')]" mode="ui" priority="10">
        <xsl:param name="path" select="''" />
        <xsl:variable name="vraNodeName" select="@nodeset"/>
        <xsl:variable name="currentPath" select="concat($path,'/',$vraNodeName)"/>

        <xsl:if test="$debugEnabled">
            <xsl:message>UI-4: create xf:control for '<xsl:value-of select="$vraNodeName"/>' attribute,  xpath is: '<xsl:value-of select="$currentPath"/>'</xsl:message>
        </xsl:if>

        <xf:group appearance="minimal">
            <xf:input ref="{$currentPath}" type="attributeValue">
                <xf:label><xsl:value-of select="substring-after($vraNodeName,'@')"/></xf:label>
            </xf:input>

            <xsl:apply-templates mode="ui">
                <xsl:with-param name="path" select="$currentPath"/>
            </xsl:apply-templates>
        </xf:group>
    </xsl:template>

    <xsl:template match="xf:bind[@nodeset='@type' and @attrName='type' and starts-with(@type,'vra:') and @xfType='attribute']" mode="ui" priority="15">
        <xsl:variable name="vraTypeName" select="substring-after(@type,'vra:')"/>

        <xsl:if test="$debugEnabled">
            <xsl:message>UI-5: generate type: <xsl:value-of select="@type"/></xsl:message>
        </xsl:if>

        <xsl:apply-templates select="$vraTypes/*/xsd:simpleType[@name=$vraTypeName][1]/*" mode="ui">
            <xsl:with-param name="pref"><xsl:value-of select="../@nodeset"/>/@type</xsl:with-param>
            <xsl:with-param name="plabel">Type</xsl:with-param>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="xsd:restriction[@base='xsd:string']" mode="ui">
        <xsl:param name="pref"   select="''" />
        <xsl:param name="plabel" select="''" />

        <xsl:if test="$debugEnabled">
            <xsl:message>UI-6: generate restriction</xsl:message>
        </xsl:if>

        <xf:select1>
            <xsl:attribute name="ref"><xsl:value-of select="$pref"/></xsl:attribute>
            <xf:label><xsl:value-of select="$plabel"/></xf:label>
            <xsl:for-each select="xsd:enumeration">
                <xf:item>
                    <xf:label><xsl:value-of select="functx:capitalize-first(@value)"/></xf:label>
                    <xf:value><xsl:value-of select="@value"/></xf:value>
                </xf:item>
            </xsl:for-each>
        </xf:select1>
    </xsl:template>

    <xsl:template match="xf:bind" mode="ui">
        <xsl:message>Matched xf:bind with nodeset='<xsl:value-of select="@nodeset"/>'</xsl:message>
        <xsl:message terminate="yes">This rule must never be matched</xsl:message>
    </xsl:template>

    <!--
        ########################################################################################
            HELPER TEMPLATE RULES (simply copying nodes and comments)
        ########################################################################################
    -->

    <xsl:template match="*">
        <xsl:apply-templates/>
    </xsl:template>

<!--
    <xsl:template match="text()">
        <xsl:copy/>
    </xsl:template>
-->

    <xsl:template match="comment()" priority="20">
        <xsl:copy/>
    </xsl:template>

    <xsl:function name="functx:remove-vra-prefix" as="xsd:string?">
        <xsl:param name="arg" as="xsd:string?"/>
        <xsl:choose>
            <xsl:when test="starts-with($arg, 'vra')"><xsl:value-of select="substring-after($arg, 'vra:')"/></xsl:when>
            <xsl:otherwise><xsl:value-of select="$arg"/></xsl:otherwise>
        </xsl:choose>
    </xsl:function>

    <xsl:function name="functx:capitalize-first" as="xsd:string?">
        <xsl:param name="arg" as="xsd:string?"/>
        <xsl:variable name="string2capitalize" select="functx:remove-vra-prefix($arg)"/>
        <xsl:sequence select="concat(upper-case(substring($string2capitalize,1,1)),substring($string2capitalize,2))"/>
    </xsl:function>

    <xsl:function name="functx:lowercase-first" as="xsd:string?">
        <xsl:param name="arg" as="xsd:string?"/>
        <xsl:variable name="string2lowercase" select="functx:remove-vra-prefix($arg)"/>
        <xsl:sequence select="concat(lower-case(substring($string2lowercase,1,1)),substring($string2lowercase,2))"/>
    </xsl:function>

</xsl:stylesheet>


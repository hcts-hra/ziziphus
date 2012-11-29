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
                xmlns:bf="http://betterform.sourceforge.net/xforms"
                xmlns:bfc="http://betterform.sourceforge.net/xforms/controls"
                bf:transform="/apps/ziziphus/resources/xsl/ziziphus.xsl"
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
        <html
            xmlns:bf="http://betterform.sourceforge.net/xforms"
            bf:transform="/apps/ziziphus/resources/xsl/ziziphus.xsl">
            <head>
                <link href="../resources/css/edit-form.css" rel="stylesheet" type="text/css"/>
                <title>Ziziphus_Image_DB</title>
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

                    <xsl:apply-templates select="xf:bind[@nodeset='vra:work']/xf:bind[@nodeset=concat('vra:',$vraSectionNode)]" mode="ui"/>

                    <bfc:dialog id="attrDialog">
                        <xf:label>Attributes</xf:label>
                        <xf:group appearance="minimal" ref="instance('i-vraAttributes')/vra:vraElement">
                            <xf:group appearance="minimal" class="attrDialogGroup">
                                <xf:input ref="@dataDate" id="first">
                                    <xf:label>dataDate</xf:label>
                                </xf:input>
                                <xf:trigger class="deleteAttribute">
                                    <xf:label>delete</xf:label>
                                    <xf:setvalue ref="@dataDate"/>
                                </xf:trigger>
                            </xf:group>
                            <xf:group appearance="minimal" class="attrDialogGroup">
                                <xf:input ref="@extent">
                                    <xf:label>extent</xf:label>
                                </xf:input>
                                <xf:trigger class="deleteAttribute">
                                    <xf:label>delete</xf:label>
                                    <xf:setvalue ref="@extent"/>
                                </xf:trigger>
                            </xf:group>
                            <xf:group appearance="minimal" class="attrDialogGroup">
                                <xf:input ref="@href">
                                    <xf:label>href</xf:label>
                                </xf:input>
                                <xf:trigger class="deleteAttribute">
                                    <xf:label>delete</xf:label>
                                    <xf:setvalue ref="@href"/>
                                </xf:trigger>
                            </xf:group>
                            <xf:group appearance="minimal" class="attrDialogGroup">
                                <xf:input ref="@refid">
                                    <xf:label>refid</xf:label>
                                </xf:input>
                                <xf:trigger class="deleteAttribute">
                                    <xf:label>delete</xf:label>
                                    <xf:setvalue ref="@refid"/>
                                </xf:trigger>
                            </xf:group>
                            <xf:group appearance="minimal" class="attrDialogGroup">
                                <xf:input ref="@rules">
                                    <xf:label>rules</xf:label>
                                </xf:input>
                                <xf:trigger class="deleteAttribute">
                                    <xf:label>delete</xf:label>
                                    <xf:setvalue ref="@rules"/>
                                </xf:trigger>
                            </xf:group>
                            <xf:group appearance="minimal" class="attrDialogGroup">
                                <xf:input ref="@source">
                                    <xf:label>source</xf:label>
                                </xf:input>
                                <xf:trigger class="deleteAttribute">
                                    <xf:label>delete</xf:label>
                                    <xf:setvalue ref="@source"/>
                                </xf:trigger>
                            </xf:group>
                            <xf:group appearance="minimal" class="attrDialogGroup">
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
                                <xf:trigger class="deleteAttribute">
                                    <xf:label>delete</xf:label>
                                    <xf:setvalue ref="@vocab"/>
                                </xf:trigger>
                            </xf:group>
                            <xf:group appearance="minimal" class="attrDialogGroup">
                                <xf:input ref="@lang">
                                    <xf:label>Language</xf:label>
                                </xf:input>
                                <xf:trigger class="deleteAttribute">
                                    <xf:label>delete</xf:label>
                                    <xf:setvalue ref="@lang"/>
                                </xf:trigger>
                            </xf:group>
                            <xf:group appearance="minimal" class="attrDialogGroup">
                                <xf:input ref="@transliteration">
                                    <xf:label>Transliteration</xf:label>
                                </xf:input>
                                <xf:trigger class="deleteAttribute">
                                    <xf:label>delete</xf:label>
                                    <xf:setvalue ref="@transliteration"/>
                                </xf:trigger>
                            </xf:group>
                            <xf:group appearance="minimal" class="attrDialogGroup">
                                <xf:input ref="@script">
                                    <xf:label>Script</xf:label>
                                </xf:input>
                                <xf:trigger class="deleteAttribute">
                                    <xf:label>delete</xf:label>
                                    <xf:setvalue ref="@script"/>
                                </xf:trigger>
                            </xf:group>

                            <xf:group class="buttonBar">
                                <xf:trigger>
                                    <xf:label>Ok</xf:label>
                                    <!--
                                    updating of the common vra attributes:
                                    attributes are updated by first deleting all of the common vra attributes from the
                                    main instance (i-agentset here) and then copying over all values from the i-vraAttributes
                                    instance which represents all values deleted or inputted by the user in the dialog.
                                    -->
                                    <xf:action>
                                        <xf:delete>
                                            <xsl:attribute name="nodeset">instance('i-<xsl:value-of select="$vraSectionNode"/>')/vra:<xsl:value-of select="$vraArtifactNode"/>/*[local-name()=instance('i-util')/currentElement]/@*[local-name(.)=('dataDate','extent','href','refid','rules','source','vocab','lang','transliteration','script')]</xsl:attribute>
                                        </xf:delete>

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
                and several other special cases
            -->
            <xsl:if test="(local-name()=$vraArtifactNode) and (..[local-name()=$vraSectionNode])">
                <xsl:copy-of select="@pref"/>

                <xsl:if test="('Measurements'=$vraArtifact)">
                    <xsl:attribute name="extent"/>
                </xsl:if>
                <xsl:if test="('Relation'=$vraArtifact)">
                    <xsl:attribute name="href"/>
                </xsl:if>
                <xsl:if test="('StateEdition'=$vraArtifact) or ('Title'=$vraArtifact)">
                    <xsl:attribute name="source"/>
                </xsl:if>
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

    <xsl:template match="xf:bind" mode="bind" priority="10">
        <xsl:param name="path" select="''"/>

        <xsl:variable name="vraNodeName" select="@nodeset"/>
        <xsl:variable name="currentPath" select="functx:concat-xpath($path,$vraNodeName)"/>
        <xsl:variable name="isArtifactNode" select="boolean((@nodeset=concat('vra:',$vraArtifactNode)) and (../local-name()='bind') and (../@nodeset=concat('vra:',$vraSectionNode)))"/>

        <xsl:if test="$debugEnabled">
            <xsl:message>Bind: <xsl:value-of select="functx:concat-xpath($path,$vraNodeName)"/></xsl:message>
        </xsl:if>

        <xf:bind>
            <xsl:attribute name="nodeset" select="$vraNodeName"/>
            <xsl:if test="exists(@type) and not(@type = 'xsd:string')">
                <xsl:attribute name="type" select="@type"/>
            </xsl:if>

            <!-- Common VRA attributes get ignored in ignores.xsl, so here
                 goes the special case for top-level @pref
                 (agentSet/agent/@pref etc.)
                 and several other special cases
            -->
            <xsl:if test="$isArtifactNode">
                <xf:bind nodeset="@pref" type="boolean"/>

                <xsl:if test="('Measurements'=$vraArtifact)">
                    <xf:bind nodeset="@extent" type="xsd:string"/>
                </xsl:if>
                <xsl:if test="('Relation'=$vraArtifact)">
                    <xf:bind nodeset="@href" type="xsd:string"/>
                </xsl:if>
                <xsl:if test="('StateEdition'=$vraArtifact) or ('Title'=$vraArtifact)">
                    <xf:bind nodeset="@source" type="xsd:string"/>
                </xsl:if>
            </xsl:if>

            <xsl:apply-templates select="*[(@xfType!='simpleType') or exists(child::*)]" mode="bind">
                <xsl:with-param name="path" select="$currentPath"/>
            </xsl:apply-templates>
        </xf:bind>
    </xsl:template>

    <!--
        ########################################################################################
            MODE: UI - CREATION OF XFORMS UI CONTROLS
        ########################################################################################
    -->

    <!-- section (like AgentSet etc.) -->
    <xsl:template match="/xf:bind/xf:bind/xf:bind[@nodeset=concat('vra:',$vraSectionNode)]" mode="ui" priority="50">
        <xsl:variable name="vraNodeName" select="@nodeset"/>
        
        <xf:group id="outerGroup" appearance="minimal" model="m-child-model">
            <xsl:attribute name="ref">instance('i-<xsl:value-of select="$vraSectionNode"/>')</xsl:attribute>

            <xsl:if test="$debugEnabled">
                <xsl:message>UI-1</xsl:message>
            </xsl:if>

            <xf:label/>
            <xf:action ev:event="reset-dialog">

            </xf:action>
            <xf:action ev:event="init-dialog">
                <xf:setvalue ref="instance('i-vraAttributes')/vra:vraElement[1]/@dataDate"/>
                <xf:setvalue ref="instance('i-vraAttributes')/vra:vraElement[1]/@extent"/>
                <xf:setvalue ref="instance('i-vraAttributes')/vra:vraElement[1]/@href"/>
                <xf:setvalue ref="instance('i-vraAttributes')/vra:vraElement[1]/@refid"/>
                <xf:setvalue ref="instance('i-vraAttributes')/vra:vraElement[1]/@rules"/>
                <xf:setvalue ref="instance('i-vraAttributes')/vra:vraElement[1]/@source"/>
                <xf:setvalue ref="instance('i-vraAttributes')/vra:vraElement[1]/@vocab"/>
                <xf:setvalue ref="instance('i-vraAttributes')/vra:vraElement[1]/@lang"/>
                <xf:setvalue ref="instance('i-vraAttributes')/vra:vraElement[1]/@transliteration"/>
                <xf:setvalue ref="instance('i-vraAttributes')/vra:vraElement[1]/@script"/>
                <xf:insert context="instance('i-vraAttributes')/vra:vraElement[1]">
                    <xsl:attribute name="origin">instance('i-<xsl:value-of select="$vraSectionNode"/>')/vra:<xsl:value-of select="$vraArtifactNode"/>[index('r-vra<xsl:value-of select="$vraArtifact"/>')]/*[local-name()=instance('i-util')/currentElement]/@*[local-name(.)=('dataDate','extent','href','refid','rules','source','vocab','lang','transliteration','script')]</xsl:attribute>
                </xf:insert>
            </xf:action>

            <table>
                <tbody model="m-child-model">
                    <xsl:attribute name="id">r-vra<xsl:value-of select="$vraArtifact"/></xsl:attribute>
                    <xsl:attribute name="xf:repeat-nodeset">vra:<xsl:value-of select="$vraArtifactNode"/></xsl:attribute>

                    <xsl:apply-templates mode="ui" select="*[starts-with(@nodeset,'vra:')]"/>
                </tbody>
            </table>

            <xsl:comment> ############################## NOTES ####################################### </xsl:comment>
            <xsl:comment> ############################## NOTES ####################################### </xsl:comment>
            <xsl:comment> ############################## NOTES ####################################### </xsl:comment>

            <xf:switch>
                <xf:case id="c-hidden">
                    <xf:trigger class="notesDisplayTrigger">
                        <xf:label>Show Notes</xf:label>
                        <xf:toggle case="c-showNotes"/>
                    </xf:trigger>
                </xf:case>
                <xf:case id="c-showNotes">
                    <xf:trigger class="notesDisplayTrigger">
                        <xf:label>Hide Notes</xf:label>
                        <xf:toggle case="c-hidden"/>
                    </xf:trigger>
                    <xf:textarea id="notes" ref="vra:notes" type="nodeValue" model="m-child-model">
                        <xf:label>Notes</xf:label>
                    </xf:textarea>
                </xf:case>
            </xf:switch>
        </xf:group>
    </xsl:template>

    <!-- artifact node: agent etc. -->
    <xsl:template match="/xf:bind/xf:bind/xf:bind[@nodeset=concat('vra:',$vraSectionNode)]/xf:bind[@nodeset=concat('vra:',$vraArtifactNode)]" mode="ui" priority="45">
        <xsl:variable name="vraNodeName" select="@nodeset"/>
        <xsl:variable name="xfType" select="@xfType"/>

        <xsl:if test="$debugEnabled">
            <xsl:message>UI-2: <xsl:value-of select="$vraNodeName"/></xsl:message>
        </xsl:if>

        <tr>
            <td class="prefCol">
                <xf:input ref="@pref">
                    <xf:label>pref</xf:label>
                    <xf:hint>preferred</xf:hint>
                </xf:input>
            </td>
            <td class="contentCol">
                <xsl:choose>
                    <xsl:when test="'complexType'=$xfType">
                        <xsl:if test="xf:bind[@xfType='attribute']">
                            <xf:group appearance="minimal">
                                <xsl:apply-templates select="xf:bind[@xfType='attribute']" mode="ui">
                                    <xsl:with-param name="path"/>
                                </xsl:apply-templates>

                                <!-- a special case: some top-level common attributes that we need! -->
                                <xsl:if test="('StateEdition'=$vraArtifact)">
                                    <xf:input ref="@source">
                                        <xf:label>Source</xf:label>
                                    </xf:input>
                                </xsl:if>
                            </xf:group>
                        </xsl:if>

                        <xsl:apply-templates select="xf:bind[(@xfType!='attribute') and (@nodeset='vra:name')]" mode="ui">
                            <xsl:with-param name="path"/>
                        </xsl:apply-templates>
                        <xsl:apply-templates select="xf:bind[(@xfType!='attribute') and (@nodeset!='vra:name')]" mode="ui">
                            <xsl:with-param name="path"/>
                        </xsl:apply-templates>
                    </xsl:when>
                    <xsl:when test="'simpleType'=$xfType">
                        <xf:group appearance="minimal">
                            <xsl:call-template name="ui-nodeset-vra"/>
                        </xf:group>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:message terminate="yes">This rule must never be matched!</xsl:message>
                    </xsl:otherwise>
                </xsl:choose>
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
    </xsl:template>

    <!-- artifact node's (agent etc.) immediate VRA child -->
    <xsl:template match="/xf:bind/xf:bind/xf:bind[@nodeset=concat('vra:',$vraSectionNode)]/xf:bind[@nodeset=concat('vra:',$vraArtifactNode)]/xf:bind[starts-with(@nodeset,'vra:')]" mode="ui" priority="40">
        <xsl:param name="path" select="''" />
        <xsl:variable name="vraNodeName" select="@nodeset"/>

        <xsl:if test="$debugEnabled">
            <xsl:message>UI-3: <xsl:value-of select="$vraNodeName"/></xsl:message>
        </xsl:if>

        <xf:group appearance="minimal">
            <xsl:call-template name="ui-nodeset-vra"/>

            <xf:group class="vraAttributes" appearance="minimal">
                <xsl:attribute name="ref" select="$vraNodeName"/>
                <xi:include href="bricks/vraAttributesViewUI.xml"/>
            </xf:group>

            <xf:trigger class="vraAttributeTrigger">
                <xf:label>...</xf:label>
                <xf:action>
                    <xf:setvalue ref="instance('i-util')/currentElement">
                        <xsl:attribute name="value">'<xsl:value-of select="functx:remove-vra-prefix($vraNodeName)"/>'</xsl:attribute>
                    </xf:setvalue>
                    <xf:dispatch name="init-dialog" targetid="outerGroup"/>
                </xf:action>
                <bfc:show dialog="attrDialog" ev:event="DOMActivate"/>
            </xf:trigger>
        </xf:group>
    </xsl:template>

    <!-- priority=15 because ignores have 20 -->
    <xsl:template name="ui-nodeset-vra" match="xf:bind[starts-with(@nodeset,'vra:')]" mode="ui" priority="15">
        <xsl:param name="path"/>

        <xsl:variable name="vraNodeName" select="@nodeset"/>
        <xsl:variable name="isArtifactNode" select="boolean((@nodeset=concat('vra:',$vraArtifactNode)) and (../local-name()='bind') and (../@nodeset=concat('vra:',$vraSectionNode)))"/>

        <xsl:variable name="currentPath">
            <xsl:choose>
                <xsl:when test="$isArtifactNode">.</xsl:when>
                <xsl:otherwise><xsl:value-of select="functx:concat-xpath($path, $vraNodeName)"/></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:if test="$debugEnabled">
            <xsl:message>UI-4: <xsl:value-of select="$currentPath"/>#</xsl:message>
        </xsl:if>

        <xsl:if test="@xfType='simpleType'">
            <xf:input>
                <xsl:attribute name="ref"><xsl:value-of select="$currentPath"/></xsl:attribute>
                <xsl:if test="not($isArtifactNode) and ('vra:name'=$vraNodeName)">
                    <xsl:attribute name="class">elementName</xsl:attribute>
                </xsl:if>
                <xsl:if test="not($isArtifactNode)">
                    <xf:label>
                        <xsl:value-of select="functx:capitalize-first($vraNodeName)"/>
                    </xf:label>
                </xsl:if>
            </xf:input>
        </xsl:if>

        <xsl:apply-templates select="xf:bind" mode="ui">
            <xsl:with-param name="path" select="$currentPath"/>
        </xsl:apply-templates>

        <!-- a special case: some top-level common attributes that we need! -->
        <xsl:if test="$isArtifactNode">
            <xsl:if test="('Measurements'=$vraArtifact)">
                <xf:input ref="@extent">
                    <xf:label>Extent</xf:label>
                </xf:input>
            </xsl:if>
            <xsl:if test="('Relation'=$vraArtifact)">
                <xf:input ref="@href">
                    <xf:label>URL</xf:label>
                </xf:input>
            </xsl:if>
            <xsl:if test="('Title'=$vraArtifact)">
                <xf:input ref="@source">
                    <xf:label>Source</xf:label>
                </xf:input>
            </xsl:if>
        </xsl:if>
    </xsl:template>

    <!-- attribute VRA type -->
    <xsl:template match="xf:bind[(@xfType='attribute') and starts-with(@type,'vra:')]" mode="ui" priority="30">
        <xsl:param name="path" select="../@nodeset"/>

        <xsl:variable name="vraAttrName" select="@attrName"/>
        <xsl:variable name="vraTypeName" select="substring-after(@type,'vra:')"/>

        <xsl:if test="$debugEnabled">
            <xsl:message>UI-5  (type): <xsl:value-of select="$path"/>, <xsl:value-of select="@nodeset"/>, <xsl:value-of select="@type"/></xsl:message>
        </xsl:if>

        <xsl:apply-templates select="$vraTypes/*/xsd:simpleType[@name=$vraTypeName][1]/*" mode="ui">
            <xsl:with-param name="pref"><xsl:value-of select="functx:concat-xpath($path,concat('@',$vraAttrName))"/></xsl:with-param>
            <xsl:with-param name="plabel"><xsl:value-of select="functx:capitalize-first($vraAttrName)"/></xsl:with-param>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="xsd:restriction[(@base='xsd:string') and count(xsd:enumeration)]" mode="ui">
        <xsl:param name="pref"   select="''" />
        <xsl:param name="plabel" select="''" />

        <xsl:if test="$debugEnabled">
            <xsl:message>UI-6a (type): xsd:string restriction (select1)</xsl:message>
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

    <xsl:template match="xsd:restriction[(@base='xsd:string') and (0=(count(xsd:enumeration)))]" mode="ui">
        <xsl:param name="pref"   select="''" />
        <xsl:param name="plabel" select="''" />

        <xsl:if test="$debugEnabled">
            <xsl:message>UI-6b (type): xsd:string restriction (empty)</xsl:message>
        </xsl:if>

        <xf:input>
            <xsl:attribute name="ref"><xsl:value-of select="$pref"/></xsl:attribute>
            <xf:label><xsl:value-of select="$plabel"/></xf:label>
        </xf:input>
    </xsl:template>

    <!-- priority=15 because ignores have 20 -->
    <xsl:template match="xf:bind[starts-with(@nodeset,'@') and (@xfType='attribute')]" mode="ui" priority="15">
        <xsl:param name="path" select="''" />

        <xsl:variable name="vraNodeName" select="@nodeset"/>
        <xsl:variable name="currentPath" select="functx:concat-xpath($path,$vraNodeName)"></xsl:variable>

        <xsl:if test="$debugEnabled">
            <xsl:message>UI-7: <xsl:value-of select="$currentPath"/></xsl:message>
        </xsl:if>

        <xf:input ref="{$currentPath}">
            <xf:label><xsl:value-of select="substring-after($vraNodeName,'@')"/></xf:label>
        </xf:input>
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

    <xsl:function name="functx:concat-xpath" as="xsd:string?">
        <xsl:param name="arg1" as="xsd:string?"/>
        <xsl:param name="arg2" as="xsd:string?"/>
        <xsl:choose>
            <xsl:when test="0=string-length($arg1)"><xsl:value-of select="$arg2"/></xsl:when>
            <xsl:when test="0=string-length($arg2)"><xsl:value-of select="$arg1"/></xsl:when>
            <xsl:when test="'.'=$arg1"><xsl:value-of select="$arg2"/></xsl:when>
            <xsl:when test="ends-with($arg1,'/')"><xsl:value-of select="concat($arg1,$arg2)"/></xsl:when>
            <xsl:otherwise><xsl:value-of select="concat($arg1,concat('/',$arg2))"/></xsl:otherwise>
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


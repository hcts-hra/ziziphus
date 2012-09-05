<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:vra="http://www.vraweb.org/vracore4.htm"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xmlns:functx="http://www.functx.com"
                xmlns:xf="http://www.w3.org/2002/xforms"
                xpath-default-namespace="http://www.w3.org/2002/xforms" exclude-result-prefixes="functx">

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

    <xsl:param name="mainInstanceName" select="'TAKEN_FROM_BUILD.XML'" as="xsd:string"/>
    <xsl:param name="mainInstancePath" select="'TAKEN_FROM_BUILD.XML'" as="xsd:string"/>
    <xsl:param name="vraSubformType" select="'TAKEN_FROM_BUILD.XML'" as="xsd:string"/>
    <xsl:param name="exclude" select="'TAKEN_FROM_BUILD.XML'" as="xsd:string"/>


    <!--
        ########################################################################################
            GLOBAL VARIABLES
        ########################################################################################
    -->

    <xsl:variable name="debugEnabled" as="xsd:boolean">
        <xsl:choose>
            <xsl:when test="$debug eq 'true' or $debug eq 'true()' or number($debug) gt 0">true</xsl:when>
            <xsl:otherwise>false</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <xsl:variable name="vraTypes" select="doc($path_2_vra_types_schema)"/>
    <xsl:variable name="vraInstance" select="doc($path_2_xf_instance)"/>
    <xsl:param name="vraSubformTypeWithoutNamespace" select="substring-after($vraSubformType,'vra:')" as="xsd:string"/>


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

        <html>
            <head>
                <title>Ziziphus_Image_DB</title>

                <style type="text/css">
                    .bf .xfContainer .xfGroupLabel {
                        font-size: 18px;
                        font-weight: bold;
                    }

                    .bf .xfContainer .xfGroupLabel .xfGroupLabel {
                        font-size: 16px;
                        font-weight: bold;
                    }

                    .bf .xfContainer .xfGroupLabel .xfGroupLabel .xfGroupLabel {
                        font-size: 14px;
                        font-weight: bold;
                    }
                    .bf .xfContainer .xfGroupLabel .xfGroupLabel .xfGroupLabel .xfGroupLabel {
                        font-size: 12px;
                        font-weight: bold;
                    }
                    .bf .xfContainer .xfGroupLabel .xfGroupLabel .xfGroupLabel .xfGroupLabel .xfGroupLabel {
                        font-size: 12px;
                        font-weight: normal;
                    }

                    .bf .xfContainer {
                        border:1px solid gray;
                        padding:10px;
                    }
                    .bf .xfContainer .xfContainer{
                        border:1px solid blue;
                        padding:10px;
                    }

                    .bf .xfContainer .xfContainer .xfContainer{
                        border:1px solid red;
                        padding:10px;
                    }
                        .bf .xfContainer .xfContainer .xfContainer .xfContainer{
                        border:1px solid yellow;
                        padding:10px;
                    }
                    .bf .xfContainer .xfContainer .xfContainer .xfContainer .xfContainer{
                        border:1px solid green;
                        padding:10px;
                    }
                    .bf .xfContainer .xfContainer .xfContainer .xfContainer .xfContainer .xfContainer{
                        border:1px solid orange;
                        padding:10px;
                    }

                </style>
            </head>
            <body>
                <div style="display:none">
                    <xf:model id="{$vraSubformTypeWithoutNamespace}-model" schema="vra-types.xsd">
                        <xsl:call-template name="create-vra-instance"/>
                        <xf:bind nodeset="instance()">
                            <xsl:apply-templates select="*[@nodeset=$vraSubformType]" mode="bind"/>
                        </xf:bind>
                    </xf:model>
                </div>
                <xf:group appearance="full" ref="instance()" model="{$vraSubformTypeWithoutNamespace}-model">
                    <xf:label>Ziziphus Image DB</xf:label>
                    <xsl:apply-templates select="*[@nodeset=$vraSubformType]" mode="ui">
                        <xsl:with-param name="path" select="'instance()'"/>
                    </xsl:apply-templates>
                </xf:group>
            </body>
        </html>
    </xsl:template>



    <!--
        ########################################################################################
            MODE: BIND - CREATION OF XFORMS BINDS
        ########################################################################################
    -->

    <xsl:template match="xf:bind" mode="bind">
<!--
        <xsl:if test="$debug">
            <xsl:message>create xf:bind for '<xsl:value-of select="@nodeset"/>' with type: <xsl:value-of select="@type"/></xsl:message>
        </xsl:if>
-->
        <xsl:choose>
            <xsl:when test="contains($exclude, @nodeset)">
                <xsl:if test="$debugEnabled">
                    <xsl:message>stop creating bind at this point due to subform loading for: '<xsl:value-of select="@nodeset"/>'</xsl:message>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="nodesetValue" select="@nodeset"/>
<!--
                <xsl:variable name="nodesetValue">
                    <xsl:choose>
                        <xsl:when test="starts-with(@nodeset,'@') and @nodeset ne '@xml:lang'">
                            <xsl:value-of select="functx:to-namespace-attribute(@nodeset)"/>
                        </xsl:when>
                        <xsl:otherwise><xsl:value-of select="@nodeset"/></xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
-->
                <xf:bind>
                    <xsl:attribute name="nodeset" select="$nodesetValue"/>
                    <xsl:if test="exists(@type) and not(@type = 'xsd:string')">
                        <xsl:attribute name="type" select="@type"/>
                    </xsl:if>
                    <xsl:apply-templates mode="bind"/>
                </xf:bind>

            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>




    <!--
        ########################################################################################
            MODE: UI - CREATION OF XFORMS UI CONTROLS
        ########################################################################################
    -->
    <xsl:template match="xf:bind[@xfType = 'complexType']" mode="ui" priority="20">

        <xsl:param name="path" select="''" />
        <xsl:variable name="vraNodeName" select="@nodeset"/>
        <xsl:variable name="currentPath" select="concat($path,'/',$vraNodeName)"/>

        <xsl:choose>
            <xsl:when test="contains($exclude, $vraNodeName)">
                <xsl:if test="$debugEnabled">
                    <xsl:message>stop creating ui markup at this point due to subform loading: '<xsl:value-of select="$vraNodeName"/>' xpath is: '<xsl:value-of select="$currentPath"/>'</xsl:message>
                    <div id="{$vraNodeName}MountPoint" class="xfMountPoint"/>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <xsl:if test="$debugEnabled">
                    <xsl:message>create xf:group for '<xsl:value-of select="$vraNodeName"/>' xpath is: '<xsl:value-of select="$currentPath"/>'</xsl:message>
                </xsl:if>

                <xf:group ref="{$vraNodeName}" appearance="full" model="{$vraSubformTypeWithoutNamespace}-model">
                    <xf:label><xsl:value-of select="functx:capitalize-first($vraNodeName)"/></xf:label>
                    <xsl:apply-templates mode="ui">
                        <xsl:with-param name="path" select="$currentPath"/>
                    </xsl:apply-templates>
                </xf:group>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>



    <xsl:template match="xf:bind[not(exists(xf:bind/xf:bind)) and not(starts-with(@nodeset,'@'))]" mode="ui" priority="10">
        <xsl:param name="path" select="''" />
        <xsl:variable name="vraNodeName" select="@nodeset"/>
        <xsl:variable name="currentPath" select="concat($path,'/',$vraNodeName)"/>

        <xsl:if test="$debugEnabled">
            <xsl:message>create xf:control for '<xsl:value-of select="$vraNodeName"/>' xpath is: '<xsl:value-of select="$currentPath"/>'</xsl:message>
        </xsl:if>
        <xf:group ref="{$vraNodeName}" model="{$vraSubformTypeWithoutNamespace}-model" appearance="full">
            <xf:label><xsl:value-of select="functx:capitalize-first($vraNodeName)"/> Group</xf:label>
            <xf:input ref="." type="nodeValue" model="{$vraSubformTypeWithoutNamespace}-model">
                <xf:label>
                    <xsl:value-of select="functx:capitalize-first($vraNodeName)"/>
                </xf:label>
            </xf:input>
            <xf:group appearance="full">
                <xf:label><xsl:value-of select="functx:capitalize-first($vraNodeName)"/> Attributes:</xf:label>
                <xsl:apply-templates mode="ui">
                    <xsl:with-param name="path" select="$currentPath"/>
                </xsl:apply-templates>
            </xf:group>
        </xf:group>
    </xsl:template>

    <xsl:template match="xf:bind[starts-with(@nodeset,'@')]" mode="ui" priority="10">
        <xsl:param name="path" select="''" />
        <xsl:variable name="vraNodeName" select="@nodeset"/>
        <xsl:variable name="currentPath" select="concat($path,'/',$vraNodeName)"/>

        <xsl:if test="$debugEnabled">
            <xsl:message>create xf:control for '<xsl:value-of select="$vraNodeName"/>' attribute,  xpath is: '<xsl:value-of select="$currentPath"/>'</xsl:message>
        </xsl:if>
        <xsl:variable name="attrName" select="@nodeset"/>
<!--
        <xsl:variable name="attrName">
            <xsl:choose>
                <xsl:when test="starts-with(@nodeset,'@') and @nodeset ne '@xml:lang'">
                    <xsl:value-of select="functx:to-namespace-attribute(@nodeset)"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="@nodeset"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
-->

        <xf:input ref="{$attrName}" type="attributeValue" model="{$vraSubformTypeWithoutNamespace}-model">
            <xf:label><xsl:value-of select="functx:capitalize-first($vraNodeName)"/></xf:label>
        </xf:input>
        <xsl:apply-templates mode="ui">
            <xsl:with-param name="path" select="$currentPath"/>
        </xsl:apply-templates>
    </xsl:template>


    <xsl:template match="xf:bind" mode="ui">
        <xsl:message>Matched xf:bind with nodeset='<xsl:value-of select="@nodeset"/>'</xsl:message>
        <xsl:message terminate="yes">This rule must never be matched</xsl:message>
    </xsl:template>





    <!--
        ########################################################################################
            CALL TEMPLATE - CREATE INSTANCE
        ########################################################################################
    -->

    <xsl:template name="create-vra-instance">
        <!-- create XForms markup for image instance -->
        <xf:instance id="{$mainInstanceName}" src="{$mainInstancePath}"/>

        <!-- create external VRA Image Instance -->
        <xsl:result-document href="{$mainInstancePath}" encoding="UTF-8">
            <xsl:if test="$debugEnabled">
                <xsl:message>Writing Image instance to <xsl:value-of select="$mainInstancePath"/></xsl:message>
            </xsl:if>
            <xsl:element name="vra" namespace="http://www.vraweb.org/vracore4.htm">
                <xsl:copy-of select="$vraInstance/vra:vra/*[local-name()=$vraSubformTypeWithoutNamespace]"/>
            </xsl:element>
        </xsl:result-document>

    </xsl:template>


<!--
    ########################################################################################
        HELPER TEMPLATE RULES (simply copying nodes and comments)
    ########################################################################################
-->

    <xsl:template match="*">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="@*|text()">
        <xsl:copy/>
    </xsl:template>

    <xsl:template match="comment()" priority="20">
        <xsl:copy/>
    </xsl:template>


    <xsl:function name="functx:capitalize-first" as="xsd:string?">
        <xsl:param name="arg" as="xsd:string?"/>
        <xsl:sequence select="concat(upper-case(substring($arg,1,1)),substring($arg,2))"/>
    </xsl:function>

    <xsl:function name="functx:to-namespace-attribute" as="xsd:string?">
        <xsl:param name="arg" as="xsd:string?"/>
        <xsl:sequence select="concat(substring($arg,1,1), 'vra:' ,substring($arg,2))"/>
    </xsl:function>
</xsl:stylesheet>
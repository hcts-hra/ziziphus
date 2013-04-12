<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.vraweb.org/vracore4.htm"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xmlns:xf="http://www.w3.org/2002/xforms"
                xmlns:functx="http://www.functx.com"
                xpath-default-namespace="http://www.vraweb.org/vracore4.htm">
    <xsl:include href="functions.xsl"/>

    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>
    <xsl:strip-space elements="*"/>

    <!--
        ########################################################################################
            EXTERNAL PARAMETERS
        ########################################################################################
    -->
    <xsl:param name="debug" select="'TAKEN_FROM_BUILD.XML'" as="xsd:string"/>

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


<!--
    ########################################################################################
        TEMPLATE RULES
    ########################################################################################
-->

    <!-- handle xsd:sequence -->
    <xsl:template match="xsd:schema">
        <xsl:apply-templates select="xsd:element[@name='vra']">
                <xsl:with-param name="path" select="'/'"/>
        </xsl:apply-templates>
    </xsl:template>



    <xsl:template match="xsd:element[xsd:complexType/xsd:sequence]" priority="20">
        <xsl:variable name="nodesetName" select="concat('vra:',@name)"/>
        <xsl:variable name="maxOccurs" select="if(@maxOccurs) then @maxOccurs else 1"/>
        <xsl:variable name="minOccurs" select="if(@minOccurs) then @minOccurs else 1"/>
        <xsl:if test="$debugEnabled">
            <xsl:message>create bind for complex element with sequence '<xsl:value-of  select="@name"/>' with [type='<xsl:value-of  select="@type"/>', maxOccurs='<xsl:value-of select="$maxOccurs"/>',  minOccurs='<xsl:value-of  select="$minOccurs"/>']</xsl:message>
        </xsl:if>

        <xsl:element name="bind" namespace="http://www.w3.org/2002/xforms">
            <xsl:attribute name="id"><xsl:value-of select="concat('b-',generate-id())"/></xsl:attribute>
            <xsl:attribute name="nodeset" select="$nodesetName"/>
            <xsl:attribute name="maxOccurs" select="$maxOccurs"/>
            <xsl:attribute name="minOccurs" select="$minOccurs"/>
            <xsl:attribute name="seqMinOccurs" select="xsd:complexType/xsd:sequence/@minOccurs"/>
            <xsl:attribute name="seqMaxOccurs" select="xsd:complexType/xsd:sequence/@maxOccurs"/>
            <xsl:attribute name="xfType" select="'complexType'"/>

            <xsl:for-each select="xsd:complexType/xsd:attribute">
                <xsl:apply-templates select="."/>
            </xsl:for-each>
            <xsl:apply-templates select="xsd:complexType/xsd:sequence"/>
        </xsl:element>
    </xsl:template>


    <xsl:template match="xsd:element[xsd:complexType/xsd:simpleContent/xsd:extension]" priority="10">
        <xsl:variable name="nodesetName" select="concat('vra:',@name)"/>
        <xsl:variable name="maxOccurs" select="if(@maxOccurs) then @maxOccurs else 1"/>
        <xsl:variable name="minOccurs" select="if(@minOccurs) then @minOccurs else 1"/>

        <xsl:if test="$debugEnabled">
            <xsl:message>create bind for simple element '<xsl:value-of  select="@name"/>' with [type='<xsl:value-of  select="@type"/>', maxOccurs='<xsl:value-of  select="@maxOccurs"/>',  minOccurs='<xsl:value-of  select="@minOccurs"/>']</xsl:message>
        </xsl:if>

        <xsl:element name="bind" namespace="http://www.w3.org/2002/xforms">
            <xsl:attribute name="id"><xsl:value-of select="concat('b-',generate-id())"/></xsl:attribute>
            <xsl:attribute name="maxOccurs" select="$maxOccurs"/>
            <xsl:attribute name="minOccurs" select="$minOccurs"/>
            <xsl:attribute name="xfType" select="'simpleType'"/>

            <xsl:variable name="extension" select="xsd:complexType/xsd:simpleContent/xsd:extension"/>
            <!--<xsl:attribute name="type" select="$extension/@base"/>-->
            <xsl:for-each select="$extension/*">
                <xsl:choose>
                    <xsl:when test="local-name(.) eq 'attribute'">
                        <xsl:apply-templates select="."/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:message terminate="yes">extension with other child element than attribute</xsl:message>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>


    <xsl:template match="xsd:element">
        <xsl:variable name="nodesetName" select="concat('vra:',@name)"/>
        <xsl:variable name="maxOccurs" select="if(@maxOccurs) then @maxOccurs else 1"/>
        <xsl:variable name="minOccurs" select="if(@minOccurs) then @minOccurs else 1"/>

        <xsl:if test="$debugEnabled">
            <xsl:message>create binding for '<xsl:value-of  select="@name"/>' with [type='<xsl:value-of  select="@type"/>', maxOccurs='<xsl:value-of  select="@maxOccurs"/>',  minOccurs='<xsl:value-of  select="@minOccurs"/>']</xsl:message>
        </xsl:if>

        <xsl:element name="bind" namespace="http://www.w3.org/2002/xforms">
            <xsl:attribute name="id"><xsl:value-of select="concat('b-',generate-id())"/></xsl:attribute>
            <xsl:attribute name="nodeset" select="$nodesetName"/>
            <xsl:attribute name="type" select="@type"/>
            <xsl:attribute name="maxOccurs" select="$maxOccurs"/>
            <xsl:attribute name="minOccurs" select="$minOccurs"/>
            <xsl:attribute name="xfType" select="'mixedType'"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>


    <xsl:template match="xsd:attribute">

        <xsl:if test="$debugEnabled">
            <xsl:message>create attribute [name: '<xsl:value-of  select="@name"/>' , type: '<xsl:value-of  select="@type"/>', ref: '<xsl:value-of  select="@ref"/>']</xsl:message>
        </xsl:if>
        <xsl:choose>
            <!-- ### ignoring common vra attributes #### -->
            <xsl:when test="functx:isVraAttribute(@name)">
                <xsl:message>skipping '<xsl:value-of select="@name"/>' attribute</xsl:message>
            </xsl:when>
            <xsl:when test="@ref='xml:lang'">
                <xsl:message>skipping 'xml:lang' attribute</xsl:message>
            </xsl:when>
            <xsl:when test="exists(@name)">
                <xsl:element name="bind" namespace="http://www.w3.org/2002/xforms">
                    <xsl:attribute name="id"><xsl:value-of select="concat('b-',generate-id())"/></xsl:attribute>
                    <xsl:attribute name="nodeset" select="concat('@',@name)"/>
                    <xsl:attribute name="attrName" select="@name"/>
                    <xsl:choose>
                        <xsl:when test="starts-with(@type,'xsd')">
                            <xsl:attribute name="type" select="@type"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="type" select="concat('vra:',@type)"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:attribute name="xfType" select="'attribute'"/>
                </xsl:element>
            </xsl:when>
            <xsl:when test="@ref='xml:lang'">
                <xsl:element name="bind" namespace="http://www.w3.org/2002/xforms">
                    <xsl:attribute name="id"><xsl:value-of select="concat('b-',generate-id())"/></xsl:attribute>
                    <xsl:attribute name="nodeset" select="concat('@',@ref)"/>
                    <xsl:attribute name="attrName" select="@ref"/>
                    <xsl:attribute name="xfType" select="'attribute'"/>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:message terminate="yes">Error creating attribute</xsl:message>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- handle xsd:complexType-->
    <xsl:template match="xsd:complexType">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- handle xsd:sequence -->
    <xsl:template match="xsd:sequence">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="xsd:annotation"/>
    <xsl:template match="xsd:include"/>



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

</xsl:stylesheet>
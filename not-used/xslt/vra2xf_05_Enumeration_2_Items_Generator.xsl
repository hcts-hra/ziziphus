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

    <xsl:template match="xsd:schema">
        <xf:selects>
            <xsl:apply-templates/>
        </xf:selects>

    </xsl:template>
    <xsl:template match="xsd:simpleType">
        <xf:select name="{@name}">
            <xf:label/>
            <xsl:for-each select=".//xsd:enumeration">
                <xf:item>
                    <xf:label><xsl:value-of select="@value"/></xf:label>
                    <xf:value><xsl:value-of select="@value"/></xf:value>
                </xf:item>
            </xsl:for-each>
        </xf:select>
    </xsl:template>
    <xsl:template match="*">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="@*|text()|comment()"/>

</xsl:stylesheet>


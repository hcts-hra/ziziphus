<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xf="http://www.w3.org/2002/xforms"
                xmlns="http://www.vraweb.org/vracore4.htm"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xpath-default-namespace="http://www.vraweb.org/vracore4.htm">

    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>
    <xsl:strip-space elements="*"/>

    <!--
        ########################################################################################
            EXTERNAL PARAMETERS
        ########################################################################################
    -->
    <xsl:param name="debug" select="'TAKEN_FROM_BUILD.XML'" as="xsd:string"/>
    <xsl:param name="path2result" select="'TAKEN_FROM_BUILD.XML'" as="xsd:string"/>

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



    <xsl:template match="xf:bind[@nodeset='vra:vra']/xf:bind[@nodeset='vra:image']/xf:bind[not(starts-with(@nodeset,'@'))]">
        <xsl:variable name="subformName" select="substring-after(@nodeset,'vra:')"/>
        <xsl:variable name="path2result" select="concat($path2result,'/image-',$subformName,'.xml')"/>
        <xsl:message>Write result to <xsl:value-of select="$path2result"/> </xsl:message>
        <xsl:result-document href="{$path2result}" encoding="UTF-8">
            <bind xmlns="http://www.w3.org/2002/xforms" nodeset="vra:vra" maxOccurs="1" minOccurs="1" seqMinOccurs="1" seqMaxOccurs="unbounded" xfType="complexType">
                <bind nodeset="vra:image" maxOccurs="unbounded" minOccurs="0" xfType="image">
                    <xsl:copy-of select="."/>
                </bind>
            </bind>
        </xsl:result-document>
    </xsl:template>

    <xsl:template match="xf:bind[@nodeset='vra:vra']/xf:bind[@nodeset='vra:work']/xf:bind[not(starts-with(@nodeset,'@'))]">
        <xsl:variable name="subformName" select="substring-after(@nodeset,'vra:')"/>
        <xsl:variable name="path2result" select="concat($path2result,'/work-',$subformName,'.xml')"/>
        <xsl:message>Write result to <xsl:value-of select="$path2result"/> </xsl:message>
        <xsl:result-document href="{$path2result}" encoding="UTF-8">
            <bind xmlns="http://www.w3.org/2002/xforms" nodeset="vra:vra" maxOccurs="1" minOccurs="1" seqMinOccurs="1" seqMaxOccurs="unbounded" xfType="complexType">
                <bind nodeset="vra:work" maxOccurs="unbounded" minOccurs="0" xfType="image">
                    <xsl:copy-of select="."/>
                </bind>
            </bind>
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


</xsl:stylesheet>
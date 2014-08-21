<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:xf="http://www.w3.org/2002/xforms"
        xmlns:xsd="http://www.w3.org/2001/XMLSchema"

        >
    <xsl:strip-space elements="*" />
    <xsl:output method="xml" version="1.0"/>
    <!--
    ##############################################################################################
    Applies the UIDefinition to a vanilla binding list (02_XF_Binds.xml)
    ##############################################################################################
    -->

    <xsl:param name="vanillaBindings"/>
    <xsl:variable name="xfBinds" select="document($vanillaBindings)"/>
    <xsl:variable name="debug" select="'true'" as="xsd:string"/>
    <xsl:variable name="debugEnabled" as="xsd:boolean">
        <xsl:choose>
            <xsl:when test="$debug eq 'true' or $debug eq 'true()' or number($debug) gt 0">true</xsl:when>
            <xsl:otherwise>false</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>


    <xsl:template match="group | set | node">
        <xsl:param name="path"/>
        <xsl:variable name="idref" select="@idref"/>
        <xsl:variable name="originBind" select="$xfBinds//xf:bind[@id=$idref]"/>

        <xsl:if test="$debugEnabled">
            <xsl:message>element:<xsl:value-of select="name()"/> | nodeset:<xsl:value-of select="@name"/> :originBind:<xsl:value-of select="$originBind"/></xsl:message>
        </xsl:if>
    
        <xsl:element name="{name($originBind)}" namespace="http://www.w3.org/2002/xforms">
            <xsl:copy-of select="$originBind/@*"/>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="group[textNode]" priority="10">
        <xsl:variable name="idref" select="@idref"/>
        <xsl:variable name="originBind" select="$xfBinds//xf:bind[@id=$idref]"/>

        <xsl:if test="$debugEnabled">
            <xsl:message>group with textNode matched</xsl:message>
        </xsl:if>


        <xsl:element name="{name($originBind)}" namespace="http://www.w3.org/2002/xforms">
            <xsl:copy-of select="$originBind/@*"/>
            <xsl:for-each select="*">
                <xsl:if test="$debugEnabled">
                    <xsl:message>current:<xsl:value-of select="name(.)"/></xsl:message>
                </xsl:if>
                <xsl:apply-templates select="."/>
            </xsl:for-each>
        </xsl:element>

    </xsl:template>

    <xsl:template match="textNode">
        <xsl:variable name="idref" select="../@idref"/>
        <xsl:variable name="originBind" select="$xfBinds//xf:bind[@id=$idref]"/>

        <xsl:if test="$debugEnabled">
            <xsl:message>TextNode matched</xsl:message>
            <xsl:message>Parent idref:<xsl:value-of select="$idref"/></xsl:message>
            <xsl:message>OriginBind:<xsl:value-of select="$originBind/@nodeset"/></xsl:message>

        </xsl:if>


        <xsl:element name="{name($originBind)}" namespace="http://www.w3.org/2002/xforms">
            <xsl:copy-of select="$originBind/@*[not(name()='nodeset')]"/>
            <xsl:copy-of select="@*"/>
            <xsl:attribute name="nodeset" select="'.'"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>


</xsl:stylesheet>

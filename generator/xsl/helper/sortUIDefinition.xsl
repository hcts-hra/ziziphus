<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:bffn="http://www.betterform.de/Functions"
        xmlns:saxon="http://saxon.sf.net/"
        xmlns:xsd="http://www.w3.org/2001/XMLSchema"
        exclude-result-prefixes="saxon">
    <xsl:output method="xml" version="1.0"/>
    <xsl:param name="generatedUIDefinition" select="''"/>
    <xsl:param name="debug" select="'false'"/>
    <!--
    ##############################################################################################
    This stylesheet creates a new View Definition as a starting point for defining the order of elements
    in views and forms as well as they are appearing initially or not (detail class mechanism)
    ##############################################################################################
    -->
    <xsl:variable name="generatedUIDefinitionDocument" select="document($generatedUIDefinition)"/>

    <xsl:template match="/group">
        <xsl:text>
        </xsl:text>
        <xsl:comment>
                This a generated file meant for further hand-editing as a UI profile. Must be placed in 'profile'
                directory to take effect during generation of forms and views.
        </xsl:comment>
        <xsl:copy>
            <xsl:copy-of select="@*[name(.) != 'xpath']"/>
            <xsl:apply-templates select="*" mode="update"/>
        </xsl:copy>


        <!-- Update id and attributes in hand sorted UIDefinition -->
        <!--xsl:variable name="updated-ui-definition">
            <xsl:copy>
                <xsl:call-template name="update-attributes"/>
                <xsl:apply-templates select="." mode="update"/>
            </xsl:copy>
        </xsl:variable-->
        <!-- Complete UIDefintion with new elements -->
        <!-- xsl:apply-templates select="$updated-ui-definition" mode="complete"/-->
    </xsl:template>

    <xsl:template match="*" mode="update">
        <xsl:copy>
            <xsl:call-template name="update-attributes"/>
            <xsl:apply-templates mode="update"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template name="update-attributes">
        <xsl:variable name="xpath">
            <xsl:call-template name="generate-xpath"/>
        </xsl:variable>
        <xsl:attribute name="xpath" select="$xpath"/>
        <xsl:for-each select="@*[not(name(.)='idref')]">
            <xsl:copy/>
        </xsl:for-each>
        <xsl:copy-of select="$generatedUIDefinitionDocument//*[@xpath=$xpath]/@idref"/>
    </xsl:template>

    <!--
    <xsl:template match="*" mode="complete">
        <xsl:for-each select="*[@idref = $generatedUIDefinitionDocument//*/@idref]">
        </xsl:for-each>
        <xsl:variable name="test" select="@idref"/>
        <xsl:choose>
            <xsl:when test="$generatedUIDefinitionDocument//*/@idref[. eq $test]">
            <xsl:when test="*[@idref = $generatedUIDefinitionDocument//*/@idref]>
                <xsl:message>Match: <xsl:value-of select="@idref"/></xsl:message>
                <xsl:copy>
                    <xsl:copy-of select="@*"/>
                </xsl:copy>
            </xsl:when>
            <xsl:otherwise>
                <xsl:message>No Match: <xsl:value-of select="@idref"/></xsl:message>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:apply-templates mode="complete"/>
    </xsl:template>
    -->


    <xsl:function name="bffn:concat-xpath" as="xsd:string?">
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

    <xsl:template name="generate-xpath">
        <xsl:if test="exists(./@name)">
            <xsl:for-each select="ancestor-or-self::*">
                <xsl:value-of select="concat('/',  ./@name)"/>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>

    <!-- TODO merge generated UIDefinition with manual One -->
</xsl:stylesheet>

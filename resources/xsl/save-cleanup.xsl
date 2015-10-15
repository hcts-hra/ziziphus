<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:save="http://www.betterform.de/save"
                xmlns:functx="http://www.functx.com"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:vra="http://www.vraweb.org/vracore4.htm"
                version="2.0"
                exclude-result-prefixes="save">
    <xsl:output method="xml" indent="yes"
                exclude-result-prefixes="save"/>
    <xsl:strip-space elements="*"/>

    <!-- PARAMS -->
    <xsl:variable name="debug" select="'true'"/>

    <!-- ROOT MATCHER -->
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-- Standard copy template -->
    <xsl:template match="*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="text() | comment() | processing-instruction()">
        <xsl:copy/>
    </xsl:template>

    <!-- remove empty attributes -->
    <xsl:template match="@*">
        <xsl:if test="string-length(normalize-space(.)) ge 1">
            <xsl:copy/>
        </xsl:if>
    </xsl:template>

    <!-- latesDate -->
    <xsl:template match="vra:latestDate[string-length(normalize-space(.)) lt 1]">
        <vra:latestDate>
            <xsl:apply-templates select="@*"/>
            <xsl:copy-of select="preceding-sibling::vra:earliestDate/node()"/>
        </vra:latestDate>
    </xsl:template>
</xsl:stylesheet>
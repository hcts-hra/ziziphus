<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:save="http://www.betterform.de/save"
                xmlns:functx="http://www.functx.com"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                version="2.0"
                exclude-result-prefixes="save">

    <xsl:output exclude-result-prefixes="save" indent="yes"/>
    <xsl:output method="xml" indent="yes"/>


    <xsl:strip-space elements="*" />

    <!-- PARAMS -->
    <xsl:variable name="debug" select="'true'"/>
    <xsl:param name="targetNS" select="'http://www.vraweb.org/vracore4.htm'"/>

    <!-- ROOT MATCHER -->
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- attributes -->
    <xsl:template match="@*">
        <xsl:if test="string-length(normailze-space(.)) gt 1">
            <xsl:copy/>
        </xsl:if>
    </xsl:template>


    <!-- latesDate -->
    <xsl:template match="vra:latestDate">
        <xsl:choose>
            <xsl:when test="string-length(normailze-space(.)) lt 1">
                <xsl:element name="latestDate" namespace="{$targetNS}">
                    <xsl:apply-templates select="@*"/>
                    <xsl:value-of select="./preceding::vra:earliestDate/text()"/>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


    <xsl:template match="*">
        
    </xsl:template>

</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:save="http://www.betterform.de/save"
                xmlns:functx="http://www.functx.com"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:vra="http://www.vraweb.org/vracore4.htm"
                xmlns="http://www.vraweb.org/vracore4.htm"
                version="2.0"
                exclude-result-prefixes="#all">
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

    <!-- remove mepty earliestDate|latestDate, auto-fill latesDate -->
    <xsl:template match="vra:dateSet/vra:date/vra:earliestDate[not(vra:date/normalize-space(text()))]">
    	<!-- remove empty earliestDate -->
    </xsl:template>

    <xsl:template match="vra:dateSet/vra:date/vra:latestDate[not(vra:date/normalize-space(text()))]">
    	<xsl:variable name="earliestDate" select="preceding-sibling::vra:earliestDate[1]"/>
    	<!-- if there is non-empty earliestDate, copy its contents -->
    	<xsl:if test="$earliestDate/vra:date/normalize-space(text())">
        	<xsl:copy>
            	<xsl:apply-templates select="@*"/>
            	<!--  copy @circa from earliestDate, but only if not specified here -->
            	<xsl:if test="empty(@circa) and $earliestDate/@circa">
            		<xsl:apply-templates select="$earliestDate/@circa"/>
            	</xsl:if>
            	<xsl:apply-templates select="$earliestDate/node()">
            		<xsl:with-param name="insert-circa" select="vra:date/@circa"/>
            	</xsl:apply-templates>
        	</xsl:copy>
        </xsl:if>
        <!-- otherwise remove empty latestDate -->
    </xsl:template>
    
    <!-- A specialised template to copy @circa from earliestDate to empty latestDate, but only if not provided in latestDate -->
    <xsl:template match="vra:earliestDate/vra:date">
    	<xsl:param name="insert-circa"/>
        <xsl:copy>
        	<xsl:choose>
            <xsl:when test="$insert-circa">
            	<xsl:apply-templates select="$insert-circa"/>
            </xsl:when>
            <xsl:otherwise>
            	<xsl:apply-templates select="@circa"/>
            </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates select="@* except @circa"/>
            <xsl:apply-templates select="node()"/>
        </xsl:copy>    	
    </xsl:template>
</xsl:stylesheet>

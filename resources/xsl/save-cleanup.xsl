<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:save="http://www.betterform.de/save"
                xmlns:local="urn:local-functions"
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
        <xsl:if test="string-length(normalize-space(.)) gt 0">
            <xsl:copy/>
        </xsl:if>
    </xsl:template>

    <!-- Remove empty earliestDate|latestDate. If only one is non-empty, then auto-fill the other. -->
    
    <!-- Tells if the given date node (vra:earliestDate or vra:latestDate) should be treated as a provided (non-empty) one.
         I extracted this function because the schema of date information evolves and it is possible that the condition
         will have to be changed one day. -->
    <xsl:function name="local:nonEmptyDate" as="xs:boolean">
    	<xsl:param name="node" as="node()?"/>
    	<xsl:sequence select="string-length(normalize-space(string($node))) gt 0"/>
    </xsl:function>

	<!-- Recipe how and when to copy the other date. -->    
    <xsl:template name="local:copyOtherDate">
    	<xsl:param name="thisDate" as="node()"/>
    	<xsl:param name="thatDate" as="node()?"/>

    	<xsl:if test="local:nonEmptyDate($thatDate)">
        	<xsl:copy>
            	<xsl:apply-templates select="$thisDate/@*"/>
           		<xsl:apply-templates select="$thatDate/@*[not(local-name() = $thisDate/@*/local-name())]"/>
            	<xsl:apply-templates select="$thatDate/node()"/>
        	</xsl:copy>
    	</xsl:if>
        <!-- otherwise remove empty element -->
    </xsl:template>

	<!-- Apply it to empty earliestDate. -->
    <xsl:template match="vra:earliestDate[not(local:nonEmptyDate(.))]">
    	<xsl:call-template name="local:copyOtherDate">
    		<xsl:with-param name="thisDate" select="."/>
    		<xsl:with-param name="thatDate" select="following-sibling::vra:latestDate[1]"/>
    	</xsl:call-template>
    </xsl:template>

	<!-- And to empty latestDate. -->
    <xsl:template match="vra:latestDate[not(local:nonEmptyDate(.))]">
    	<xsl:call-template name="local:copyOtherDate">
    		<xsl:with-param name="thisDate" select="."/>
    		<xsl:with-param name="thatDate" select="preceding-sibling::vra:earliestDate[1]"/>
    	</xsl:call-template>
    </xsl:template>
</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : finetune-view.xsl
    Created on : 24. April 2014, 11:08
    Author     : zwobit
    Description:
        Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns:transform="http://betterform.de/transform"
                version="2.0">
    <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>
    <xsl:strip-space elements="*"/>
    <xsl:namespace-alias stylesheet-prefix="transform" result-prefix="xsl"/>
    
    <xsl:template match="*|text()|comment()">
        <xsl:copy>
            <xsl:copy-of select ="@*|text()|comment()"/>
            <xsl:apply-templates select="*"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="//xsl:when[contains(@test, 'string-length(string-join(@relids')]/html:div">
        <xsl:copy>
            <xsl:copy-of select ="@*"/>
            <img>
                <transform:attribute name="src" select="concat('/exist/apps/ziziphus/imageService/?imagerecord=', @relids)"/>
                <transform:attribute name="alt" select="@relids"/>
                <transform:attribute name="class" select="relationSetImage"/>
                <!-- TODO: load work via Image record -->
                <!-- transform:attribute name="onclick" select="concat('loadRecord(', @relids, ')')"/-->
            </img>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>

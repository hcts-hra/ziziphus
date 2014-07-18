<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : lang.xsl
    Created on : 12. Juni 2014, 16:00
    Author     : zwobit
    Description:
        Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>
    
    <xsl:template match="/">
        <language language="xxx">
            <display>
                <label>Display</label>
                <hint/>
                <help/>
                <alert/>
            </display>
            <notes>
                <label>Notes</label>
                <hint/>
                <help/>
                <alert/>
            </notes>
            <dataDate>
                <label>Data Date</label>
                <hint/>
                <help/>
                <alert/>
            </dataDate>
            <extent>
                <label>Extent</label>
                <hint/>
                <help/>
                <alert/>
            </extent>
            <href>
                <label>Href</label>
                <hint/>
                <help/>
                <alert/>
            </href>
            <refid>
                <label>RefID</label>
                <hint/>
                <help/>
                <alert/>
            </refid>
            <rules>
                <label>Rules</label>
                <hint/>
                <help/>
                <alert/>
            </rules>
            <source>
                <label>Source</label>
                <hint/>
                <help/>
                <alert/>
            </source>
            <vocab>
                <label>Vocab</label>
                <hint/>
                <help/>
                <alert/>
            </vocab>
            <lang>
                <label>Lang</label>
                <hint/>
                <help/>
                <alert/>
            </lang>
            <script>
                <label>Script</label>
                <hint/>
                <help/>
                <alert/>
            </script>
            <transliteration>
                <label>Transliteration</label>
                <hint/>
                <help/>
                <alert/>
            </transliteration>
            <type>
                <label>Type</label>
                <hint/>
                <help/>
                <alert/>
            </type>
            <xsl:apply-templates select="*"/>
        </language>
    </xsl:template>
    
    <xsl:template match="*|@*">
        <xsl:variable name="elementName" select="local-name(.)"/>
        <xsl:element name="{$elementName}">
            <xsl:if test="not(exists(*))">
                <label><xsl:value-of select="concat(upper-case(substring(local-name(),1,1)),
          substring(local-name(), 2))"/></label>
                <hint></hint>
                <help/>
                <alert></alert>
            </xsl:if>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="notes|display" priority="10">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="@dataDate|@extent|@href|@refid|@rules|@source|@vocab|@lang|@script|@transliteration|@type" priority="10">
        <xsl:apply-templates/>
    </xsl:template>
</xsl:stylesheet>

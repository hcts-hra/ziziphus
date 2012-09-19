<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:vra="http://www.vraweb.org/vracore4.htm" version="2.0" exclude-result-prefixes="vra">
    <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>
    <xsl:template match="vra:sourceSet" priority="40">
        <xsl:for-each select="vra:source">
            <xsl:if test="position() &gt; 1">
                <xsl:text>; </xsl:text>
            </xsl:if>

            <xsl:value-of select="vra:name"/>
            <xsl:if test="vra:name/@type">
                <xsl:text> (</xsl:text>
                <xsl:value-of select="vra:name/@type"/>
                <xsl:text>)</xsl:text>
            </xsl:if>

            <xsl:if test="vra:refid">
                <xsl:text>, </xsl:text>
                <xsl:if test="vra:refid/@type">
                    <xsl:value-of select="vra:refid/@type"/>
                    <xsl:text>: </xsl:text>
                </xsl:if>
                <xsl:value-of select="vra:refid"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>

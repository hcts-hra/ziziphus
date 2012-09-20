<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:vra="http://www.vraweb.org/vracore4.htm" version="2.0" exclude-result-prefixes="vra">
    <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>

    <xsl:template name="handleTextRef">
        <xsl:for-each select="./*">
            <xsl:if test="1 &lt; position()">
                <xsl:text>; </xsl:text>
            </xsl:if>

            <xsl:value-of select="."/>

            <xsl:if test="@type">
                <span class="detail-inline"><xsl:text> (</xsl:text><xsl:value-of select="@type"/><xsl:text>)</xsl:text></span>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="vra:textrefSet" priority="40">
        <xsl:choose>
            <xsl:when test="1 &lt; count(vra:textref)">
                <ol>
                    <xsl:for-each select="vra:textref">
                        <li><xsl:call-template name="handleTextRef"/></li>
                    </xsl:for-each>
                </ol>
            </xsl:when>
            <xsl:otherwise>
                <xsl:for-each select="vra:textref">
                    <xsl:call-template name="handleTextRef"/>
                </xsl:for-each>                
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>

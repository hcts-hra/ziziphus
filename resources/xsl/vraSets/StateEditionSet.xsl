<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:vra="http://www.vraweb.org/vracore4.htm" xmlns:bfn="http://www.betterform.de/XSL/Functions" version="2.0" exclude-result-prefixes="vra">
    <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>

    <xsl:template name="handleStateEdition">
        <xsl:value-of select="bfn:upperCase(@type)"/>
        <xsl:text> </xsl:text>

        <xsl:call-template name="renderVraAttr">
            <xsl:with-param name="attrName">num</xsl:with-param>
            <xsl:with-param name="mode">simple</xsl:with-param>
            <xsl:with-param name="ifAbsent">-</xsl:with-param>
        </xsl:call-template>

        <!-- <xsl:value-of select="@num or '&mdash;'"/> -->
        <xsl:text> of </xsl:text>
        <xsl:call-template name="renderVraAttr">
            <xsl:with-param name="attrName">count</xsl:with-param>
            <xsl:with-param name="mode">simple</xsl:with-param>
            <xsl:with-param name="ifAbsent">-</xsl:with-param>
        </xsl:call-template>

        <xsl:if test="@source">
            <xsl:text> (</xsl:text>
            <xsl:value-of select="@source"/>
            <xsl:text>)</xsl:text>
        </xsl:if>

        <xsl:if test="vra:name">
            <xsl:text>: </xsl:text>
            <xsl:value-of select="vra:name"/>
        </xsl:if>

        <xsl:if test="vra:description">
            <span class="detail-inline">
            <xsl:text>; </xsl:text>
            <xsl:value-of select="vra:description"/>
            </span>
        </xsl:if>
    </xsl:template>

    <xsl:template match="vra:stateEditionSet" priority="40">
        <xsl:choose>
            <xsl:when test="1 &lt; count(vra:stateEdition)">
                <ol>
                    <xsl:for-each select="vra:stateEdition">
                        <li><xsl:call-template name="handleStateEdition"/></li>
                    </xsl:for-each>
                </ol>
            </xsl:when>
            <xsl:otherwise>
                <xsl:for-each select="vra:stateEdition">
                    <xsl:call-template name="handleStateEdition"/>
                </xsl:for-each>                
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>

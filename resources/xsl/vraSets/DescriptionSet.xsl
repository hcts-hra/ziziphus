<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:vra="http://www.vraweb.org/vracore4.htm" version="2.0" exclude-result-prefixes="vra">
    <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>
    <xsl:template match="vra:descriptionSet" priority="40">
            <xsl:for-each select="vra:description">
                <div>
                    <!-- in case of multiple description records we wrap each in a styled border -->
                    <xsl:choose>
                        <xsl:when test="2 &lt;= count(../child::vra:description)">
                            <xsl:attribute name="class">description simple</xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="class">simple</xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>

                    <xsl:variable name="descr" select="."/>
                    <xsl:choose>
                        <xsl:when test="string-length($descr) &lt;= 60">
                            <xsl:value-of select="$descr"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <span class="simple-inline"><xsl:value-of select="substring($descr,1,50)"/></span>
                            <span class="detail-inline"><xsl:value-of select="substring($descr,51)"/></span>
                        </xsl:otherwise>
                    </xsl:choose>
                </div>
            </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>

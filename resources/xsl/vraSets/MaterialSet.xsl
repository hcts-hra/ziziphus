<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:vra="http://www.vraweb.org/vracore4.htm" version="2.0" exclude-result-prefixes="vra">
    <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>
    <xsl:template match="vra:materialSet" priority="40">
                <xsl:variable name="c_med" select="count(vra:material[@type='medium'])"/>
                <xsl:variable name="c_sup" select="count(vra:material[@type='support'])"/>
                <xsl:variable name="c_oth" select="count(vra:material[@type='other'])"/>

                <xsl:value-of select="vra:material[@type='medium']"/>

                <!-- type=support -->
                <xsl:if test="(0 &lt; $c_med) and (0 &lt; $c_sup)">
                    <xsl:text> (</xsl:text>
                </xsl:if>
                <xsl:value-of select="vra:material[@type='support']"/>
                <xsl:if test="(0 &lt; $c_med) and (0 &lt; $c_sup)">
                    <xsl:text>)</xsl:text>
                </xsl:if>

                <!-- type=other -->
                <xsl:if test="(0 &lt; ($c_med + $c_sup)) and (0 &lt; $c_oth)">
                    <xsl:text>; </xsl:text>
                    <xsl:value-of select="vra:material[@type='other']"/>
                </xsl:if>

        <xsl:call-template name="renderVraNotes"/>
    </xsl:template>
</xsl:stylesheet>

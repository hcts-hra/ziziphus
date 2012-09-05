<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:vra="http://www.vraweb.org/vracore4.htm" version="2.0" exclude-result-prefixes="vra">
    <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>
    <xsl:template match="vra:relationSet" priority="40">
        <div xmlns="http://www.w3.org/1999/xhtml" class="vraSection">
            <xsl:for-each select="vra:relation">
                <div>
                    <span class="vraAttribute">
                        <xsl:value-of select="@type"/>
                    </span>
                    <span class="vraNode">
                        <xsl:value-of select="."/>
                    </span>
                    <span class="vraAttribute">
                        <xsl:value-of select="@relids"/>
                    </span>
                </div>
            </xsl:for-each>
            <span class="vraNode">
                <xsl:value-of select="vra:notes"/>
            </span>
        </div>
    </xsl:template>
</xsl:stylesheet>
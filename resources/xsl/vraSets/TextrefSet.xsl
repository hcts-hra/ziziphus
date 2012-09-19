<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:vra="http://www.vraweb.org/vracore4.htm" version="2.0" exclude-result-prefixes="vra">
    <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>
    <xsl:template match="vra:textrefSet" priority="40">
            <xsl:for-each select="vra:textref">
                <div>
                    <span class="vraAttribute">
                        <xsl:value-of select="vra:name/@type"/>
                    </span>
                    <span class="vraNode">
                        <xsl:value-of select="vra:name"/>
                    </span>
                    <span class="vraAttribute">
                        <xsl:value-of select="vra:refid/@type"/>
                    </span>
                    <span class="vraNode">
                        <xsl:value-of select="vra:refid"/>
                    </span>
                </div>
            </xsl:for-each>

        <xsl:call-template name="renderVraNotes"/>
    </xsl:template>
</xsl:stylesheet>

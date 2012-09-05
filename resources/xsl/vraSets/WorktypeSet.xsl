<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:vra="http://www.vraweb.org/vracore4.htm" version="2.0" exclude-result-prefixes="vra">
    <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>
    <xsl:template match="vra:worktypeSet" priority="40">
        <div xmlns="http://www.w3.org/1999/xhtml" class="vraSection">
            <span class="vraNode">
                <xsl:value-of select="vra:notes"/>
            </span>
            <xsl:for-each select="vra:worktype">
                <div>
                    <span class="vraNode">
                        <xsl:value-of select="."/>
                    </span>
                    <span class="vraAttribute">
                        <xsl:value-of select="@pref"/>
                    </span>
                    <span class="vraAttribute">
                        <xsl:value-of select="@vocab"/>
                    </span>
                </div>
            </xsl:for-each>
        </div>
    </xsl:template>
</xsl:stylesheet>
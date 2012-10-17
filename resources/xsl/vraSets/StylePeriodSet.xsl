<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:vra="http://www.vraweb.org/vracore4.htm" version="2.0" exclude-result-prefixes="vra">
    <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>
    <xsl:template match="vra:stylePeriodSet" priority="40">
        <table class="table table-condensed">
            <thead>
                <tr>
                    <th></th>
                    <th class="detail-cell">vocab</th>
                    <th class="detail-cell">refid</th>
                </tr>
            </thead>
            <tbody>
                <xsl:for-each select="vra:stylePeriod">
                    <tr>
                        <td><xsl:value-of select="."/></td>
                        <td class="detail-cell"><xsl:value-of select="@vocab"/></td>
                        <td class="detail-cell"><xsl:value-of select="@refid"/></td>
                    </tr>
                </xsl:for-each>
            </tbody>
        </table>
    </xsl:template>
</xsl:stylesheet>

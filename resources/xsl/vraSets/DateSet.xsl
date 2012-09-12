<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:vra="http://www.vraweb.org/vracore4.htm" version="2.0" exclude-result-prefixes="vra">
    <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>
    <xsl:template match="vra:dateSet" priority="40">
        <xsl:param name="tableId"/>
        <div xmlns="http://www.w3.org/1999/xhtml" class="vraSection">
            <table id="{$tableId}" class="table table-condensed simpleView">
                <thead>
                    <tr>
                        <th>Event</th>
                        <th>Earliest date</th>
                        <th>Latest date</th>
                    </tr>
                </thead>
                <tbody>
                    <xsl:for-each select="vra:date">
                        <tr>
                            <td><xsl:value-of select="@type"/></td>
                            <td><span class="detail"><xsl:value-of select="vra:earliestDate/@type"/></span> <xsl:value-of select="vra:earliestDate"/></td>
                            <td><span class="detail"><xsl:value-of select="vra:latestDate/@type"/></span> <xsl:value-of select="vra:latestDate"/></td>
                        </tr>
                    </xsl:for-each>
                </tbody>
            </table>
            <!-- <span class="vraNode">
                <xsl:value-of select="vra:notes"/>
            </span> -->
        </div>
    </xsl:template>
</xsl:stylesheet>
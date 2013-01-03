<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ev="http://www.w3.org/2001/xml-events" xmlns:vra="http://www.vraweb.org/vracore4.htm" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xf="http://www.w3.org/2002/xforms" xmlns:bfn="http://www.betterform.de/XSL/Functions" version="2.0" xpath-default-namespace="http://www.w3.org/2002/xforms" exclude-result-prefixes="bfn">
    <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>

    <xsl:template match="vra:dates" priority="40">
        <xsl:if test="(vra:earliestDate) or (vra:latestDate)">
            <xsl:value-of select="vra:earliestDate"/>
            <xsl:text>-</xsl:text>
            <xsl:value-of select="vra:latestDate"/>
        </xsl:if>
    </xsl:template>

    <xsl:template match="vra:agentSet" priority="40">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Role</th>
                        <th>Culture</th>
                        <th class="detail-cell">Period (life)</th>
                        <th>Period (activity)</th>
                        <th class="detail-cell">Period (other)</th>
                    </tr>
                </thead>
                <tbody>
                    <xsl:for-each select="vra:agent">
                        <tr>
                            <td>
                                <!-- todo: all to all sets -->
                                <xsl:if test="vra:name/@pref='true'">
                                    <xsl:attribute name="class">pref</xsl:attribute>
                                </xsl:if>
                                <xsl:value-of select="bfn:upperCase(vra:name)"/>
                            </td>
                            <td>
                                <xsl:value-of select="bfn:upperCase(vra:role)"/>
                            </td>
                            <td>
                                <xsl:value-of select="vra:culture"/>
                            </td>
                            <td class="detail-cell">
                                <xsl:apply-templates select="vra:dates[@type='life']"/>
                            </td>
                            <td>
                                <xsl:apply-templates select="vra:dates[@type='activity']"/>
                            </td>
                            <td class="detail-cell">
                                <xsl:apply-templates select="vra:dates[@type='other']"/>
                            </td>
                        </tr>
                    </xsl:for-each>
                </tbody>
            </table>
    </xsl:template>
</xsl:stylesheet>

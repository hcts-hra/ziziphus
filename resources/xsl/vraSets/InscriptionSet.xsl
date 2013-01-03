<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:vra="http://www.vraweb.org/vracore4.htm" version="2.0" exclude-result-prefixes="vra">
    <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>
    <xsl:template match="vra:inscriptionSet" priority="40">
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Author</th>
                    <th>Position</th>
                    <th class="detail-cell">signature</th>
                    <th class="detail-cell">mark</th>
                    <th class="detail-cell">caption</th>
                    <th class="detail-cell">date</th>
                    <th class="detail-cell">text</th>
                    <th class="detail-cell">translation</th>
                    <th class="detail-cell">other</th>
                </tr>
            </thead>
            <tbody>
                <xsl:for-each select="vra:inscription">
                    <tr>
                        <td>
                            <xsl:value-of select="vra:author"/>
                        </td>
                        <td>
                            <xsl:value-of select="vra:position"/>
                        </td>
                        <td class="detail-cell">
                            <xsl:value-of select="vra:text[@type='signature']"/>
                        </td>
                        <td class="detail-cell">
                            <xsl:value-of select="vra:text[@type='mark']"/>
                        </td>
                        <td class="detail-cell">
                            <xsl:value-of select="vra:text[@type='caption']"/>
                        </td>
                        <td class="detail-cell">
                            <xsl:value-of select="vra:text[@type='date']"/>
                        </td>
                        <td class="detail-cell">
                            <xsl:value-of select="vra:text[@type='text']"/>
                        </td>
                        <td class="detail-cell">
                            <xsl:value-of select="vra:text[@type='translation']"/>
                        </td>
                        <td class="detail-cell">
                            <xsl:value-of select="vra:text[@type='other']"/>
                        </td>
                    </tr>
                </xsl:for-each>
            </tbody>
        </table>
    </xsl:template>
</xsl:stylesheet>

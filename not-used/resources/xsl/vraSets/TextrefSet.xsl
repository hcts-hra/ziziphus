<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:vra="http://www.vraweb.org/vracore4.htm" version="2.0" exclude-result-prefixes="vra">
    <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>
    <xsl:template match="vra:textrefSet" priority="40">
        <xsl:param name="vraTableId"/>
        <xsl:variable name="setTableId" select="if($vraTableId) then ($vraTableId) else ($setname)"/>
        <div class="simple" id="{$setTableId}">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th class="detail-cell">(type)</th>
                        <th class="detail-cell">refid</th>
                        <th class="detail-cell">(type)</th>
                        <th class="detail-cell">href</th>
                        <th class="detail-cell">dataDate</th>
                    </tr>
                </thead>
                <tbody>
                    <xsl:for-each select="vra:textref">
                        <tr>
                            <td>
                                <xsl:value-of select="vra:name"/>
                            </td>
                            <td class="detail-cell">
                                <xsl:value-of select="vra:name/@type"/>
                            </td>
                            <td class="detail-cell">
                                <xsl:value-of select="vra:refid"/>
                            </td>
                            <td class="detail-cell">
                                <xsl:value-of select="vra:refid/@type"/>
                            </td>
                            <td class="detail-cell">
                                <a>
                                    <xsl:attribute name="href">
                                        <xsl:value-of select="vra:refid/@href"/>
                                    </xsl:attribute>
                                    <xsl:value-of select="vra:refid/@href"/>
                                </a>
                            </td>
                            <td class="detail-cell">
                                <xsl:value-of select="vra:refid/@dataDate"/>
                            </td>
                        </tr>
                    </xsl:for-each>
                </tbody>
            </table>
        </div>
    </xsl:template>
</xsl:stylesheet>
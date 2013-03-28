<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:vra="http://www.vraweb.org/vracore4.htm" version="2.0" exclude-result-prefixes="vra">
    <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>
    <xsl:template match="vra:relationSet" priority="40">
        <xsl:param name="vraTableId"/>
        <xsl:variable name="setTableId" select="if($vraTableId) then ($vraTableId) else ($setname)"/>
        <div class="simple" id="{$setTableId}">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>What</th>
                        <th>Image</th>
                        <th>Type</th>
                        <th class="detail-cell">source</th>
                        <th class="detail-cell">refid</th>
                        <th class="detail-cell">relids</th>
                        <th class="detail-cell">URL</th>
                    </tr>
                </thead>
                <tbody>
                    <xsl:for-each select="vra:relation">
                        <tr>
                            <td>
                                <xsl:value-of select="text()"/>
                            </td>
                            <td>
                                <!-- TODO -->
                                <img src="resources/images/360/t_metadata.f_preview.43435-36085-100.jpg" alt="preview"/>
                            </td>
                            <td>
                                <xsl:value-of select="@type"/>
                            </td>
                            <td class="detail-cell">
                                <xsl:value-of select="@source"/>
                            </td>
                            <td class="detail-cell">
                                <xsl:value-of select="@refid"/>
                            </td>
                            <td class="detail-cell">
                                <xsl:value-of select="@relids"/>
                            </td>
                            <td class="detail-cell">
                                <xsl:if test="@href">
                                    <a>
                                        <xsl:attribute name="href">
                                            <xsl:value-of select="@href"/>
                                        </xsl:attribute>
                                        <xsl:value-of select="@href"/>
                                    </a>
                                </xsl:if>
                            </td>
                        </tr>
                    </xsl:for-each>
                </tbody>
            </table>
        </div>
    </xsl:template>
</xsl:stylesheet>
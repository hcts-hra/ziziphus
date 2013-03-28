<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ev="http://www.w3.org/2001/xml-events" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:vra="http://www.vraweb.org/vracore4.htm" xmlns:xf="http://www.w3.org/2002/xforms" xmlns:bfn="http://www.betterform.de/XSL/Functions" version="2.0" xpath-default-namespace="http://www.w3.org/2002/xforms" exclude-result-prefixes="bfn">
    <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>
    <xsl:template match="vra:dates" priority="40">
        <xsl:if test="(vra:earliestDate) or (vra:latestDate)">
            <xsl:value-of select="vra:earliestDate"/>
            <xsl:text>-</xsl:text>
            <xsl:value-of select="vra:latestDate"/>
        </xsl:if>
    </xsl:template>
    <xsl:template match="vra:agentSet" priority="40">
        <xsl:param name="vraTableId"/>
        <xsl:variable name="setTableId" select="if($vraTableId) then ($vraTableId) else ($setname)"/>
        <div class="simple" id="{$setTableId}">
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
                <tbody resource="vra:agentSet">
                    <xsl:for-each select="vra:agent">
                        <tr property="vra:agent">
                            <xsl:variable name="ref">
                                <xsl:call-template name="getRef"/>
                            </xsl:variable>
                            <td property="vra:name" data-xf-ref="{$ref}" contenteditable="true">
                                    <!-- todo: all to all sets -->
                                <xsl:if test="vra:name/@pref='true'">
                                    <xsl:attribute name="class">pref</xsl:attribute>
                                </xsl:if>
                                <xsl:value-of select="bfn:upperCase(vra:name)"/>
                            </td>
                            <td property="vra:role" contenteditable="true">
                                <xsl:value-of select="bfn:upperCase(vra:role)"/>
                            </td>
                            <td property="vra:culture" contenteditable="true">
                                <xsl:value-of select="vra:culture"/>
                            </td>
                            <td class="detail-cell" property="vra:dates[@type='life']" contenteditable="true">
                                <xsl:apply-templates select="vra:dates[@type='life']"/>
                            </td>
                            <td property="vra:dates[@type='activity']" contenteditable="true">
                                <xsl:apply-templates select="vra:dates[@type='activity']"/>
                            </td>
                            <td class="detail-cell" property="vra:dates[@type='other']" contenteditable="true">
                                <xsl:apply-templates select="vra:dates[@type='other']"/>
                            </td>
                        </tr>
                    </xsl:for-each>
                </tbody>
            </table>
        </div>
    </xsl:template>
    <xsl:template name="getRef">
        <xsl:for-each select="ancestor-or-self::node()[@property]">
            <xsl:value-of select="@property"/>/
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
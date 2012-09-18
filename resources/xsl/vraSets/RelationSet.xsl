<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:vra="http://www.vraweb.org/vracore4.htm" version="2.0" exclude-result-prefixes="vra">
    <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>
    <xsl:template match="vra:relationSet" priority="40">
        <xsl:param name="tableId"/>

        <div xmlns="http://www.w3.org/1999/xhtml" class="vraSection">
            <div id="{$tableId}" class="simpleView">
                <xsl:for-each-group select="vra:relation" group-by="concat('#', @type)">
                    <xsl:sort select="current-grouping-key()"/>
                    <xsl:variable name="relType" select="substring(current-grouping-key(),2)"/>

                    <div class="relationRecord">
                        <span class="relationRecordTitle">
                        <xsl:choose>
                            <xsl:when test="('imageIs' = $relType) or ('imageOf' = $relType)">
                                <xsl:text>Related image records (views of this work)</xsl:text>
                            </xsl:when>
                            <xsl:when test="('partOf' = $relType) or ('largerContextFor' = $relType)">
                                <xsl:text>Works that contain this one</xsl:text>
                            </xsl:when>
                            <xsl:when test="('relatedTo' = $relType)">
                                <xsl:text>Related work records (other works)</xsl:text>
                            </xsl:when>

                            <!-- TODO ... ?? -->
                        </xsl:choose>
                        </span>

                        <span class="relationRecordType"><xsl:text>Relation type: </xsl:text>
                        <xsl:value-of select="$relType"/></span>

                        <xsl:for-each select="current-group()">
                            <div class="relationRecordItem">
                                <div class="relationRecordItem-img">
                                    <!-- TODO -->
                                    <img src="resources/images/360/t_metadata.f_preview.43435-36085-100.jpg" alt="preview"/>
                                </div>

                                <div class="relationRecordItem-desc">
                                    <div class="detail">
                                        <span><xsl:value-of select="."/></span>
                                        <xsl:call-template name="renderVraAttr">
                                            <xsl:with-param name="attrName">source</xsl:with-param>
                                        </xsl:call-template>
                                        <xsl:call-template name="renderVraAttr">
                                            <xsl:with-param name="attrName">refid</xsl:with-param>
                                        </xsl:call-template>
                                        <xsl:call-template name="renderVraAttr">
                                            <xsl:with-param name="attrName">relids</xsl:with-param>
                                        </xsl:call-template>
                                    </div>
                                </div>
                            </div>
                        </xsl:for-each>
                    </div>
                </xsl:for-each-group>
            </div>
        </div>

<!--
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
-->

    </xsl:template>
</xsl:stylesheet>
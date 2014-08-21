<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:vra="http://www.vraweb.org/vracore4.htm" version="2.0" exclude-result-prefixes="vra">
    <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>
    <xsl:template match="vra:locationSet/vra:location" priority="40">
        <!--
        Restricted schema data values for location name type attribute: corporate, geographic, other, personal
        Restricted schema data values for location refid type attribute: accession, barcode, shelfList, other
        -->
        <li>
            <xsl:for-each select="./child::*">
                <xsl:if test="position() &gt; 1">
                    <xsl:if test="'name' = local-name()">
                        <xsl:text>,</xsl:text>
                    </xsl:if>
                    <xsl:text> </xsl:text>
                </xsl:if>
                <xsl:if test="'refid' = local-name()">
                    <xsl:text>(</xsl:text>
                </xsl:if>
                <xsl:value-of select="."/>
                <xsl:if test="@type">
                    <span xmlns="http://www.w3.org/1999/xhtml" class="detail-inline"> (<xsl:value-of select="@type"/>)</span>
                </xsl:if>
                <xsl:if test="'refid' = local-name()">
                    <xsl:text>)</xsl:text>
                </xsl:if>
            </xsl:for-each>
        </li>

        <!-- <xsl:if test="position() < last()">
            <xsl:text>; </xsl:text>
        </xsl:if> -->
    </xsl:template>
    <xsl:template match="vra:locationSet" priority="40">
                <!-- Restricted schema data values for location type attribute: creation, discovery, exhibition, formerOwner,
                formerRepository, formerSite, installation, intended (for unrealized projects), other, owner, performance,
                publication, repository, site (use for current locations for architecture and archaeology) -->

                <!-- TODO: make this more concise (like MeasurementsSet.xsl) -->
        <div class="locationSet">
            <xsl:if test="vra:location[(@type='exhibition') or (@type='installation') or (@type='intended') or (@type='owner') or (@type='performance') or (@type='publication') or (@type='repository') or (@type='site')]">
                <span class="location-subTitle">Current</span>
                <ol>
                    <xsl:apply-templates select="vra:location[(@type='exhibition') or (@type='installation') or (@type='intended') or (@type='owner') or (@type='performance') or (@type='publication') or (@type='repository') or (@type='site')]"/>
                </ol>
            </xsl:if>
            <xsl:if test="vra:location[(@type='formerOwner') or (@type='formerRepository') or (@type='formerSite') or (@type='') or (@type='')]">
                <span class="location-subTitle">Formerly</span>
                <ol>
                    <xsl:apply-templates select="vra:location[(@type='formerOwner') or (@type='formerRepository') or (@type='formerSite') or (@type='') or (@type='')]"/>
                </ol>
            </xsl:if>
            <xsl:if test="vra:location[(@type='creation') or (@type='discovery')]">
                <span class="location-subTitle">Origin</span>
                <ol>
                    <xsl:apply-templates select="vra:location[(@type='creation') or (@type='discovery')]"/>
                </ol>
            </xsl:if>
            <xsl:if test="vra:location[(@type='other')]">
                <span class="location-subTitle">Other</span>
                <ol>
                    <xsl:apply-templates select="vra:location[(@type='other')]"/>
                </ol>
            </xsl:if>
        </div>
    </xsl:template>
</xsl:stylesheet>
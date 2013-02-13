<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:vra="http://www.vraweb.org/vracore4.htm" xmlns:html="http://www.w3.org/1999/xhtml" xmlns:hra="http://cluster-schemas.uni-hd.de" version="2.0" exclude-result-prefixes="xsl vra hra html">
    <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="yes"/>
    <xsl:strip-space elements="*"/>
    <xsl:template match="/vra:vra">
        <div class="heidiconData">
            <h1>Heidicon Data</h1>
            <xsl:for-each select="vra:work/hra:heidicon">
                <xsl:apply-templates select="."/>
            </xsl:for-each>
        </div>
    </xsl:template>
    <xsl:template match="hra:heidicon">
<!--
        <xsl:variable name="display" select="if(exists(hra:item/@display)) then hra:item[1]/@display else concat('display is missing for type:', hra:item/@type)"/>
        <h2>
            <xsl:value-of select="$display"/>
        </h2>
-->
        <xsl:choose>
            <xsl:when test="exists(hra:item/@display)">
                <h2>
                    <xsl:value-of select="hra:item/@display"/>
                </h2>
            </xsl:when>
            <xsl:otherwise>
                <h2 class="missingDisplay">
                    <xsl:value-of select="hra:item/@type"/>
                </h2>
            </xsl:otherwise>
        </xsl:choose>
        <table class="table table-striped">
            <thead>
                <tr>
                    <td>Type</td>
                    <td>Status</td>
                    <td>Value(s)</td>
                </tr>
            </thead>
            <xsl:for-each select="hra:item">
                <tr>
                    <td>
                        <xsl:value-of select="@type"/>
                    </td>
                    <td>
                        <xsl:value-of select="@status"/>
                    </td>
                    <td>
                        <!--<xsl:variable name="values" select="hra:value"/>-->
                        <table class="hvalues">
                            <xsl:for-each select="hra:value">
                                <tr>
                                    <td>
                                        <xsl:value-of select="."/>
                                    </td>
                                </tr>
                            </xsl:for-each>
                        </table>
                    </td>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:template>

    <!--
        <xsl:template match="hra:item[exists(@display)]">
            <h2><xsl:value-of select="@display"/></h2>
        </xsl:template>

        <xsl:template match="hra:item[not(exists(@display))]">
            <h2>missing display attribute for type: <xsl:value-of select="@type"/></h2>
        </xsl:template>
    -->
</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:vra="http://www.vraweb.org/vracore4.htm" xmlns:html="http://www.w3.org/1999/xhtml" xmlns:ext="http://exist-db.org/vra/extension" version="2.0" exclude-result-prefixes="xsl vra ext html">
    <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="yes"/>
    <xsl:strip-space elements="*"/>
    <xsl:template match="/vra:vra">
        <div class="heidiconData">
            <h1>Heidicon Data</h1>
            <xsl:for-each select="vra:work/ext:heidicon">
                <xsl:apply-templates select="."/>
            </xsl:for-each>
        </div>
    </xsl:template>
    <xsl:template match="ext:heidicon">
<!--
        <xsl:variable name="display" select="if(exists(ext:item/@display)) then ext:item[1]/@display else concat('display is missing for type:', ext:item/@type)"/>
        <h2>
            <xsl:value-of select="$display"/>
        </h2>
-->
        <xsl:choose>
            <xsl:when test="exists(ext:item/@display)">
                <h2>
                    <xsl:value-of select="ext:item/@display"/>
                </h2>
            </xsl:when>
            <xsl:otherwise>
                <h2 class="missingDisplay">
                    <xsl:value-of select="ext:item/@type"/>
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
            <xsl:for-each select="ext:item">
                <tr>
                    <td>
                        <xsl:value-of select="@type"/>
                    </td>
                    <td>
                        <xsl:value-of select="@status"/>
                    </td>
                    <td>
                        <!--<xsl:variable name="values" select="ext:value"/>-->
                        <table class="hvalues">
                            <xsl:for-each select="ext:value">
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
        <xsl:template match="ext:item[exists(@display)]">
            <h2><xsl:value-of select="@display"/></h2>
        </xsl:template>

        <xsl:template match="ext:item[not(exists(@display))]">
            <h2>missing display attribute for type: <xsl:value-of select="@type"/></h2>
        </xsl:template>
    -->
</xsl:stylesheet>
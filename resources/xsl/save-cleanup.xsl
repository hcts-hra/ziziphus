<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  xmlns:vra="http://www.vraweb.org/vracore4.htm" version="2.0">
    <xsl:strip-space elements="*" />
    <xsl:output method="xml" indent="yes"/>
    <xsl:variable name="debug" select="'true'"/>

    <xsl:template match="*">
        <xsl:message>
            <xsl:value-of select="local-name(.)"/>
        </xsl:message>
        <xsl:variable name="child-content">
            <xsl:apply-templates/>
        </xsl:variable>

        <xsl:if test="normalize-space() != '' or (normalize-space(@*[1]) != '' and local-name() != 'measurements')">
            <xsl:element name="{local-name()}" namespace="http://www.vraweb.org/vracore4.htm">
                <xsl:copy-of select="@*[not(. eq '')]"/>
                <xsl:copy-of select="$child-content"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="vra:*[contains(local-name(), 'Set')]">
        <xsl:variable name="display">
            <xsl:apply-templates select="vra:display"/>
        </xsl:variable>
        <xsl:variable name="notes">
            <xsl:apply-templates select="vra:notes"/>
        </xsl:variable>

        <xsl:variable name="child-name">
            <xsl:value-of select="substring-before(local-name(), 'Set')"/>
        </xsl:variable>

        <xsl:variable name="child-content">
            <xsl:apply-templates select="*[not(local-name() eq 'display' or local-name() eq 'notes')]"/>
        </xsl:variable>

        <xsl:if test="$debug = 'true'">
            <xsl:message>DISPLAY: <xsl:value-of select="$display"/></xsl:message>
            <xsl:message>NOTES: <xsl:value-of select="$notes"/></xsl:message>
        </xsl:if>

        <xsl:choose>
            <xsl:when test="$child-content//text()">
                <xsl:element name="{local-name()}" namespace="http://www.vraweb.org/vracore4.htm">
                    <xsl:copy-of select="@*[not(. eq '')]"/>
                    <xsl:copy-of select="$display"/>
                    <xsl:copy-of select="$notes"/>
                    <xsl:copy-of select="$child-content"/>
                </xsl:element>
            </xsl:when>
            <xsl:when test="($display and $display != '') or ($notes and $notes != '')">
                <xsl:element name="{local-name()}" namespace="http://www.vraweb.org/vracore4.htm">
                    <xsl:copy-of select="@*[not(. eq '')]"/>
                    <xsl:copy-of select="$display"/>
                    <xsl:copy-of select="$notes"/>
                    <xsl:element name="{$child-name}" namespace="http://www.vraweb.org/vracore4.htm">
                        <xsl:if test="$child-name eq 'inscription'">
                            <xsl:element name="text" namespace="http://www.vraweb.org/vracore4.htm"/>
                        </xsl:if>
                    </xsl:element>
                </xsl:element>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>
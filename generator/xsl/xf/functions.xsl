<xsl:stylesheet version="2.0"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:functx="http://www.functx.com"
        xmlns:xsd="http://www.w3.org/2001/XMLSchema"
        xpath-default-namespace="http://www.vraweb.org/vracore4.htm">

    <xsl:function name="functx:isVraAttribute" as="xsd:boolean?">
        <xsl:param name="arg" as="xsd:string?"/>
        <xsl:choose>
            <xsl:when test="$arg='dataDate'"><xsl:value-of select="true()"/></xsl:when>
            <xsl:when test="$arg='extent'"><xsl:value-of select="true()"/></xsl:when>
            <xsl:when test="$arg='href'"><xsl:value-of select="true()"/></xsl:when>
            <xsl:when test="$arg='lang'"><xsl:value-of select="true()"/></xsl:when>
            <xsl:when test="$arg='pref'"><xsl:value-of select="true()"/></xsl:when>
            <xsl:when test="$arg='refid'"><xsl:value-of select="true()"/></xsl:when>
            <xsl:when test="$arg='rules'"><xsl:value-of select="true()"/></xsl:when>
            <xsl:when test="$arg='source'"><xsl:value-of select="true()"/></xsl:when>
            <xsl:when test="$arg='vocab'"><xsl:value-of select="true()"/></xsl:when>
            <xsl:when test="$arg='transliteration'"><xsl:value-of select="true()"/></xsl:when>
            <xsl:when test="$arg='script'"><xsl:value-of select="true()"/></xsl:when>
            <xsl:when test="$arg='lastAccessed'"><xsl:value-of select="true()"/></xsl:when>
            <xsl:otherwise><xsl:value-of select="false()"/></xsl:otherwise>
        </xsl:choose>
    </xsl:function>

</xsl:stylesheet>
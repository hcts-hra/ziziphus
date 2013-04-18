<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:xf="http://www.w3.org/2002/xforms"
        >
    <xsl:output method="xml" version="1.0"/>
    <!--
    ##############################################################################################
    This stylesheet creates a new View Definition as a starting point for defining the order of elements
    in views and forms as well as they are appearing initially or not (detail class mechanism)
    ##############################################################################################
    -->


    <xsl:template match="xf:bind">
        <xsl:element name="node">
            <xsl:attribute name="name"><xsl:value-of select="@nodeset"/></xsl:attribute>
            <xsl:attribute name="detail">false</xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

<!--
    <xsl:template match="@*" >
        <xsl:choose>
            <xsl:when test="functx:isVraAttribute(local-name(.))"/>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="text()">
        <xsl:copy/>
    </xsl:template>
-->

    <!-- vra:display is not handled at all and can be filtered out -->
    <xsl:template match="xf:bind[@nodeset='vra:display']"/>
    <!--vra:notes always appears at the end of a form or view and can be handled explicitly -->
    <xsl:template match="xf:bind[@nodeset='vra:notes']"/>

</xsl:stylesheet>

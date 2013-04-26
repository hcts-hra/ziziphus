<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:xf="http://www.w3.org/2002/xforms">
    <xsl:output method="xml" version="1.0"/>
    <!--
    ##############################################################################################
    This stylesheet creates a new View Definition as a starting point for defining the order of elements
    in views and forms as well as they are appearing initially or not (detail class mechanism)
    ##############################################################################################
    -->

    <xsl:template match="/">
        <xsl:text>
        </xsl:text>
        <xsl:comment>
                This a generated file meant for further hand-editing as a UI profile. Must be placed in 'profile'
                directory to take effect during generation of forms and views.
            </xsl:comment>
            <xsl:element name="group">
                <xsl:attribute name="idref"><xsl:value-of select="./*[1]/@id"/></xsl:attribute>
                <xsl:attribute name="name"><xsl:value-of select="./*[1]/@nodeset"/></xsl:attribute>
                <xsl:apply-templates select=".//xf:bind[@nodeset='vra:collection']"/>
            </xsl:element>
    </xsl:template>

    <xsl:template match="//xf:bind[@nodeset='vra:collection']">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- matching all elements named '*Set' -->
    <xsl:template match="xf:bind[ends-with(@nodeset,'Set')]">
        <xsl:element name="set">
            <xsl:attribute name="idref" select="@id"/>
            <xsl:attribute name="name" select="@nodeset"/>
            <xsl:attribute name="visible" select="'true'"/>
            <xsl:apply-templates/>

        </xsl:element>
    </xsl:template>

    <xsl:template match="xf:bind[@maxOccurs='unbounded']">
        <xsl:text>
        </xsl:text>
        <xsl:comment>
            Structure of collection, image and work records are the same - just using collection here
        </xsl:comment>
        <xsl:text>
        </xsl:text>
        <xsl:element name="group">
            <xsl:attribute name="idref"><xsl:value-of select="@id"/></xsl:attribute>
            <xsl:attribute name="name"><xsl:value-of select="@nodeset"/></xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <!-- matches the direct children of a *Set element. and signals the repeat -->
    <xsl:template match="xf:bind[@maxOccurs='unbounded' and exists(ancestor::xf:bind[@nodeset='vra:collection'])]" priority="10">
        <xsl:element name="group">
            <xsl:attribute name="idref"><xsl:value-of select="@id"/></xsl:attribute>
            <xsl:attribute name="name"><xsl:value-of select="@nodeset"/></xsl:attribute>
            <xsl:attribute name="repeated">true</xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="xf:bind">
        <xsl:element name="node">
            <xsl:attribute name="idref"><xsl:value-of select="@id"/></xsl:attribute>
            <xsl:attribute name="name"><xsl:value-of select="@nodeset"/></xsl:attribute>
            <xsl:attribute name="detail">false</xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>



    <xsl:template match="xf:bind[ends-with(@nodeset,'Set')]//xf:bind[xf:*]">
        <xsl:element name="group">
            <xsl:attribute name="idref"><xsl:value-of select="@id"/></xsl:attribute>
            <xsl:attribute name="name"><xsl:value-of select="@nodeset"/></xsl:attribute>

            <xsl:if test="@xfType='simpleType'">
                <xsl:element name="textNode">
                    <xsl:attribute name="detail">false</xsl:attribute>
                </xsl:element>
            </xsl:if>
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
    <!--<xsl:template match="xf:bind[@nodeset='vra:notes']"/>-->

    <xsl:template match="xf:bind[@nodeset='vra:work']" priority="20"/>
    <xsl:template match="xf:bind[@nodeset='vra:image']" priority="20"/>
    <xsl:template match="//xf:bind[@nodeset='@id']" priority="10"/>

</xsl:stylesheet>

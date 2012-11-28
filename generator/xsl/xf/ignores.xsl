<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns="http://www.vraweb.org/vracore4.htm"
        xpath-default-namespace="http://www.vraweb.org/vracore4.htm"
        xmlns:xf="http://www.w3.org/2002/xforms"
        xmlns:vra="http://www.vraweb.org/vracore4.htm"
        xmlns:functx="http://www.functx.com"
        xmlns:xsd="http://www.w3.org/2001/XMLSchema"
        >
    <xsl:include href="functions.xsl"/>

    <xsl:variable name="vraAttributes"
        select="'@dataDate @extent @href @xml:lang @pref @refid @rules @source @vocab'"/>
    <!--
    ##############################################################################################
    This stylesheet contains some matchers for elements that are handled separately as their own subforms
    and are therefore ignored for the generation of subforms for the *Set subforms.
    ##############################################################################################
    -->

    <!-- TODO: we do not need separate notes/display handling in Agent, but how about others? Delete if not needed. -->
    <!-- ###### ignore display element as handled by its own subform -->
    <!-- <xsl:template match="vra:display" mode="instance" priority="10"/> -->
    <!-- ###### ignore notes element as handled by its own subform -->
    <!-- <xsl:template match="vra:notes" mode="instance" priority="10"/> -->

    <xsl:template match="@*" mode="instanceAttrs" priority="30">
        <xsl:choose>
            <xsl:when test="functx:isVraAttribute(local-name(.))"/>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="text()" mode="instanceAttrs" priority="10">
        <xsl:copy/>
    </xsl:template>


    <xsl:template match="xf:bind[@nodeset='vra:display']" mode="bind" priority="10"/>
    <xsl:template match="xf:bind[@nodeset='vra:notes']" mode="bind" priority="10"/>
    <xsl:template match="xf:bind[contains($vraAttributes,@nodeset)]" mode="bind" priority="10"/>
    <xsl:template match="xf:bind[@xfType='simpleType' and not(exists(.//@type))]" mode="bind" priority="100"/>


    <xsl:template match="xf:bind[@nodeset='vra:display']" mode="ui" priority="20"/>
    <xsl:template match="xf:bind[@nodeset='vra:notes']" mode="ui" priority="20"/>
    <xsl:template match="xf:bind[contains($vraAttributes,@nodeset)]" mode="ui" priority="20"/>
    <xsl:template match="xsd:annotation" mode="ui" priority="20"/>

</xsl:stylesheet>

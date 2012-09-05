<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:vra="http://www.vraweb.org/vracore4.htm"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xpath-default-namespace= "http://www.vraweb.org/vracore4.htm"
                xmlns:xd="http://www.pnp-software.com/XSLTdoc"
                exclude-result-prefixes="vra"
                extension-element-prefixes="xd">

    <xd:doc type="stylesheet">
        <xd:author>Lars Windauer</xd:author>
        <xd:copyright>betterFORM Project</xd:copyright>
        <xd:detail>Stylesheet to apply all redefinitions from vra-strict.xsd to vra.xsd</xd:detail>
    </xd:doc>


    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>
    <xsl:strip-space elements="*"/>


<!--
    ########################################################################################
        EXTERNAL PARAMETERS
    ########################################################################################
-->
    <xsl:param name="debug" select="'false'" as="xsd:string"/>

    <xsl:param name="path2schemaRedefinition" select="''" as="xsd:string"/>


<!--
    ########################################################################################
        GLOBAL VARIABLES
    ########################################################################################
-->

    <xsl:variable name="debugEnabled" as="xsd:boolean">
        <xsl:choose>
            <xsl:when test="$debug eq 'true' or $debug eq 'true()' or number($debug) gt 0">true</xsl:when>
            <xsl:otherwise>false</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="schemaRedefinition" select="doc($path2schemaRedefinition)"/>

<!--
    ########################################################################################
        TEMPLATE RULES
    ########################################################################################
-->


    <xd:doc>Template rule to verify the external schema with redifinitions of types is present and contains only simple types</xd:doc>
    <xsl:template match="xsd:schema">
        <xsl:if test="not(exists($schemaRedefinition))">
            <xsl:message terminate="yes">XSD with schema redefinition rules is missing</xsl:message>
            <xsl:for-each select="$schemaRedefinition/xsd:schema/xsd:redefine/*">
                <xsl:if test="local-name(.) ne 'simpleType'">
                    <xsl:message terminate="yes">This template only processes xsd:simpleTypes and not '<xsl:value-of select="name(.)"/>'</xsl:message>
                </xsl:if>
            </xsl:for-each>
        </xsl:if>
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates select="*"/>
        </xsl:copy>
    </xsl:template>

    <xd:doc>Template rule to merge redefined simple simpleTypes with simpleTypes of the original xsd</xd:doc>
    <xsl:template match="xsd:simpleType">
        <xsl:variable name="simpleTypeName" select="@name"/>
        <xsl:variable name="externalDefinition" select="$schemaRedefinition/xsd:schema/xsd:redefine/xsd:simpleType[@name eq $simpleTypeName]">
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="exists($externalDefinition)">
                <xsl:if test="$debugEnabled">
                    <xsl:message select="concat('replacing xsd:simpleType ', $simpleTypeName, ' with its redefined type')"/>
                    <xsl:comment>Redefinition of <xsl:value-of select="$simpleTypeName"/> taken from schema: <xsl:value-of select="$path2schemaRedefinition"/></xsl:comment>
                    <xsl:text>&#xA;</xsl:text>
                </xsl:if>
                <xsl:variable name="restrictionBase" select="xsd:restriction/@base"/>
                <xsl:copy>
                    <xsl:copy-of select="@*"/>
                    <xsl:for-each select="$externalDefinition/*">
                        <xsl:choose>
                            <xsl:when test="local-name(.) = 'restriction'">
                                <xsl:element name="xsd:restriction">
                                    <xsl:attribute name="base" select="$restrictionBase"/>
                                    <xsl:copy-of select="*"/>
                                </xsl:element>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:copy-of select="."/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                </xsl:copy>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy-of select="."/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


    <!--
        ########################################################################################
            HELPER TEMPLATE RULES (simply copying nodes and comments)
        ########################################################################################
    -->

    <xsl:template match="*|@*|text()">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates select="*|@*|text()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="comment()">
        <xsl:copy/>
    </xsl:template>

</xsl:stylesheet>
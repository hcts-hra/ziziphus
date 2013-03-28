<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:vra="http://www.vraweb.org/vracore4.htm"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xpath-default-namespace= "http://www.vraweb.org/vracore4.htm"
                exclude-result-prefixes="vra">

    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>
    <xsl:strip-space elements="*"/>


<!--
    ########################################################################################
        EXTERNAL PARAMETERS
    ########################################################################################
-->

    <xsl:param name="vraTypeSchemaName" select="'TAKEN FROM EXTERNAL'" as="xsd:string"/>
    <xsl:param name="debug" select="'true'" as="xsd:string"/>

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

<!--
    ########################################################################################
        TEMPLATE RULES
    ########################################################################################
-->

    <xsl:template match="xsd:schema">
        <!-- create schema containing only xsd:elements and no simple or complexTypes -->
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:element name="xsd:include">
                <xsl:attribute name="schemaLocation" select="$vraTypeSchemaName"/>
            </xsl:element>
            <xsl:copy-of select="xsd:annotation | xsd:import | xsd:element"/>
        </xsl:copy>

        <!-- create schema containing all simple and complexTypes -->
        <xsl:result-document href="{$vraTypeSchemaName}" encoding="UTF-8">
            <xsl:copy>
                <xsl:copy-of select="@*"/>
                <xsl:copy-of select="xsd:annotation | xsd:import | xsd:complexType | xsd:simpleType"/>
            </xsl:copy>
        </xsl:result-document>
    </xsl:template>

</xsl:stylesheet>
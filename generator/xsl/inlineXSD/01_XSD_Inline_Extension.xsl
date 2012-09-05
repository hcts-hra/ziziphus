<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema">

    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>
    <xsl:strip-space elements="*"/>


<!--
    ########################################################################################
        EXTERNAL PARAMETERS
    ########################################################################################
-->
    <xsl:param name="debug" select="'false'" as="xsd:string"/>

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
        <xsl:copy>     
            <xsl:copy-of select="@*"/>
            <!-- <xsl:apply-templates select="*[local-name(.) != 'complexType'][local-name(.) != 'simpleType'][local-name(.) != 'attributeGroup']"/> -->            
            <xsl:apply-templates select="*"/>                
        </xsl:copy>
    </xsl:template>


   
    <xsl:template match="xsd:complexContent[exists(xsd:extension/xsd:sequence)]" priority="10">
        <xsl:variable name="extensionBaseName" select="xsd:extension/@base"/>
        <xsl:variable name="sequenceToInsert" select="xsd:extension/xsd:sequence"/>
        <xsl:variable name="typeToExtend" select="/xsd:schema/*[@name eq $extensionBaseName]"/>
        <xsl:variable name="seqMaxOccurs" select="xsd:extension/xsd:sequence/@maxOccurs"/>
        <xsl:variable name="seqMinOccurs" select="xsd:extension/xsd:sequence/@minOccurs"/>
        <!-- <xsl:message terminate="no"><xsl:value-of select="$typeToExtend/@name"/></xsl:message> -->
        
        <xsl:variable name="inlinedExtendedSequence">
            <xsl:for-each select="$typeToExtend/*">
                <xsl:choose>
                    <xsl:when test="local-name(.) eq'sequence'">
                        <xsd:sequence>
                            <!--<xsl:message><xsl:value-of select="" </xsl:message>-->
                            <xsl:copy-of select="$sequenceToInsert/@*"/>
                            <xsl:copy-of select="*"/>
                            <xsl:for-each select="$sequenceToInsert/*">
                                <xsl:message select="concat('create element: ',@name, ' ref: ',@ref, ' seqMinOccurs:',$seqMinOccurs, ' seqMaxOccurs:',$seqMaxOccurs )"/>
                                <xsl:element name="{name(.)}">
                                    <xsl:attribute name="minOccurs" select="$seqMinOccurs"/>
                                    <xsl:attribute name="maxOccurs" select="$seqMaxOccurs"/>
                                    <xsl:copy-of select="@*"/>
                                    <xsl:copy-of select="*"/>
                                </xsl:element>
                            </xsl:for-each>
                            <!--<xsl:copy-of select="$sequenceToInsert/*"/>-->
                        </xsd:sequence>
                    </xsl:when>
                    <xsl:when test="local-name(.) eq 'annotation'">
                        <!-- <xsl:message terminate="no">Removing original annotation due to schema would be invalid with 2 annotations within one complexType</xsl:message> -->
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:copy-of select="."/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
        </xsl:variable>
        <xsl:apply-templates select="$inlinedExtendedSequence"/>                
    </xsl:template>
    
    <xsl:template match="xsd:simpleContent[xsd:extension/@base='basicString']" priority="15">
        <xsl:if test="$debugEnabled">
            <xsl:message>substitute simpleContent extension with @base='basicString': "<xsl:value-of select="xsd:extension/@base"/>"</xsl:message>
        </xsl:if>
        <xsd:simpleContent xmlns="http://www.w3.org/2001/XMLSchema">
            <xsd:extension base="xsd:string" xmlns="http://www.w3.org/2001/XMLSchema">
                <xsl:copy-of select="xsd:extension/*"/>
                <xsd:attributeGroup ref="vraAttributes" xmlns="http://www.w3.org/2001/XMLSchema"/>
            </xsd:extension>
        </xsd:simpleContent>

<!--
        <xsl:element name="simpleContent" namespace="http://www.w3.org/2001/XMLSchema">
            <xsl:element name="extension" namespace="http://www.w3.org/2001/XMLSchema">
                <xsl:attribute name="base">xsd:string</xsl:attribute>
                <xsl:copy-of select="xsd:extension/*"/>
                <xsl:element name="attributeGroup" namespace="http://www.w3.org/2001/XMLSchema">
                    <xsl:attribute name="ref">vraAttributes</xsl:attribute>
                </xsl:element>
            </xsl:element>
        </xsl:element>
-->

    </xsl:template>


    <xsl:template match="xsd:simpleContent[xsd:extension/@base='xsd:string' or xsd:extension/@base='dateValueType' ]" priority="10">
        <xsl:if test="$debugEnabled">
            <xsl:message>copy xsd:simpleContent with extension base="<xsl:value-of select="xsd:extension/@base"/>"</xsl:message>
        </xsl:if>
        <xsl:copy-of select="."/>
    </xsl:template>


    <xsl:template match="xsd:extension" >
        <xsl:message terminate="yes">unhandled xsd:extension <xsl:value-of select="@base"/></xsl:message>        
    </xsl:template>
    
    
    <xsl:template match="xsd:documentation">
        <xsl:copy><xsl:value-of select="normalize-space(.)"/></xsl:copy>
    </xsl:template>

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
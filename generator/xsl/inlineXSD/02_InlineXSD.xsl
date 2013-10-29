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

    <xsl:key name="xsdElement" match="/xsd:schema/*" use="@name" />
    <xsl:key name="xsdComplexType" match="/xsd:schema/xsd:complexType" use="@name" />


    <xsl:template match="xsd:schema">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <!-- <xsl:apply-templates select="*[local-name(.) != 'complexType'][local-name(.) != 'simpleType'][local-name(.) != 'attributeGroup']"/> -->            
            <xsl:apply-templates select="xsd:import | xsd:annotation |  xsd:element[@name ='vra'] | xsd:simpleType | xsd:complexType[@name='basicString']"/>
            <!-- <xsl:apply-templates select="*"/> -->
        </xsl:copy>
    </xsl:template>

    <xsl:template name="inlineReferencedElement" match="xsd:element[@ref]" priority="10" >
        <xsl:variable name="referenceName" select="@ref"/>
        <xsl:if test="$debugEnabled">
            <xsl:message>inlineReferencedElement: referenceName: <xsl:value-of select="$referenceName"/> </xsl:message>
        </xsl:if>

        <xsl:variable name="referencedElement" select="key('xsdElement', $referenceName)"/>
        <xsl:variable name="referencedComplexType" select="key('xsdComplexType', $referencedElement/@type)"/>

        <xsl:element name="{name($referencedElement)}">
            <xsl:attribute name="name" select="$referencedElement/@name"/>
            <xsl:choose>
                <xsl:when test="$debugEnabled">
                    <xsl:attribute name="lasse1"/>
                    <xsl:copy-of select="@*"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:copy-of select="@*[local-name(.) != 'name' and local-name(.)  != 'ref']"/>
                </xsl:otherwise>
            </xsl:choose>

            <xsl:choose>
                <xsl:when test="exists($referencedComplexType)">
                    <xsl:element name="{name($referencedComplexType)}">
                        <xsl:choose>
                            <xsl:when test="$debugEnabled">
                                <xsl:attribute name="generator1">inlineReferencedElement</xsl:attribute>                                                    
                                <xsl:copy-of select="@*"/>        
                            </xsl:when>
                            <xsl:otherwise/>                                                    
                        </xsl:choose>
                        
                        <xsl:apply-templates select="$referencedComplexType/*"/>
                    </xsl:element>                    
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:element>
    </xsl:template>
    
    <xsl:template name="inlineComplexType"  match="xsd:element[@type]" priority="10">
        <xsl:message>inlineComplextType: <xsl:value-of select="name(..)"/></xsl:message>
        <xsl:message>inlineComplextType: <xsl:value-of select="@type"/></xsl:message>
        <xsl:variable name="referencedType" select="key('xsdComplexType', @type)"/>
        <xsl:message>inlineComplextType: <xsl:value-of select="$referencedType"/></xsl:message>

        <xsl:if test="$debugEnabled">
            <xsl:message select="concat('inlineComplexType: ComplexType: ', @type)"/>
        </xsl:if>

        <xsl:if test="$referencedType">
        <xsl:choose>
            <xsl:when test="name(..)='xsd:all'">
                <xsl:copy-of select="."/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:choose>
                        <xsl:when test="$debugEnabled">
                            <xsl:attribute name="lasse2"/>
                            <xsl:copy-of select="@*"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:copy-of select="@*[name(.) != 'type']"/>
                        </xsl:otherwise>
                    </xsl:choose>

                    <xsl:element name="{name($referencedType)}">
                        <xsl:choose>
                            <xsl:when test="$debugEnabled">
                                <xsl:attribute name="lasse3"/>
                                <xsl:copy-of select="@*"/>
                            </xsl:when>
                            <xsl:otherwise/>
                        </xsl:choose>
                        <xsl:apply-templates select="$referencedType/*"/>
                    </xsl:element>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
        </xsl:if>
    </xsl:template>
        
        

    <!-- inline attributeGroups -->
    <xsl:template name="inlineAttributeGroups" match="xsd:attributeGroup[@ref]">
        <xsl:variable name="attributeGroupName" select="@ref"/>
        <xsl:variable name="attributeGroup" select="//xsd:attributeGroup[@name=$attributeGroupName]"/>          
        <xsl:for-each select="$attributeGroup/xsd:attribute">
            <!--
                <xsl:variable name="attrType" select="@type"/>
                <xsl:variable name="type" select="@type"/>
            -->
            <xsl:if test="$debugEnabled">
                <xsl:message select="concat('Namespace for attribute ' ,@name, ' : ',@ref)"></xsl:message>
            </xsl:if>
            <xsl:choose>
                <!-- handle simple xsd types -->
                <xsl:when test="exists(@name)">
                     <xsl:copy-of select="."/>
                </xsl:when>
                <!-- handle xml:lang attribute -->
                <xsl:when test="@ref='xml:lang'">
                    <xsl:copy-of select="."/>
                </xsl:when>              
                <!-- handle foreign types -->
                <!-- <xsl:when test="exists(/xsd:schema/*[@name eq $type])">
                    <xsl:copy>
                        <xsl:copy-of select="@*[local-name(.) != 'type']"></xsl:copy-of>                        
                        <xsl:copy-of select="/xsd:schema/*[@name eq $type]"/>
                    </xsl:copy>
                </xsl:when>
                -->
                <xsl:otherwise>
                    <xsl:message terminate="yes">unknown attribute <xsl:value-of select="@name"/> <xsl:value-of select="@ref"/></xsl:message>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>


    <xsl:template match="xsd:documentation">
        <xsl:copy><xsl:value-of select="normalize-space(.)"></xsl:value-of></xsl:copy>        
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
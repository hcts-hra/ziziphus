<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : save-dataDate.xsl
    Created on : 11. August 2015, 14:04
    Author     : zwobit
    Description:
        Purpose of transformation follows.
-->

<!--
<save:data xmlns:merge="http://www.betterform.de/merge">
    <save:originalInstance>
        <techniqueSet xmlns="http://www.vraweb.org/vracore4.htm">
            <display></display>
            <notes></notes>
            <technique pref="false"></technique>
        </techniqueSet>
    </save:originalInstance>
    <save:newInstance>
        <techniqueSet>
            <technique vocab="LOCAL" refid="05e81717-b5c1-552f-bafc-950a0f1ad2df">chromolithographs</technique>
        </techniqueSet>
    </save:newInstance>
</save:data>
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:save="http://www.betterform.de/save"
                xmlns:functx="http://www.functx.com"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                version="2.0"
                exclude-result-prefixes="save">

    <xsl:output exclude-result-prefixes="save" indent="yes"/>

    <xsl:variable name="originalInstance" select="/save:data/save:originalInstance/*"/>
    <xsl:variable name="debug" select="'true'"/>
    <xsl:param name="targetNS" select="'http://www.vraweb.org/vracore4.htm'"/>
    <xsl:preserve-space elements="text"/>


    <xsl:function name="functx:is-value-in-sequence" as="xs:boolean" xmlns:functx="http://www.functx.com">
        <xsl:param name="value" as="xs:anyAtomicType?"/>
        <xsl:param name="seq" as="xs:anyAtomicType*"/>

        <xsl:sequence select="$value = $seq"/>
    </xsl:function>

    <xsl:template match="/save:data">
        <xsl:message>ROOT</xsl:message>
        <xsl:apply-templates select="save:newInstance"/>
    </xsl:template>

    <xsl:template match="save:newInstance">
        <xsl:apply-templates select="*"/>
    </xsl:template>

    <xsl:template match="*[contains(local-name(), 'Set')]">
        <xsl:message>SET!</xsl:message>
        <xsl:message>Current element: <xsl:value-of select="local-name(.)"/></xsl:message>

        <xsl:element name="{local-name(.)}" namespace="{$targetNS}">
            <!-- [(local-name(.) ne 'notes') and (local-name(.) ne 'display')] -->
            <xsl:for-each-group select="*" group-by="local-name()">
                <xsl:for-each select="current-group()">
                    <xsl:apply-templates select="." mode="content">
                        <xsl:with-param name="old-data" select="$originalInstance"/>
                        <xsl:with-param name="position" select="position()"/>
                    </xsl:apply-templates>
                </xsl:for-each>
            </xsl:for-each-group>
        </xsl:element>
    </xsl:template>

    <xsl:template match="@*|text()|comment()" mode="content">
        <xsl:message>@*|text()|comment()</xsl:message>
        <xsl:variable name="this" select="."/>

        <xsl:if test="$debug = 'true'">
            <xsl:message>
                Looking for: <xsl:value-of select="local-name($this)"/> in original data
            </xsl:message>
        </xsl:if>

        <xsl:variable name="toCompare">
            <xsl:copy-of select="$originalInstance//*[local-name(.)=local-name($this)]"/>
        </xsl:variable>

        <xsl:choose>
            <!-- remove empty attributes, text and comments -->
            <xsl:when test="normalize-space(.) eq ''">
                <xsl:apply-templates select="*|@*|text()|comment()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates select="*|@*|text()|comment()"/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="*" mode="content">
        <xsl:param name="old-data"/>
        <xsl:param name="position"/>

        <xsl:variable name="local-name" select="local-name()"/>
        <xsl:variable name="this" select="."/>

        <xsl:if test="$debug = 'true'">
            <xsl:message>Content</xsl:message>
            <xsl:message>Current element: <xsl:value-of select="local-name(.)"/></xsl:message>
            <xsl:message>Position: <xsl:value-of select="$position"/></xsl:message>
            <xsl:message>OLD: <xsl:value-of select="exists($old-data//*[local-name(.)=$local-name][$position])"/></xsl:message>
        </xsl:if>

        <xsl:variable name="toCompare">
            <xsl:choose>
                <xsl:when test="exists($old-data//*[local-name(.)=$local-name][$position])">
                    <xsl:copy-of select="$old-data//*[local-name(.)=$local-name][$position]"/>
                </xsl:when>
                <xsl:otherwise></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="exists($old-data//*[local-name(.)=$local-name][$position])">
                <xsl:choose>
                    <xsl:when test="deep-equal($old-data//*[local-name(.)=$local-name][$position], $this)">
                        <xsl:if test="$debug = 'true'">
                            <xsl:message>deep-equal()</xsl:message>
                        </xsl:if>
                        <xsl:call-template name="copy"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:variable name="changes">
                            <xsl:choose>
                                <xsl:when test="@dataDate">
                                    <xsl:variable name="originalAttributes">
                                        <xsl:value-of select="$old-data//*[local-name(.)=$local-name][$position]/@*"/>
                                    </xsl:variable>
                                    <xsl:for-each select="./@*[local-name(.) != 'dataDate']">
                                        <xsl:variable name="current" select="."/>
                                        <xsl:if test="$debug = 'true'">
                                            <xsl:message>Comparing <xsl:value-of select="local-name($current)"/>:<xsl:value-of select="."/></xsl:message>
                                        </xsl:if>
                                        <xsl:if test="$current != $old-data//*[local-name(.)=$local-name][$position]/@*[local-name(.) = local-name($current)]">
                                            <xsl:if test="$debug = 'true'">
                                                <xsl:message>Value changed for: <xsl:value-of select="local-name(.)"/>: <xsl:value-of select="$old-data//*[local-name(.)=$local-name][$position]/@*[local-name(.) = local-name($current)]"/> to <xsl:value-of select="."/> </xsl:message>
                                            </xsl:if>
                                            <xsl:value-of select="'true'"/>
                                        </xsl:if>
                                    </xsl:for-each>
                                    <xsl:if test="$debug = 'true'">
                                        <xsl:message>Comparing TEXT: <xsl:value-of select="$this/text()"/>:<xsl:value-of select="$old-data//*[local-name(.)=$local-name][$position]/text()"/></xsl:message>
                                    </xsl:if>
                                    <xsl:if test="$this/text() != $old-data//*[local-name(.)=$local-name][$position]/text()">
                                        <xsl:value-of select="'true'"/>
                                    </xsl:if>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="'true'"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>

                        <xsl:message>CHANGES: <xsl:value-of select="$changes"/></xsl:message>

                        <xsl:element name="{local-name(.)}" namespace="{$targetNS}">
                            <xsl:attribute name="dataDate">
                                <xsl:choose>
                                    <xsl:when test="$changes =  ''">
                                        <xsl:value-of select="@dataDate"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="current-dateTime()"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:attribute>


                            <xsl:apply-templates select="$old-data//*[local-name(.)=$local-name][$position]/@*[local-name(.) != 'dataDate']" mode="content"/>
                            <xsl:apply-templates select="./@*[local-name(.) != 'dataDate']" mode="content"/>
                            <xsl:choose>
                                <xsl:when test="*">
                                    <xsl:for-each select="*">
                                        <xsl:apply-templates select="." mode="content">
                                            <xsl:with-param name="old-data" select="$old-data//*[local-name(.)=$local-name][$position]"/>
                                            <xsl:with-param name="position" select="position()"/>
                                        </xsl:apply-templates>
                                    </xsl:for-each>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="./text()"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:element>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="copy"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="copy">
        <xsl:if test="$debug = 'true'">
            <xsl:message>Copy: <xsl:value-of select="local-name(.)"/></xsl:message>
        </xsl:if>
        <xsl:element name="{local-name(.)}" namespace="{$targetNS}">
            <xsl:if test="not(exists(@dataDate))">
                <xsl:attribute name="dataDate">
                    <xsl:value-of select="current-dateTime()"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:copy-of select="@*[not(normalize-space(.) eq '')]"/>
            <xsl:choose>
                <xsl:when test="*">
                    <xsl:for-each select="*">
                        <xsl:call-template name="copy"/>
                    </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="./text()"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>

<!--

<xsl:template match="something" mode="content">
        <xsl:param name="old-data"/>
        <xsl:param name="position"/>

        <xsl:variable name="local-name" select="local-name()"/>
        <xsl:message>Content</xsl:message>
        <xsl:message>Current element: <xsl:value-of select="local-name(.)"/></xsl:message>
        <xsl:message>Position: <xsl:value-of select="$position"/></xsl:message>
        <xsl:message>OLD: <xsl:value-of select="exists($old-data//*[local-name(.)=$local-name][$position])"/></xsl:message>

        <xsl:element name="{local-name(.)}" namespace="{$targetNS}">
            <xsl:attribute name="pos" select="$position"/>
            <xsl:copy-of select="@*"/>
            <xsl:for-each select="*">
                <xsl:apply-templates select="." mode="content">
                    <xsl:with-param name="old-data" select="$old-data//*[local-name(.)=local-name(.)][$position]"/>
                    <xsl:with-param name="position" select="position()"/>
                </xsl:apply-templates>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>

    <xsl:template match="jibbet-nich">
        <xsl:variable name="newInstance" select="/*"/>
        <xsl:if test="$debug = 'true'">
            <xsl:message>
                Given Root Elem: <xsl:value-of select="local-name($originalInstance)"/>
                VRA Elem: <xsl:value-of select="local-name($newInstance)"/>
            </xsl:message>
        </xsl:if>


        <xsl:element name="{local-name($newInstance)}" namespace="{$targetNS}">
            <xsl:if test="not(exists(@dataDate))">
                <xsl:attribute name="dataDate">
                    <xsl:value-of select="current-dateTime()"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates select="$newInstance/@*"/>
            <xsl:for-each select="$newInstance/*">
                <xsl:if test="$debug = 'true'">
                    <xsl:message>
                        Position: <xsl:value-of select="position()"/>
                    </xsl:message>
                </xsl:if>
                <xsl:apply-templates select=".">
                    <xsl:with-param name="old-data" select="$originalInstance"/>
                    <xsl:with-param name="position" select="-1"/>
                </xsl:apply-templates>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>

-->
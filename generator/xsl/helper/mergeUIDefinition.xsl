<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:bffn="http://www.betterform.de/Functions"
        xmlns:saxon="http://saxon.sf.net/"
        xmlns:xsd="http://www.w3.org/2001/XMLSchema"
        exclude-result-prefixes="saxon">
    <xsl:output method="xml" version="1.0"/>
    <xsl:param name="generatedUIDefinition" select="''"/>
    <xsl:param name="debug" select="'false'"/>
    <!--
    ##############################################################################################
    This stylesheet creates a new View Definition as a starting point for defining the order of elements
    in views and forms as well as they are appearing initially or not (detail class mechanism)
    ##############################################################################################
    -->
    <xsl:variable name="generatedUIDefinitionDocument" select="document($generatedUIDefinition)"/>

    <xsl:template match="/group">
        <xsl:text>
        </xsl:text>
        <xsl:comment>
                This a generated file meant for further hand-editing as a UI profile. Must be placed in 'profile'
                directory to take effect during generation of forms and views.
        </xsl:comment>

        <xsl:copy>
            <xsl:copy-of select="@*[name(.) != 'xpath']"/>
            <!-- xsl:apply-templates select="*"/-->

            <xsl:apply-templates select="*" mode="merge"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="*" mode="merge">
        <xsl:variable name="idref" select="@idref"/>
        <xsl:variable name="self" select="."/>

        <xsl:variable name="matched" select="exists($generatedUIDefinitionDocument//*[@idref eq $idref])"/>
        <xsl:variable name="match" select="$generatedUIDefinitionDocument//*[@idref eq $idref]"/>

        <xsl:choose>
            <xsl:when test="name() eq 'textNode' or name() eq 'separator'">
                <xsl:copy>
                    <xsl:copy-of select="@*"/>
                </xsl:copy>
            </xsl:when>
            <xsl:when test="$matched">
                <xsl:message>matched: <xsl:value-of select="./@xpath"/></xsl:message>

                <xsl:copy>
                    <xsl:copy-of select="@*[name(.) != 'xpath']"/>
                    <xsl:apply-templates mode="merge"/>

                    <xsl:for-each select="$match/*">
                        <xsl:variable name="child-idref" select="@idref"/>

                        <xsl:choose>
                            <xsl:when test="$child-idref != ''">
                                <xsl:if test="not($self/*[@idref = $child-idref])">
                                    <xsl:message>Child: <xsl:value-of select="@xpath"/> non-match</xsl:message>
                                    <xsl:message></xsl:message>
                                    <xsl:element name="{name(.)}">
                                        <xsl:copy-of select="@*[name(.) != 'xpath']"/>
                                        <xsl:copy-of select="*"/>
                                    </xsl:element>
                                </xsl:if>
                            </xsl:when>
                            <xsl:when test="name() eq 'textNode'">
                                <xsl:message>Child: is textNode</xsl:message>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:message>?!</xsl:message>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                </xsl:copy>

            </xsl:when>
            <xsl:otherwise>
                <xsl:message>deleted: <xsl:value-of select="./@xpath"/></xsl:message>
            </xsl:otherwise>
        </xsl:choose>


        <!--
                <xsl:message></xsl:message>
                <xsl:message>Investigating...: <xsl:value-of select="$match/@name"/></xsl:message>


                <xsl:for-each select="*">
                    <xsl:variable name="child-idref" select="@idref"/>
                    <xsl:message>matched: <xsl:value-of select="./@xpath"/></xsl:message>

                    <xsl:choose>
                        <xsl:when test="$child-idref != ''">
                            <xsl:choose>
                                <xsl:when test="$match[]">

                                </xsl:when>
                                <xsl:when test="not($self/*[@idref = $child-idref])">
                                    <xsl:message>Child: <xsl:value-of select="@xpath"/> non-match</xsl:message>
                                    <xsl:message></xsl:message>
                                    <xsl:element name="{name(.)}">
                                        <xsl:copy-of select="@*"/>
                                        <xsl:copy-of select="*"/>
                                    </xsl:element>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:copy>

                                    </xsl:copy>
                                    <xsl:element name="{name($self/*[@idref = $child-idref])}">
                                        <xsl:copy-of select="@*"/>
                                        <xsl:apply-templates select="$self/*[@idref = $child-idref]" mode="merge"/>
                                    </xsl:element>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:when test="name() eq 'textNode'">
                            <xsl:message>Child: is textNode</xsl:message>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:message>?!</xsl:message>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each>
                -->
        <!--xsl:choose>
            <xsl:when test="@idref = $generatedUIDefinitionDocument//*/@idref">
                <xsl:copy>
                    <xsl:copy-of select="@*"/>
                    <xsl:apply-templates/>
                </xsl:copy>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose -->
    </xsl:template>

    <xsl:function name="bffn:concat-xpath" as="xsd:string?">
        <xsl:param name="arg1" as="xsd:string?"/>
        <xsl:param name="arg2" as="xsd:string?"/>
        <xsl:choose>
            <xsl:when test="0=string-length($arg1)"><xsl:value-of select="$arg2"/></xsl:when>
            <xsl:when test="0=string-length($arg2)"><xsl:value-of select="$arg1"/></xsl:when>
            <xsl:when test="'.'=$arg1"><xsl:value-of select="$arg2"/></xsl:when>
            <xsl:when test="ends-with($arg1,'/')"><xsl:value-of select="concat($arg1,$arg2)"/></xsl:when>
            <xsl:otherwise><xsl:value-of select="concat($arg1,concat('/',$arg2))"/></xsl:otherwise>
        </xsl:choose>
    </xsl:function>

    <xsl:template name="generate-xpath">
        <xsl:if test="exists(./@name)">
            <xsl:for-each select="ancestor-or-self::*">
                <xsl:value-of select="concat('/',  ./@name)"/>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>

    <!-- TODO merge generated UIDefinition with manual One -->
</xsl:stylesheet>


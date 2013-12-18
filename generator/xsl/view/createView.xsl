<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns:xf="http://www.w3.org/2002/xforms"
                xmlns:bf="http://betterform.sourceforge.net/xforms"
                xmlns:transform="http://betterform.de/transform"
                exclude-result-prefixes="xf bf transform">

    <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>
    <xsl:namespace-alias stylesheet-prefix="transform" result-prefix="xsl"/>

    <xsl:strip-space elements="*"/>

    <!--
    generates a stylesheet for transforming a single Set Element (e.g. AgentSet) at runtime. The resulting
    stylesheet will be found in folder 'view'.
    -->
    <!-- ATTENTION - FIRST INSTANCE MUST BE DEFAULT INSTANCE IN THE GENERATED FORM USED TO FEED THIS TRANSFORM -->
    <xsl:variable name="rootNodeName" select="name(//xf:instance[1]/*[1])"/>
    <xsl:variable name="rootMatch" select="concat('vra:',$rootNodeName)"/>

    <xsl:template match="/">

        <transform:stylesheet version="2.0"
                              xmlns="http://www.w3.org/1999/xhtml"
                              xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                              xmlns:vra="http://www.vraweb.org/vracore4.htm">
            <transform:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>


            <transform:template match="{$rootMatch}">
                <transform:param name="vraTableId"/>
                <xsl:apply-templates/>
            </transform:template>

        </transform:stylesheet>

    </xsl:template>

    <xsl:template match="html:title"/>

    <xsl:template match="html:body">
        <xsl:param name="vraTableId"/>
        <div class="simple" id="{{$vraTableId}}">
            <table class="vraSetView table table-striped">
                <xsl:apply-templates select=".//html:tbody[exists(@xf:repeat-nodeset)]"/>
            </table>
        </div>
    </xsl:template>

    <xsl:template match="html:tbody">
        <tbody>
            <transform:for-each select="{@xf:repeat-nodeset}">
                <tr>
                    <xsl:for-each select="//xf:group[@id='outerGroup']/html:table//html:td[@class='contentCol']/*">
                        <xsl:choose>
                            <xsl:when test="exists(@hideInView)">
                              <xsl:message>Ignoring <xsl:value-of select="local-name(.)"/></xsl:message>  
                            </xsl:when>
                            <xsl:otherwise>
                                <td>
                                    <xsl:apply-templates select="."/>
                                </td>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                </tr>
            </transform:for-each>
        </tbody>
    </xsl:template>
    
    <xsl:template match="xf:repeat">
        <table class="vraSetInnerRepeatView table">
            <tbody>
                <transform:for-each select="{@ref}">
                    <tr>
                        <xsl:for-each select="html:span/xf:*[contains(@class, '-autocomplete')] | xf:*">
                            <xsl:message>Current <xsl:value-of select="local-name(.)"/></xsl:message>
                            <td>
                                <xsl:apply-templates select="."/>
                            </td>
                        </xsl:for-each>
                    </tr>
                </transform:for-each>
            </tbody>
        </table>        
    </xsl:template>

    <xsl:template match="html:td">
        <xsl:element name="td">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="xf:group[@appearance='minimal']">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- ##### start ignores #####-->
    <xsl:template match="html:td[@class='globalAttrs']" priority="10"/>
    <xsl:template match="xf:trigger[@class='vraAttributeTrigger']" priority="10"/>

    <!-- ##### end ignores ##### -->

    <xsl:template match="xf:group">
        <xsl:for-each select="xf:*">
            <xsl:apply-templates select="."/>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="xf:input | xf:select1 | xf:textarea">
        <xsl:variable name="path">
            <xsl:call-template name="buildPath"/>
        </xsl:variable>
        <xsl:variable name="isDetail" select="if(@class='detail') then true() else false()"/>

            <xsl:choose>
            <xsl:when test="contains(@ref, '@circa')">
                <transform:choose>
                    <transform:when test="string-length(string-join({@ref},'')) != 0 and {@ref} eq 'true'">
                        <div class="subtitle" data-bf-type="{local-name(.)}" data-bf-bind="{@ref}" tabindex="0" title="{xf:label}">circa</div>
                    </transform:when>
                    <transform:otherwise>
                        <div class="nodata" data-bf-type="{local-name(.)}" data-bf-bind="{@ref}" tabindex="0">(<xsl:value-of select="xf:label"/>)</div>
                    </transform:otherwise>
                    <!--<transform:otherwise><div class="detail" data-bf-type="{local-name(.)}" data-bf-bind="{@ref}" tabindex="0"><a href="#" title="Click to add element: {xf:label}">[+]</a></div></transform:otherwise>-->
                </transform:choose>
            </xsl:when>

            <xsl:otherwise>
                <transform:choose>
                    <transform:when test="string-length(string-join({@ref},'')) != 0">
                        <!--<div id="{@id}" data-bf-type="{local-name(.)}" data-bf-bind="{@ref}" contenteditable="true">-->
                        <div data-bf-type="{local-name(.)}" data-bf-bind="{@ref}" tabindex="0" title="{xf:label}">
                            <xsl:copy-of select="@*[not(name()='ref')]"/>
                            <xsl:choose>
                                <xsl:when test="@ref eq 'vra:role/@type'">
                                    <!-- Ignore -->
                                </xsl:when>
                                <xsl:when test="@ref eq 'vra:role'">
                                    <transform:variable name="role" select="{@ref}"/>
                                    <transform:value-of select="$role-codes-legend//item[value eq $role]/label"/>
                                </xsl:when>
                                <!-- View mode lang is not displayed yet, so no handling. UNTESTED! -->
                                <!-- xsl:when test="@ref eq '@lang'">
                                    <transform:variable name="lang" select="{@ref}"/>
                                    <transform:value-of select="$language-3-type-codes//item[value eq $lang/label"/>
                                </xsl:when -->
                                <xsl:otherwise>
                                    <transform:value-of select="{@ref}"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </div>
                    </transform:when>

                    <transform:otherwise>
                        <div class="nodata" data-bf-type="{local-name(.)}" data-bf-bind="{@ref}" tabindex="0">(<xsl:value-of select="xf:label"/>)</div>
                    </transform:otherwise>
                    <!--<transform:otherwise><div class="detail" data-bf-type="{local-name(.)}" data-bf-bind="{@ref}" tabindex="0"><a href="#" title="Click to add element: {xf:label}">[+]</a></div></transform:otherwise>-->
                </transform:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="buildPath">
        <xsl:variable name="tmp">
            /<xsl:value-of select="$rootMatch"/>
            <xsl:for-each select="ancestor-or-self::*">
                <xsl:choose>
                    <xsl:when test="exists(@ref) and starts-with(@ref,'instance')"/>
                    <xsl:when test="exists(@ref)">
                        <xsl:if test="position() != 1">/</xsl:if>
                        <xsl:value-of select="@ref"/>
                    </xsl:when>
                    <xsl:when test="exists(@xf:repeat-nodeset)">/<xsl:value-of select="@xf:repeat-nodeset"/></xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="normalize-space($tmp)"/>
    </xsl:template>

    <xsl:template match="xf:hint"/>
    <xsl:template match="xf:label"/>
    <xsl:template match="html:label"/>

    <xsl:template match="html:script"/>
</xsl:stylesheet>
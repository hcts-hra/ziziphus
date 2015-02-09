<xsl:stylesheet exclude-result-prefixes="xf bf transform" version="2.0"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:bf="http://betterform.sourceforge.net/xforms"
    xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns:transform="http://betterform.de/transform"
    xmlns:xf="http://www.w3.org/2002/xforms" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output encoding="UTF-8" indent="no" method="xhtml"
        omit-xml-declaration="no" version="1.0"/>
    <xsl:namespace-alias result-prefix="xsl" stylesheet-prefix="transform"/>
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
            xmlns:vra="http://www.vraweb.org/vracore4.htm" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
            <transform:output encoding="UTF-8" indent="yes"
                method="xhtml" omit-xml-declaration="no" version="1.0"/>
            <transform:strip-space elements="*"/>
            <transform:preserve-space elements="vra:text"/>
            <transform:template match="{$rootMatch}">
                <transform:param name="vraTableId"/>
                <xsl:apply-templates/>
            </transform:template>
        </transform:stylesheet>
    </xsl:template>
    <xsl:template match="html:title"/>
    <xsl:template match="html:body">
        <xsl:param name="vraTableId"/>
        <xsl:message>html:body</xsl:message>
        <div class="simple" id="{{$vraTableId}}">
            <table class="vraSetView table table-striped">
                <xsl:apply-templates select=".//html:tbody[exists(@xf:repeat-nodeset)]"/>
            </table>
        </div>
    </xsl:template>
    <xsl:template match="html:tbody">
        <xsl:message>html:tbody</xsl:message>
        <tbody>
            <transform:for-each select="{@xf:repeat-nodeset}">
                <tr>
                    <xsl:for-each select="//xf:group[@id='outerGroup']/html:table//html:td[@class='contentCol']/*">
                        <xsl:choose>
                            <xsl:when test="exists(@hideInView)">
                                <xsl:message>Ignoring <xsl:value-of select="local-name(.)"/>
                                </xsl:message>
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
        <xsl:message>xf:repeat</xsl:message>
        <table class="vraSetInnerRepeatView table">
            <tbody>
                <transform:for-each select="{@ref}">
                    <tr>
                        <xsl:for-each select="html:span/xf:*[contains(@class, '-autocomplete')] | xf:input | xf:textarea | xf:select | xf:select1">
                            <xsl:message>Current <xsl:value-of select="local-name(.)"/>
                            </xsl:message>
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
        <xsl:message>html:td</xsl:message>
        <xsl:element name="td">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="xf:group[@appearance='minimal']">
        <xsl:message>xf:group[@appearance='minimal']</xsl:message>
        <xsl:apply-templates/>
    </xsl:template>
    <!-- ##### start ignores #####-->
    <xsl:template match="html:td[@class='globalAttrs']" priority="10"/>
    <xsl:template match="xf:group[@class='vraAttributes']" priority="10"/>
    <xsl:template match="xf:trigger[@class='vraAttributeTrigger']" priority="10"/>
    <!-- ##### end ignores ##### -->
    <xsl:template match="xf:group">
        <xsl:message>xf:group</xsl:message>
        <xsl:for-each select="xf:*">
            <xsl:apply-templates select="."/>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="xf:input | xf:select1 | xf:textarea">
        <xsl:message>xf:input | xf:select1 | xf:textarea</xsl:message>
        <xsl:variable name="path">
            <xsl:call-template name="buildPath"/>
        </xsl:variable>
        <xsl:variable name="label-full-xpath">
            <xsl:choose>
                <xsl:when test="xf:label/xf:output">
                    <xsl:value-of select="xf:label/xf:output/@ref"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="xf:label/@ref"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="label-xpath" select="substring-after($label-full-xpath, ')')"/>
        <xsl:variable name="label" select="concat('$language-files', '/language', $label-xpath)"/>
        <xsl:variable name="isDetail" select="if(@class='detail') then true() else false()"/>
        <xsl:choose>
            <xsl:when test="contains(@ref, '@circa')">
                <transform:choose>
                    <transform:when test="string-length(string-join({@ref},'')) != 0 and {@ref} eq 'true'">
                        <div class="subtitle" data-bf-bind="{@ref}"
                            data-bf-type="{local-name(.)}" tabindex="0" title="{xf:label}">circa</div>
                    </transform:when>
                    <transform:otherwise>
                        <div class="nodata" data-bf-bind="{@ref}"
                            data-bf-type="{local-name(.)}" tabindex="0">
                            <transform:value-of select="normalize-space(concat('(', {$label}, ')'))"/>
                        </div>
                    </transform:otherwise>
                    <!--<transform:otherwise><div class="detail" data-bf-type="{local-name(.)}" data-bf-bind="{@ref}" tabindex="0"><a href="#" title="Click to add element: {xf:label}">[+]</a></div></transform:otherwise>-->
                </transform:choose>
            </xsl:when>
            <xsl:otherwise>
                <transform:choose>
                    <transform:when test="string-length(string-join({@ref},'')) != 0">
                        <!--<div id="{@id}" data-bf-type="{local-name(.)}" data-bf-bind="{@ref}" contenteditable="true">-->
                        <div data-bf-bind="{@ref}"
                            data-bf-type="{local-name(.)}" tabindex="0" title="{xf:label}">
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
                        <div class="nodata" data-bf-bind="{@ref}"
                            data-bf-type="{local-name(.)}" tabindex="0">
                            <transform:value-of select="normalize-space(concat('(', {$label}, ')'))"/>
                        </div>
                    </transform:otherwise>
                    <!--<transform:otherwise><div class="detail" data-bf-type="{local-name(.)}" data-bf-bind="{@ref}" tabindex="0"><a href="#" title="Click to add element: {xf:label}">[+]</a></div></transform:otherwise>-->
                </transform:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="buildPath">
        <xsl:message>buildPath</xsl:message>
        <xsl:variable name="tmp">
            /<xsl:value-of select="$rootMatch"/>
            <xsl:for-each select="ancestor-or-self::*">
                <xsl:choose>
                    <xsl:when test="exists(@ref) and starts-with(@ref,'instance')"/>
                    <xsl:when test="exists(@ref)">
                        <xsl:if test="position() != 1">/</xsl:if>
                        <xsl:value-of select="@ref"/>
                    </xsl:when>
                    <xsl:when
                            test="exists(@xf:repeat-nodeset)">/<xsl:value-of select="@xf:repeat-nodeset"/>
                    </xsl:when>
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

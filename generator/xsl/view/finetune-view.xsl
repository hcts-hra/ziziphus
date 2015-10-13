<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : finetune-view.xsl
    Created on : 24. April 2014, 11:08
    Author     : zwobit
    Description:
        Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns:transform="http://betterform.de/transform"
                xmlns:vra="http://www.vraweb.org/vracore4.htm"
                version="2.0">
    <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>
    <xsl:strip-space elements="*"/>
    <xsl:namespace-alias stylesheet-prefix="transform" result-prefix="xsl"/>

    <xsl:template match="*|text()|comment()">
        <xsl:copy>
            <xsl:copy-of select ="@*|text()|comment()"/>
            <xsl:apply-templates select="*"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="//xsl:when[contains(@test, 'string-length(string-join(@relids')]/html:div">
        <xsl:copy>
            <xsl:copy-of select ="@*"/>
            <transform:choose>
                <transform:when test="@type eq 'imageIs'">
                    <img>
                        <transform:attribute name="src" select="concat('/exist/apps/ziziphus/imageService/?imagerecord=', @relids)"/>
                        <transform:attribute name="alt" select="@relids"/>
                        <transform:attribute name="class" select="relationSetImage"/>
                        <!-- TODO: load work via Image record -->
                        <!-- transform:attribute name="onclick" select="concat('loadRecord(', @relids, ')')"/-->
                    </img>
                </transform:when>
                <transform:otherwise>
                    <xsl:copy-of select ="*"/>
                </transform:otherwise>
            </transform:choose>

        </xsl:copy>
    </xsl:template>


    <xsl:template match="//xsl:template[@match = 'vra:agentSet']//html:table[contains(@class, 'vraSetView')]//html:tr">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:copy-of select="html:td[1]"/>
            <xsl:copy-of select="html:td[2]"/>
            <xsl:copy-of select="html:td[3]"/>
            <xsl:copy-of select="html:td[4]"/>
            <td>
                <table class="table viewADateTable">
                    <tr>
                        <td>
                            <xsl:copy-of select="html:td[5]/xsl:choose[4]"/>
                        </td>
                        <td>
                            <xsl:copy-of select="html:td[5]/xsl:choose[2]"/>
                        </td>
                    </tr>
                </table>
                <table class="table viewADateTable">
                    <tr>
                        <td>
                            <xsl:copy-of select="html:td[5]/xsl:choose[7]"/>
                        </td>
                        <td>
                            <xsl:copy-of select="html:td[5]/xsl:choose[5]"/>
                        </td>
                    </tr>
                </table>

            </td>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="//xsl:template[@match = 'vra:dateSet']//html:table[contains(@class, 'vraSetView')]">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <tbody>
                <xsl:copy-of select="html:tbody/@*"/>
                <tr>
                    <td>Type of Date</td>
                    <td>Earliest Date</td>
                    <td>Latest Date</td>
                </tr>
                <transform:for-each>
                    <xsl:copy-of select="html:tbody/xsl:for-each/@*"/>
                    <tr>
                        <xsl:copy-of select="html:tbody/xsl:for-each/html:tr/@*"/>
                        <xsl:copy-of select="html:tbody/xsl:for-each/html:tr/html:td[1]"/>
                        <!-- earliestDate -->
                        <td>
                            <xsl:copy-of select="html:tbody/xsl:for-each/html:tr/html:td[2]/@*"/>
                            <table class="table viewDateTable">
                                <tbody>
                                    <tr>
                                        <td>
                                            <!-- type -->
                                            <xsl:copy-of select="html:tbody/xsl:for-each/html:tr/html:td[2]/xsl:choose[3]"/>
                                        </td>
                                        <td>
                                            <!-- date -->
                                            <xsl:copy-of select="html:tbody/xsl:for-each/html:tr/html:td[2]/xsl:choose[1]"/>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <!-- altNotation -->
                            <xsl:copy-of select="html:tbody/xsl:for-each/html:tr/html:td[2]/html:table"/>
                        </td>
                        <!-- latestdate -->
                        <td class="viewDateTable">
                            <xsl:copy-of select="html:tbody/xsl:for-each/html:tr/html:td[3]/@*"/>
                            <table class="table viewDateTable">
                                <tbody>
                                    <tr>
                                        <td>
                                            <!-- type -->
                                            <xsl:copy-of select="html:tbody/xsl:for-each/html:tr/html:td[3]/xsl:choose[3]"/>
                                        </td>
                                        <td>
                                            <!-- date -->
                                            <xsl:copy-of select="html:tbody/xsl:for-each/html:tr/html:td[3]/xsl:choose[1]"/>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <!-- altNotation -->
                            <xsl:copy-of select="html:tbody/xsl:for-each/html:tr/html:td[3]/html:table"/>
                        </td>
                    </tr>
                </transform:for-each>
            </tbody>
        </xsl:copy>
    </xsl:template>


    <xsl:template match="//xsl:template[@match = 'vra:subjectSet']//html:table[contains(@class, 'vraSetView')]">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <tbody>
                <transform:for-each-group select="vra:subject" group-by="vra:term/@type">
                    <transform:sort select="current-grouping-key()"/>
                    <transform:for-each select="current-group()">
                        <transform:sort select="translate(vra:term, 'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
                        <tr>
                            <td>
                                <transform:choose>
                                    <transform:when test="string-length(string-join(vra:term,'')) != 0">
                                        <transform:variable name="term" select="vra:term"/>
                                        <transform:variable name="type">
                                            <transform:choose>
                                                <transform:when test="string-length(string-join($term/@type,'')) != 0">
                                                    <transform:value-of select="concat(' [', normalize-space($term/@type),']')"/>
                                                </transform:when>
                                                <transform:otherwise/>
                                            </transform:choose>
                                        </transform:variable>
                                        <div data-bf-type="input" data-bf-bind="vra:term" tabindex="0" title="Term">
                                            <transform:value-of select="$term"/>
                                            <transform:value-of select="$type"/>
                                        </div>
                                    </transform:when>
                                    <transform:otherwise>
                                        <div class="nodata" data-bf-type="input" data-bf-bind="vra:term"
                                             tabindex="0">(Term)</div>
                                    </transform:otherwise>
                                </transform:choose>
                            </td>
                        </tr>
                    </transform:for-each>
                </transform:for-each-group>
            </tbody>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="//xsl:template[@match = 'vra:descriptionSet']//html:table[contains(@class, 'vraSetView')]">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <transform:for-each select="vra:description">
                <tbody class="vraSetView">
                    <transform:choose>
                        <transform:when test="string-length(string-join(@type,'')) != 0">
                            <div data-bf-type="input" data-bf-bind="@type" tabindex="0" title="type">
                                <transform:value-of select="@type"></transform:value-of>
                            </div>
                        </transform:when>
                        <transform:otherwise>
                            <div class="nodata" data-bf-type="input" data-bf-bind="@type" tabindex="0">(type)</div>
                        </transform:otherwise>
                    </transform:choose>
                    <transform:for-each select="vra:text">
                        <tr>
                            <td colspan="3">
                                <transform:choose>
                                    <transform:when test="string-length(string-join(. ,'')) != 0">
                                        <div data-bf-type="textarea" data-bf-bind="vra:text" tabindex="0" title="Text"  class="textarea keepWhitespace">
                                            <transform:if xmlns="" test="string-length() - string-length(translate(., '&#xA;', '')) &gt; 5">
                                                <transform:attribute name="data-expand">100%</transform:attribute>
                                                <transform:attribute name="data-collapse">75px</transform:attribute>
                                            </transform:if>
                                            <transform:value-of select="."></transform:value-of>
                                        </div>
                                        <transform:if test="string-length() - string-length(translate(., '&#xA;', '')) &gt; 5">
                                            <div class="expand">
                                                <span class="fa fa-arrow-down"/>
                                                <span>Click to Read More</span>
                                                <span class="fa fa-arrow-down"/>
                                            </div>
                                            <div class="contract hide">
                                                <span class="fa fa-arrow-up"/>
                                                <span>Click to Hide</span>
                                                <span class="fa fa-arrow-up"/>
                                            </div>
                                        </transform:if>
                                    </transform:when>
                                    <transform:otherwise>
                                        <div class="nodata" data-bf-type="textarea" data-bf-bind="vra:text" tabindex="0">(Text)</div>
                                    </transform:otherwise>
                                </transform:choose>
                            </td>
                        </tr>

                    </transform:for-each>
                    <transform:for-each select="vra:author">
                        <transform:if test="string-length(string-join(vra:name,'')) != 0 or string-length(string-join(vra:name/@type,'')) != 0 or string-length(string-join(vra:role,'')) != 0">
                            <tr>
                                <td>
                                    <transform:choose>
                                        <transform:when test="string-length(string-join(vra:name,'')) != 0">
                                            <div data-bf-type="input" data-bf-bind="vra:name" tabindex="0" title="Name" class="Name-autocomplete">
                                                <transform:value-of select="vra:name"></transform:value-of>
                                            </div>
                                        </transform:when>
                                        <transform:otherwise>
                                            <div class="nodata" data-bf-type="input" data-bf-bind="vra:name" tabindex="0">(Name)</div>
                                        </transform:otherwise>
                                    </transform:choose>
                                </td>
                                <td>
                                    <transform:choose>
                                        <transform:when test="string-length(string-join(vra:name/@type,'')) != 0">
                                            <div data-bf-type="select1" data-bf-bind="vra:name/@type" tabindex="0" title="Type" class=" nameType">
                                                <transform:value-of select="vra:name/@type"></transform:value-of>
                                            </div>
                                        </transform:when>
                                        <transform:otherwise>
                                            <div class="nodata" data-bf-type="select1" data-bf-bind="vra:name/@type" tabindex="0">(Type)</div>
                                        </transform:otherwise>
                                    </transform:choose>
                                </td>
                                <td>
                                    <transform:choose>
                                        <transform:when test="string-length(string-join(vra:role,'')) != 0">
                                            <div data-bf-type="select1" data-bf-bind="vra:role" tabindex="0" title="Role">
                                                <transform:variable name="role" select="vra:role"></transform:variable>
                                                <transform:value-of select="$role-codes-legend//item[value eq $role]/label"></transform:value-of>
                                            </div>
                                        </transform:when>
                                        <transform:otherwise>
                                            <div class="nodata" data-bf-type="select1" data-bf-bind="vra:role" tabindex="0">(Role)</div>
                                        </transform:otherwise>
                                    </transform:choose>
                                </td>
                            </tr>
                        </transform:if>
                    </transform:for-each>
                </tbody>
            </transform:for-each>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="//xsl:template[@match = 'vra:inscriptionSet']//html:table">
        <xsl:copy>
            <xsl:copy-of select ="@*"/>
            <xsl:apply-templates select="*" mode="inscriptionSet"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="//html:div[contains(@class, 'textType')]" mode="inscriptionSet" priority="10">
        <div>
            <xsl:attribute name="class">
                <xsl:value-of select="concat(@class, ' nodata')"/>
            </xsl:attribute>
            <xsl:copy-of select="@*[local-name() ne 'class']"/>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="//html:div[@data-bf-type eq 'textarea']" mode="inscriptionSet" priority="10">
        <xsl:call-template name="add-whitespace-pre-line-to-divs"/>
    </xsl:template>

    <xsl:template match="*|text()|comment()" mode="inscriptionSet">
        <xsl:copy>
            <xsl:copy-of select ="@*|text()|comment()"/>
            <xsl:apply-templates select="*" mode="inscriptionSet"/>
        </xsl:copy>
    </xsl:template>

    <!--
    <xsl:template match="//xsl:template[@match = 'vra:inscriptionSet']//html:table[//html:div[@data-bf-type eq 'textarea']]//html:div[@data-bf-type]">
        <xsl:call-template name="add-whitespace-pre-line-to-divs"/>
    </xsl:template>
    -->

    <xsl:template match="//xsl:template[@match = 'vra:rightsSet']//html:table[//html:div[@data-bf-type eq 'textarea']]//html:div[@data-bf-type]">
        <xsl:call-template name="add-whitespace-pre-line-to-divs"/>
    </xsl:template>

    <xsl:template name="add-whitespace-pre-line-to-divs">
        <xsl:variable name="class">
            <xsl:if test="@data-bf-type eq 'textarea'">textarea </xsl:if>
            <xsl:choose>
                <xsl:when test="@class">
                    <xsl:value-of select="concat(@class, ' keepWhitespace')"/>
                </xsl:when>
                <xsl:otherwise>keepWhitespace</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:copy>
            <xsl:attribute name="class">
                <xsl:value-of select="$class"/>
            </xsl:attribute>
            <xsl:copy-of select="@*[local-name() ne 'class']"/>
            <!-- expand/collapse-->
            <!-- TODO: get value of xsl:value-of="" and test string-length -->

            <xsl:if test="@data-bf-type eq 'textarea'">
                <transform:if>
                    <xsl:attribute name="test">string-length() - string-length(translate(<xsl:value-of select="@data-bf-bind"/>, '&#xA;', '')) &gt; 5</xsl:attribute>
                    <transform:attribute name="data-expand">100%</transform:attribute>
                    <transform:attribute name="data-collapse">75px</transform:attribute>
                </transform:if>
            </xsl:if>
            <xsl:copy-of select="*|text()"/>
        </xsl:copy>
        <!-- expand/collapse-->
        <!-- TODO: get value of xsl:value-of="" and test string-length -->

        <xsl:if test="@data-bf-type eq 'textarea'">
            <transform:if>
                <xsl:attribute name="test">string-length() - string-length(translate(<xsl:value-of select="@data-bf-bind"/>, '&#xA;', '')) &gt; 5</xsl:attribute>
                <div class="expand">
                    <span class="fa fa-arrow-down"/>
                    <span>Click to Read More</span>
                    <span class="fa fa-arrow-down"/>
                </div>
                <div class="contract hide">
                    <span class="fa fa-arrow-up"/>
                    <span>Click to Hide</span>
                    <span class="fa fa-arrow-up"/>
                </div>
            </transform:if>
        </xsl:if>
    </xsl:template>

    <xsl:template match="//xsl:template[@match = 'vra:measurementsSet']//xsl:for-each[@select = 'vra:measurements']//html:tr/html:td//html:div">
        <xsl:copy>
            <xsl:attribute name="class" select="concat(@class , ' d-inline-block')"/>
            <xsl:copy-of select="@*[local-name() ne 'class']"/>
            <xsl:apply-templates select="*"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>

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
            <img>
                <transform:attribute name="src" select="concat('/exist/apps/ziziphus/imageService/?imagerecord=', @relids)"/>
                <transform:attribute name="alt" select="@relids"/>
                <transform:attribute name="class" select="relationSetImage"/>
                <!-- TODO: load work via Image record -->
                <!-- transform:attribute name="onclick" select="concat('loadRecord(', @relids, ')')"/-->
            </img>
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
                                                <transform:when test="string-length(string-join($term/@type,'')) != 0"><transform:value-of select="concat(' [', normalize-space($term/@type),']')"/></transform:when>
                                                <transform:otherwise/>
                                            </transform:choose>
                                        </transform:variable>
                                        <div data-bf-type="input" data-bf-bind="vra:term" tabindex="0" title="Term">
                                            <transform:value-of select="$term"/> <transform:value-of select="$type"/>
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
    
    
    <xsl:template match="//xsl:template[@match = 'vra:descriptionSet']//html:table[//html:div[@data-bf-type eq 'textarea']]//html:div[@data-bf-type]">
        <xsl:call-template name="add-whitespace-pre-line-to-divs"/>
    </xsl:template>
    
    <xsl:template match="//xsl:template[@match = 'vra:inscriptionSet']//html:table[//html:div[@data-bf-type eq 'textarea']]//html:div[@data-bf-type]">
        <xsl:call-template name="add-whitespace-pre-line-to-divs"/>
    </xsl:template>

    <xsl:template match="//xsl:template[@match = 'vra:rightsSet']//html:table[//html:div[@data-bf-type eq 'textarea']]//html:div[@data-bf-type]">
        <xsl:call-template name="add-whitespace-pre-line-to-divs"/>
    </xsl:template>
    
    <xsl:template name="add-whitespace-pre-line-to-divs">
        <xsl:variable name="class">
            <xsl:choose>
                <xsl:when test="@class"><xsl:value-of select="concat(@class, ' keepWhitespace')"/></xsl:when>
                <xsl:otherwise>keepWhitespace</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:copy>
            <xsl:attribute name="class"><xsl:value-of select="$class"/></xsl:attribute>
            <xsl:copy-of select="@*[local-name() ne 'class']"/>
            <xsl:copy-of select="*|text()"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>

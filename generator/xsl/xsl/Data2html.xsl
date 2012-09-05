<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:xf="http://www.w3.org/2002/xforms"
                xmlns:tt="http://www.betterform.de/xsl/generate"
                exclude-result-prefixes="tt html xf">

    <xsl:output omit-xml-declaration="yes" indent="yes"/>

    <xsl:namespace-alias result-prefix="xsl" stylesheet-prefix="tt"/>

    <xsl:template match="/html:html/html:body/html:div[@id='xforms']">

        <tt:stylesheet version="2.0"
                       xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                       xmlns:vra="http://www.vraweb.org/vracore4.htm"
                       exclude-result-prefixes="vra">

            <tt:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>

            <xsl:variable name="sectionRoot" select="concat('vra:',name(//xf:model[1]/xf:instance[1]/*[1]))"/>

            <tt:template match="{$sectionRoot}" priority="40">
                <div class="vraSection">
                    <xsl:apply-templates select="xf:group/*">
                        <xsl:with-param name="path" select="$sectionRoot"/>
                    </xsl:apply-templates>
                </div>
            </tt:template>
        </tt:stylesheet>
    </xsl:template>




    <xsl:template match="xf:input|xf:select1|xf:textarea|xf:output">
        <xsl:message>Type: <xsl:value-of select="@type"/></xsl:message>
        <xsl:variable name="class">
            <xsl:choose>
                <xsl:when test="exists(@type) and @type eq 'attributeValue'">vraAttribute</xsl:when>
                <xsl:otherwise>vraNode</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="xpath">
            <xsl:choose>
                <xsl:when test="exists(@ref)"><xsl:value-of select="@ref"/></xsl:when>
                <xsl:otherwise><xsl:value-of select="@value"/></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <span class="{$class}"><tt:value-of select="{$xpath}"/></span>

    </xsl:template>

    <xsl:template match="html:div[contains(@class,'hiddenAttributes')]"/>


    <xsl:template match="xf:repeat">
        <tt:for-each select="{@nodeset}">
            <div>
                <xsl:apply-templates/>
            </div>
        </tt:for-each>
    </xsl:template>

    <xsl:template match="*">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="@*|text()|comment()"/>



</xsl:stylesheet>
<xsl:stylesheet version="2.0"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns="http://www.w3.org/1999/xhtml"
        xmlns:html="http://www.w3.org/1999/xhtml"
        xmlns:xf="http://www.w3.org/2002/xforms"
        xmlns:bf="http://betterform.sourceforge.net/xforms"
        xmlns:transform="http://betterform.de/transform"
        exclude-result-prefixes="xf bf transform">

    <xsl:output method="xhtml" omit-xml-declaration="yes"/>
    <xsl:namespace-alias stylesheet-prefix="transform" result-prefix="xsl"/>

    <xsl:strip-space elements="*"/>

    <!-- ATTENTION - FIRST INSTANCE MUST BE DEFAULT INSTANCE IN THE GENERATED FORM USED TO FEED THIS TRANSFORM -->
    <xsl:variable name="rootNodeName" select="name(//xf:instance[1]/*[1])"/>
    <xsl:variable name="rootMatch" select="concat('vra:',$rootNodeName)"/>

    <xsl:template match="/">

        <transform:stylesheet version="2.0"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:vra="http://www.vraweb.org/vracore4.htm">
            <transform:output method="xhtml" omit-xml-declaration="yes"/>


            <transform:template match="{$rootMatch}">
                <html>
                    <head>
                        <title><xsl:value-of select="//html:title"/></title>
                    </head>
                    <xsl:apply-templates/>
                </html>
            </transform:template>

        </transform:stylesheet>

    </xsl:template>

    <xsl:template match="html:title"/>

    <xsl:template match="html:body">
        <xsl:element name="body">

            <table class="vraSetView table table-striped">
                <xsl:apply-templates select=".//html:tbody[exists(@xf:repeat-nodeset)]"/>
            </table>
        </xsl:element>
    </xsl:template>

    <xsl:template match="html:tbody">
        <tbody>
            <transform:for-each select="{@xf:repeat-nodeset}">
                <tr>
                    <xsl:for-each select="//xf:group[@id='outerGroup']/html:table//html:td[@class='contentCol']/*">
                        <td>
                            <xsl:apply-templates select="."/>
                        </td>
                    </xsl:for-each>
                </tr>
            </transform:for-each>
        </tbody>
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

    <xsl:template match="xf:input | xf:select1">
        <xsl:variable name="path"><xsl:call-template name="buildPath"/></xsl:variable>
        <div id="{@id}" data-bf-type="{local-name(.)}" data-bf-bind="{@ref}">
            <transform:value-of select="{@ref}"/>
        </div>
    </xsl:template>

    <xsl:template name="buildPath">
        <xsl:variable name="tmp">
            /<xsl:value-of select="$rootMatch"/>
            <xsl:for-each select="ancestor-or-self::*">
                <xsl:choose>
                    <xsl:when test="exists(@ref) and starts-with(@ref,'instance')"/>
                    <xsl:when test="exists(@ref)"><xsl:if test="position() != 1">/</xsl:if><xsl:value-of select="@ref"/></xsl:when>
                    <xsl:when test="exists(@xf:repeat-nodeset)">/<xsl:value-of select="@xf:repeat-nodeset"/></xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="normalize-space($tmp)"/>
    </xsl:template>

</xsl:stylesheet>
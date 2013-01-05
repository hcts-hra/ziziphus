<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns="http://www.vraweb.org/vracore4.htm"
        xpath-default-namespace="http://www.vraweb.org/vracore4.htm"
        xmlns:xf="http://www.w3.org/2002/xforms"
        xmlns:vra="http://www.vraweb.org/vracore4.htm"
        xmlns:xsd="http://www.w3.org/2001/XMLSchema"
        >

    <xsl:param name="incomingData"/>

    <xsl:variable name="importData" select="doc($incomingData)"/>
    <xsl:variable name="debug" select="'true'" />
    <!--
    Transform to merge two data files of same structure but one being possibly incomplete.

    First data instance is called 'template' while second is 'import'. The template instance
    is the complete and full set of elements and attributes while the second is normally incomplete.

    USE CASE: load a possibly incomplete datastructure into XForms and merge it with template instance
    beforehand to allow full editing of datastructure.

    Merge behavior:
    - transforms always works along the template instance looking up updated values from the import instance
    - attribute and text values are copied to the template instance
    - for
    author: joern turner
    -->

    <xsl:template match="/*">
        <xsl:element name="{name(.)}" namespace="http://www.vraweb.org/vracore4.htm">
            <xsl:for-each select="*">
                <xsl:apply-templates select="."/>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>

    <xsl:template match="*">
        <xsl:variable name="this" select="."/>

        <xsl:if test="$debug = 'true'">
            <xsl:message>
Looking for:<xsl:value-of select="name()"/> in incoming data</xsl:message>
        </xsl:if>


        <!--
        The templateXPath is calculated here but not used yet. It however may be used to improve
        stability and allowing to check for the correct path.

        Thus keep the markup here but commented.
        -->
<!--
        <xsl:variable name="templateXPath"><xsl:call-template name="xpathExpr"/></xsl:variable>
        <xsl:message>XPath of template:<xsl:value-of select="$templateXPath"/></xsl:message>
-->

        <!-- find all elements that have the same node name in the import data -->
        <xsl:variable name="toImport" select="$importData//*[name(.)=name($this)]"/>
        <xsl:choose>
            <xsl:when test="count($toImport)!=0">
                <!-- we got nodes to import-->
                <xsl:variable name="cnt" select="count($toImport)"/>
                <xsl:for-each select="$toImport">
                    <!--
                    see above. Here the xpath for the imported nodes can be calculated.
                    A comparison of the pathes can make
                    -->
<!--
                    <xsl:variable name="importPath">
                        <xsl:call-template name="xpathExpr"/>
                    </xsl:variable>
                    <xsl:message>importPath:<xsl:value-of select="$importPath"/></xsl:message>
-->

                    <xsl:choose>
                        <xsl:when test=".=text()">
                            <xsl:copy>
                                <xsl:value-of select="text()"/>
                            </xsl:copy>
                            <xsl:if test="$debug = 'true'">
                                <xsl:message>found - copying text
                                </xsl:message>
                            </xsl:if>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:call-template name="mergeImportNode">
                                <xsl:with-param name="templateNode" select="$this"/>
                                <xsl:with-param name="importedNode" select="."/>
                            </xsl:call-template>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each>
            </xsl:when>
            <!-- using nodes from template-->
            <xsl:otherwise>
                <xsl:if test="$debug = 'true'">
                    <xsl:message>adding template nodes that do not exist in data
                    </xsl:message>
                </xsl:if>
                <xsl:copy>
                    <xsl:copy-of select="@*"/>
                    <xsl:apply-templates/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>


    <xsl:template name="mergeImportNode">
        <xsl:param name="templateNode"/>
        <xsl:param name="importedNode"/>
        <xsl:param name="textValue"/>

        <xsl:if test="$debug = 'true'">
            <xsl:message>
MERGEIMPORTNODE: copying tempLateNode: <xsl:value-of select="name($templateNode)"/></xsl:message>
        </xsl:if>

        <!--todo: namespace-->
        <xsl:element name="{name($templateNode)}">
            <xsl:if test="$debug = 'true'">
                <xsl:message>copy attributes from template and imported</xsl:message>
            </xsl:if>
            <xsl:copy-of select="$templateNode/@*"/>
            <!-- by copying the imported attributes after the template attributes the latter
            will be overwritten if already present. Therefore the attributes from imported win.-->
            <xsl:copy-of select="$importedNode/@*"/>

            <!-- if there's text value put it out.-->
            <xsl:value-of select="normalize-space(string-join($textValue,''))"/>

            <xsl:if test="$debug = 'true'">
                <xsl:message>merging child elements of <xsl:value-of select="name($templateNode)"/></xsl:message>
            </xsl:if>
            <xsl:for-each select="$templateNode/*">
                <xsl:variable name="this" select="."/>

                <xsl:variable name="currentImport" select="$importedNode/*[name(.)=name($this)]"/>
                <xsl:choose>
                    <xsl:when test="$currentImport">
                        <xsl:if test="$debug = 'true'">
                            <xsl:message>processing node: <xsl:value-of select="name(.)"/></xsl:message>
                            <xsl:message>merging text:<xsl:value-of select="$currentImport/text()"/></xsl:message>
                        </xsl:if>

                        <xsl:call-template name="mergeImportNode">
                            <xsl:with-param name="templateNode" select="$this"/>
                            <xsl:with-param name="importedNode" select="$currentImport"/>
                            <xsl:with-param name="textValue" select="$currentImport/text()"/>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:copy-of select="."/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>

    <xsl:template match="@*|text()|comment()">
        <xsl:copy>
            <xsl:apply-templates select="*|@*|text()|comment()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template name="xpathExpr">
        <xsl:variable name="cnt" select="count(preceding-sibling::node())"/>
        <xsl:for-each select="ancestor-or-self::node()">
            <xsl:variable name="cnt2" select="count(preceding-sibling::node()[name(.)=name(current())])"/>
            <xsl:if test="position() != 1">/<xsl:value-of select="name(.)"/>[<xsl:value-of select="$cnt2+1"/>]</xsl:if>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>

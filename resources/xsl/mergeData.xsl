<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:merge="http://www.betterform.de/merge" version="2.0" exclude-result-prefixes="merge">
    <xsl:output exclude-result-prefixes="merge" indent="yes"/>
    <xsl:variable name="importData" select="/merge:data/merge:importInstance/*"/>
    <xsl:variable name="debug" select="'true'"/>
    <xsl:param name="targetNS" select="'http://www.vraweb.org/vracore4.htm'"/>
    <xsl:preserve-space elements="text"/>
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


    todo: this version is newer and a refactoring attempt for merge.xsl - should be applied later on.
    -->
    <xsl:template match="/merge:data">
        <xsl:if test="not(exists($importData))">
            <xsl:message terminate="yes">No input data given</xsl:message>
        </xsl:if>
        
        
        
        <xsl:variable name="templateInstance" select="merge:templateInstance/*"/>
        <xsl:if test="$debug = 'true'">
            <xsl:message>
                Given Root Elem: <xsl:value-of select="local-name($importData)"/>
                VRA Elem: <xsl:value-of select="local-name($templateInstance)"/>
            </xsl:message>
        </xsl:if>
        
        <xsl:element name="{local-name($templateInstance)}" namespace="{$targetNS}">
            <xsl:for-each select="$templateInstance/*">
                <xsl:apply-templates select=".">
                        <xsl:with-param name="importContextNode" select="$importData"/>
                </xsl:apply-templates>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>


    <xsl:template match="*">
        <xsl:param name="importContextNode"/>

        <xsl:variable name="this" select="."/>
        <xsl:if test="$debug = 'true'">
            <xsl:message>
                Looking for: <xsl:value-of select="local-name($this)"/> in incoming data
            </xsl:message>
        </xsl:if>


        <!--
        The templateXPath is calculated here but not used yet. It however may be used to improve
        stability and allowing to check for the correct path.

        Thus keep the markup here but commented.
        -->
        
        <xsl:variable name="templateXPath"><xsl:call-template name="xpathExpr"/></xsl:variable>
        <xsl:message>XPath of template:<xsl:value-of select="$templateXPath"/></xsl:message>
        
        
    
        <xsl:variable name="toImportTemp">
            <xsl:choose>
                <xsl:when test="local-name($this) eq 'date'">
                    <xsl:choose>
                        <xsl:when test="ends-with($templateXPath, 'latestDate/date')">
                            <xsl:copy-of select="$importContextNode//*[local-name(.) = 'latestDate']/*[local-name(.) = 'date']"/>
                        </xsl:when>
                        <xsl:when test="ends-with($templateXPath, 'earliestDate/date')">
                             <xsl:copy-of select="$importContextNode//*[local-name(.) = 'earliestDate']/*[local-name(.) = 'date']"/>
                        </xsl:when>
                        <xsl:when test="ends-with($templateXPath, 'dateSet/date')">
                             <xsl:copy-of select="$importContextNode/*[local-name(.) = 'date']"/>
                        </xsl:when>
                        <xsl:otherwise>
                           <xsl:copy-of select="$importContextNode//*[local-name(.)=local-name($this)]"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                   <xsl:copy-of select="$importContextNode//*[local-name(.)=local-name($this)]"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <!-- find all elements that have the same node name in the import data -->
        
        
        <!--
        <xsl:variable name="toImport" select="$importContextNode//*[local-name(.)=local-name($this)]"/>
        -->
        <xsl:variable name="toImport" select="$toImportTemp/*"/>
    
        
        <xsl:if test="$debug = 'true'">
            <xsl:message>count $toImport: <xsl:value-of select="count($toImport)"/></xsl:message>            
        </xsl:if>
        
        <xsl:choose>
            <xsl:when test="count($toImport)!=0">
                <!-- we got nodes to import-->
                <xsl:variable name="cnt" select="count($toImport)"/>
                <xsl:for-each select="$toImport">
                    <xsl:if test="$debug = 'true'">
                        <xsl:message>TOIMPORT: <xsl:value-of select="local-name(.)"/></xsl:message>
                    </xsl:if>
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
                    <!--
                                        <xsl:if test=".=text()">
                                            <xsl:element name="{local-name(.)}" namespace="{$targetNS}">
                                                <xsl:value-of select="text()"/>
                                            </xsl:element>
                                        </xsl:if>
                    -->
                    <xsl:choose>
                        <xsl:when test=".=text()">
                            <xsl:if test="$debug = 'true'">
                                <xsl:message>
                                    found text - copying
                                </xsl:message>
                            </xsl:if>
                            <xsl:call-template name="mergeImportNode">
                                <xsl:with-param name="templateNode" select="$this"/>
                                <xsl:with-param name="importContextNode" select="."/>
                                <xsl:with-param name="textValue" select="text()"/>
                            </xsl:call-template>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:call-template name="mergeImportNode">
                                <xsl:with-param name="templateNode" select="$this"/>
                                <xsl:with-param name="importContextNode" select="."/>
                                <xsl:with-param name="textValue"/>
                            </xsl:call-template>
                        </xsl:otherwise>
                    </xsl:choose>
                    <!--
                                        <xsl:call-template name="mergeImportNode">
                                            <xsl:with-param name="templateNode" select="$this"/>
                                            <xsl:with-param name="importedNode" select="."/>
                                            <xsl:with-param name="textValue"/>
                                        </xsl:call-template>
                    -->
                </xsl:for-each>
            </xsl:when>
            <!-- using nodes from template-->
            <xsl:otherwise>
                <xsl:if test="$debug = 'true'">
                    <xsl:message>
                        adding template nodes that do not exist in data
                    </xsl:message>
                </xsl:if>
                <!--
                                <xsl:copy>
                                    <xsl:copy-of select="@*"/>
                                    <testtest/>
                                    <xsl:apply-templates/>
                                </xsl:copy>
                -->
                <xsl:element name="{local-name(.)}" namespace="{$targetNS}">
                    <xsl:apply-templates select="@*"/>
                    <xsl:apply-templates>
                        <xsl:with-param name="importContextNode" select="$toImport"/>
                    </xsl:apply-templates>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="mergeImportNode">
        <xsl:param name="templateNode"/>
        <xsl:param name="importContextNode"/>
        <xsl:param name="textValue"/>

        <xsl:if test="$debug = 'true'">
            <xsl:message>
                TEXTVALUE: |<xsl:value-of select="$textValue"/>|
                MERGEIMPORTNODE: copying tempLateNode: <xsl:value-of select="local-name($templateNode)"/>
            </xsl:message>
        </xsl:if>

        <xsl:choose>
            <xsl:when test="local-name($templateNode) eq 'alternativeNotation' and not($textValue)">
                <xsl:if test="$debug = 'true'">
                    <xsl:message>
                        skipping empty alternativeNotation
                    </xsl:message>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise> 
                 <xsl:element name="{local-name($templateNode)}" namespace="{$targetNS}">
            <xsl:if test="$debug = 'true'">
                <xsl:message>
                    copy attributes from template and imported
                </xsl:message>
            </xsl:if>
            <xsl:copy-of select="$templateNode/@*"/>
            <!-- by copying the imported attributes after the template attributes the latter
            will be overwritten if already present. Therefore the attributes from imported win.-->
            <xsl:copy-of select="$importContextNode/@*"/>

            <!-- if there's text value put it out.-->
            <xsl:choose>
                <xsl:when test="local-name($templateNode) = 'text'">
                    <xsl:value-of select="$importContextNode"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="normalize-space(string-join($textValue,''))"/>
                </xsl:otherwise>
            </xsl:choose>
            
            
            <!--
            <xsl:if test="$debug = 'true'">
                <xsl:message>merging child elements of <xsl:value-of select="local-name($templateNode)"/>
                </xsl:message>
            </xsl:if>
            -->
            <xsl:for-each select="$templateNode/*">
                <xsl:if test="$debug = 'true'">
                    <xsl:message>
                        THIS: <xsl:value-of select="local-name(.)"/>
                        IMPORTEDNODE: <xsl:value-of select="local-name($importContextNode[1])"/>
                    </xsl:message>
                </xsl:if>
                <xsl:variable name="this" select="."/>
                <xsl:variable name="currentImport" select="$importContextNode/*[local-name(.)=local-name($this)]"/>
                <xsl:choose>
                    <xsl:when test="$currentImport">
                        <xsl:for-each select="$currentImport">
                            <xsl:if test="$debug = 'true'">
                                <xsl:message>
                                    processing node: <xsl:value-of select="local-name(.)"/>
                                    merging text:<xsl:value-of select="./text()"/>
                                </xsl:message>
                            </xsl:if>
                            
                            <xsl:call-template name="mergeImportNode">
                                <xsl:with-param name="templateNode" select="$this"/>
                                <xsl:with-param name="importContextNode" select="."/>
                                <xsl:with-param name="textValue" select="./text()"/>
                            </xsl:call-template>
                        </xsl:for-each>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:element name="{local-name(.)}" namespace="{$targetNS}">
                            <xsl:apply-templates select="@*"/>
                            <xsl:apply-templates select="*">
                                <xsl:with-param name="importContextNode" select="$currentImport"/>
                            </xsl:apply-templates>
                        </xsl:element>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
        </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
        <!--todo: namespace-->
        
    </xsl:template>
    <xsl:template match="@*|text()|comment()">
        <xsl:copy>
            <xsl:apply-templates select="*|@*|text()|comment()"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template name="xpathExpr">
        <xsl:variable name="cnt" select="count(preceding-sibling::node())"/>
        <xsl:for-each select="ancestor-or-self::node()">
            <xsl:variable name="cnt2" select="count(preceding-sibling::node()[local-name(.)=local-name(current())])"/>
            <xsl:if test="position() != 1">/<xsl:value-of select="local-name(.)"/></xsl:if>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
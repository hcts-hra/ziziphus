<xsl:stylesheet version="2.0"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xf="http://www.w3.org/2002/xforms"
                xmlns:bf="http://betterform.sourceforge.net/xforms"
                xmlns:ev="http://www.w3.org/2001/xml-events"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                exclude-result-prefixes="xf bf"
                xpath-default-namespace="http://www.w3.org/1999/xhtml">
    <xsl:import href="bfResources/xslt/xhtml.xsl"/>


    <!-- todo: fix namespace of td elements -->

    <xsl:template name="addDojoImport">
        <!--
        todo: allow re-definition of dojoConfig: if a dojoConfig is present in the page use that instead of the code below.
        Or to be more precise - it should be possible to define your own package locations. Alternatively of course
        this template might be overwritten by a custom stylesheet. Which is better?
        -->
        <!-- todo: should we use explicit package locations and a baseUrl ? -->
        <!-- todo: use locale again -->
        <xsl:variable name="dojoConfig">
            has: {
            "dojo-firebug": <xsl:value-of select="$isDebugEnabled"/>,
            "dojo-debug-messages": <xsl:value-of select="$isDebugEnabled"/>
            },
            isDebug:<xsl:value-of select="$isDebugEnabled"/>,
            locale:'en',
            extraLocale: ['en'],
            baseUrl: '<xsl:value-of select="concat($contextroot,$scriptPath)"/>',

            parseOnLoad:true,
            async:false,

            packages: [
            'dojo',
            'dijit',
            'dojox',
            'bf'
            ],

            bf:{
            sessionkey: "<xsl:value-of select="$sessionKey"/>",
            contextroot:"<xsl:value-of select="$contextroot"/>",
            fluxPath:"<xsl:value-of select="concat($contextroot,'/Flux')"/>",
            useDOMFocusIN:<xsl:value-of select="$uses-DOMFocusIn"/>,
            useDOMFocusOUT:<xsl:value-of select="$uses-DOMFocusOut"/>,
            useXFSelect:<xsl:value-of select="$uses-xforms-select"/>,
            logEvents:<xsl:value-of select="$isDebugEnabled"/>,
            unloadingMessage:"<xsl:value-of select="$unloadingMessage"/>"
            }
        </xsl:variable>
        <xsl:text>
</xsl:text>
        <script type="text/javascript" src="{concat($contextroot,$scriptPath,'dojo/dojo.js')}">
            <xsl:attribute name="data-dojo-config"><xsl:value-of select="normalize-space($dojoConfig)"/></xsl:attribute>
        </script><xsl:text>
</xsl:text>
        <!--<script type="text/javascript" src="{concat($contextroot,$scriptPath,'bf/core.js')}">&#160;</script><xsl:text>-->
        <script type="text/javascript" src="{concat($contextroot,$scriptPath,'bf/bfRelease.js')}">&#160;</script><xsl:text>
</xsl:text>
        <xsl:if test="$isDebugEnabled">
            <script type="text/javascript" src="{concat($contextroot,$scriptPath,'bf/debug.js')}">&#160;</script><xsl:text>
</xsl:text>
        </xsl:if>

    </xsl:template>


    <xsl:template match="*[@xf:repeat-bind|@xf:repeat-nodeset|@repeat-bind|@repeat-nodeset]">
        <xsl:variable name="repeat-id" select="@id"/>
        <xsl:variable name="repeat-index" select="bf:data/@bf:index"/>
        <xsl:variable name="repeat-classes">
            <xsl:call-template name="assemble-compound-classes"/>
        </xsl:variable>

        <xsl:element name="{local-name(.)}" namespace="namespace-uri(.)">
            <xsl:attribute name="id"><xsl:value-of select="$repeat-id"/></xsl:attribute>
            <xsl:attribute name="jsId"><xsl:value-of select="@id"/></xsl:attribute>
            <xsl:attribute name="class">xfRepeat <xsl:value-of select="$repeat-classes"/></xsl:attribute>
            <xsl:copy-of select="@*"/>

            <xsl:if test="not(ancestor::xf:repeat)">
                <!-- generate prototype(s) for scripted environment -->
                <xsl:for-each select="bf:data/xf:group[@appearance='repeated'][1]">
                    <xsl:for-each select="*">
                        <xsl:element name="{local-name(.)}" namespace="namespace-uri(.)">
                            <xsl:attribute name="id"><xsl:value-of select="$repeat-id"/>-prototype</xsl:attribute>
                            <xsl:attribute name="class">xfRepeatPrototype xfDisabled xfReadWrite xfOptional xfValid</xsl:attribute>
                            <xsl:apply-templates select="*" />
                        </xsl:element>
                    </xsl:for-each>
                </xsl:for-each>
                <xsl:for-each select="bf:data/xf:group[@appearance='repeated']//xf:repeat">
                    <xsl:call-template name="processRepeatPrototype"/>
                </xsl:for-each>
                <xsl:for-each select="bf:data/xf:group[@appearance='repeated']//xf:itemset">
                    <xsl:call-template name="processItemsetPrototype"/>
                </xsl:for-each>
            </xsl:if>

            <xsl:for-each select="xf:group[@appearance='repeated']">
                <xsl:variable name="id" select="@id"/>

                <xsl:variable name="repeat-item-classes">
                    <xsl:call-template name="assemble-repeat-item-classes">
                        <xsl:with-param name="selected" select="$repeat-index=position()"/>
                    </xsl:call-template>
                </xsl:variable>

                <xsl:for-each select="xhtml:*">

                    <xsl:element name="{local-name(.)}" namespace="namespace-uri(.)">
                        <!--<xsl:attribute name="id"><xsl:value-of select="generate-id()"/></xsl:attribute>-->
                        <xsl:attribute name="class" select="$repeat-item-classes"/>
                        <xsl:apply-templates select="*" mode="compact-repeat"/>

                    </xsl:element>
                </xsl:for-each>

            </xsl:for-each>
        </xsl:element>
    </xsl:template>


</xsl:stylesheet>

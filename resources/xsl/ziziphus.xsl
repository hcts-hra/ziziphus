<xsl:stylesheet version="2.0"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xf="http://www.w3.org/2002/xforms"
                xmlns:bf="http://betterform.sourceforge.net/xforms"
                xmlns:ev="http://www.w3.org/2001/xml-events"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                exclude-result-prefixes="xf bf"
                xpath-default-namespace="http://www.w3.org/1999/xhtml">
    <xsl:import href="bfResources/xslt/xhtml.xsl"/>

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

</xsl:stylesheet>

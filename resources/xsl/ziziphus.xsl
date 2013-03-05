<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ev="http://www.w3.org/2001/xml-events" xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns:bf="http://betterform.sourceforge.net/xforms" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xf="http://www.w3.org/2002/xforms" version="2.0" exclude-result-prefixes="xf bf" xpath-default-namespace="http://www.w3.org/1999/xhtml">
    <xsl:import href="bfResources/xslt/xhtml.xsl"/>

    <!-- overwritten to set parseOnload=true and async=false -->
    <xsl:template name="addDojoImport">
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
            <xsl:attribute name="data-dojo-config">
                <xsl:value-of select="normalize-space($dojoConfig)"/>
            </xsl:attribute>
        </script>
        <xsl:text>
</xsl:text>
        <!--<script type="text/javascript" src="{concat($contextroot,$scriptPath,'bf/core.js')}"> </script><xsl:text>-->
        <script type="text/javascript" src="{concat($contextroot,$scriptPath,'bf/bfRelease.js')}">&#160;</script>
        <xsl:text>
</xsl:text>
        <xsl:if test="$isDebugEnabled">
            <script type="text/javascript" src="{concat($contextroot,$scriptPath,'bf/debug.js')}">&#160;</script>
            <xsl:text>
</xsl:text>
        </xsl:if>
    </xsl:template>
    <xsl:template match="body">
        <!-- todo: add 'overflow:hidden' to @style here -->
        <xsl:variable name="theme">
            <xsl:choose>
                <xsl:when test="not(exists(//body/@class)) or string-length(//body/@class) = 0">
                    <xsl:value-of select="$defaultTheme"/>
                </xsl:when>
                <xsl:when test="not(contains(//body/@class, $defaultTheme)) and                                 not(contains(//body/@class, 'tundra')) and                                 not(contains(//body/@class, 'soria'))  and                                 not(contains(//body/@class, 'claro'))  and                                 not(contains(//body/@class, 'nihilo')) and                                 not(contains(//body/@class, 'ally'))">
                    <xsl:value-of select="concat($defaultTheme, ' ', //body/@class)"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="//body/@class"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="alert">
            <xsl:choose>
                <xsl:when test="contains(@class,'ToolTipAlert')">ToolTipAlert</xsl:when>
                <xsl:otherwise>InlineAlert</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <body class="{$theme} bf {$client-device} {$alert}">
            <!-- TODO: Lars: keep original CSS classes on body-->
            <xsl:copy-of select="@*[name() != 'class']"/>
            <!-- <xsl:message>Useragent is <xsl:value-of select="$user-agent"/></xsl:message>-->
            <!--<xsl:message>Client Device: <xsl:value-of select="$client-device"/></xsl:message>-->
            <!--
            >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
            the 'bfLoading' div is used to display an animated icon during ajax activity
            <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
            -->
            <div id="bfLoading" class="disabled">
                <img id="indicator" src="{concat($contextroot,$resourcesPath,'images/indicator.gif')}" class="xfDisabled" alt="loading"/>
            </div>
            <!-- Toaster widget for ephemeral messages -->

            <!--
            >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
            The Toaster widget is used for displaying ephemeral messages at the bottom
            of the window
            <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
            -->
            <div id="betterformMessageToaster"/>


            <!--
            >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
            A noscript block displayed in case javascript is switched off
            <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
            -->
            <noscript>
                <div id="noScript">
                    Sorry, this page relies on JavaScript which is not enabled in your browser.
                </div>
            </noscript>


            <!--
            >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
            actual content of the form starts here
            >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
            -->
            <!--<div id="formWrapper" style="display:none">-->
                <!--
                >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                creates the client-side processor
                <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                -->
                <!--
                                <div    id="fluxProcessor"
                                        jsId="fluxProcessor"
                                        dojotype="bf.XFProcessor"
                                        sessionkey="{$sessionKey}"
                                        contextroot="{$contextroot}"
                                        usesDOMFocusIN="{$uses-DOMFocusIn}"
                                        dataPrefix="{$data-prefix}"
                                        logEvents="{$isDebugEnabled}">
                -->


                <!--
                >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                look for outermost UI elements (the ones having no ancestors in the xforms namespace
                <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                -->
            <xsl:variable name="outermostNodeset" select=".//xf:*[not(ancestor::*[namespace-uri()='http://www.w3.org/2002/xforms'])]                                           [not(namespace-uri()='http://www.w3.org/2002/xforms' and local-name()='model')]"/>

                <!-- detect how many outermost XForms elements we have in the body -->
            <xsl:choose>
                <xsl:when test="count($outermostNodeset) = 1">
                        <!-- match any body content and defer creation of form tag for XForms processing.
              This option allows to mix HTML forms with XForms markup. -->
                        <!-- todo: issue to revisit: this obviously does not work in case there's only one xforms control in the document. In that case the necessary form tag is not written. -->
                        <!-- hack solution: add an output that you style invisible to the form to make it work again. -->

                        <!--possible solution -->
                        <!--<xsl:when test="count($outermostNodeset)=1 and count($outermostNodeset/xf:*) != 0">-->
                    <xsl:variable name="inlineContent">
                        <xsl:apply-templates mode="inline"/>
                    </xsl:variable>
                    <xsl:choose>
                        <xsl:when test="exists($inlineContent//xf:*)">
                            <xsl:element name="form">
                                <xsl:call-template name="createFormAttributes"/>
                                <xsl:apply-templates select="*"/>
                            </xsl:element>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:copy-of select="$inlineContent"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                        <!-- in case there are multiple outermost xforms elements we are forced to create
                  the form tag for the XForms processing.-->
                    <xsl:call-template name="createForm"/>
                </xsl:otherwise>
            </xsl:choose>
            <div id="helpWindow" style="display:none"/>

                <!--
                                    <div id="bfCopyright">
                                        <xsl:text disable-output-escaping="yes">powered by betterFORM, &copy; 2011</xsl:text>
                                    </div>

                                </div>
                -->
            <!--</div>-->
            <!--
            <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
            end of form section
            <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
            -->

            <!--
            >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
            Section for the debug bar. Is displayed when debugging is switched on
            in betterform-config.xml
            <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
            -->
            <xsl:if test="$isDebugEnabled">
                <!-- z-index of 1000 so it is also in front of shim for modal dialogs -->
                <div id="evtLogContainer" style="width:26px;height:26px;overflow:hidden;">
                    <div id="logControls">
                        <a id="switchLog" href="javascript:bf.devtool.toggleLog();">&gt;</a>
                        <a id="trashLog" href="javascript:bf.devtool.clearLog();">x</a>
                    </div>
                    <ul id="eventLog"/>
                </div>
                <div id="bfDebugOpenClose">
                    <a href="javascript:bf.util.toggleDebug();">
                        <img class="debug-icon" src="{concat($contextroot,'/bfResources/images/collapse.png')}" alt=""/>
                    </a>
                </div>
                <div id="bfDebug" class="open" context="{concat($contextroot,'/inspector/',$sessionKey,'/')}">
                    <div id="bfCopyright">
                        <a href="http://www.betterform.de">
                            <img style="vertical-align:text-bottom; margin-right:5px;" src="{concat($contextroot,'/bfResources/images/betterform_icon16x16.png')}" alt="betterFORM project"/>
                        </a>
                        <span>© 2012 betterFORM</span>
                    </div>
                    <div id="bfDebugLinks">
                        <a href="{concat($contextroot,'/inspector/',$sessionKey,'/','hostDOM')}" target="_blank">Host Document</a>
                    </div>
                </div>
            </xsl:if>
            <span id="templates" style="display:none;">
                <!--
                >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                todo todo todo: section for all templates (formely 'prototypes') needed
                the idea is to keep them all in one place and have a mode 'template'
                to render them all in this place.
                >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                -->
            </span>

            <!--
            >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
            start section for script imports
            >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
            -->
            <xsl:call-template name="addDojoImport"/>
            <xsl:call-template name="addDWRImports"/>
            <xsl:call-template name="addLocalScript"/>
            <xsl:call-template name="copyInlineScript"/>
            <!--
            <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
            start section for script imports
            <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
            -->
        </body>
    </xsl:template>
    <xsl:template match="*[@xf:repeat-bind|@xf:repeat-nodeset|@repeat-bind|@repeat-nodeset]">
        <xsl:variable name="repeat-id" select="@id"/>
        <xsl:variable name="repeat-index" select="bf:data/@bf:index"/>
        <xsl:variable name="repeat-classes">
            <xsl:call-template name="assemble-compound-classes"/>
        </xsl:variable>
        <xsl:element name="{local-name(.)}" namespace="namespace-uri(.)">
            <xsl:attribute name="id">
                <xsl:value-of select="$repeat-id"/>
            </xsl:attribute>
            <xsl:attribute name="jsId">
                <xsl:value-of select="@id"/>
            </xsl:attribute>
            <xsl:attribute name="class">xfRepeat <xsl:value-of select="$repeat-classes"/>
            </xsl:attribute>
            <xsl:copy-of select="@*"/>
            <xsl:if test="not(ancestor::xf:repeat)">
                <!-- generate prototype(s) for scripted environment -->
                <xsl:for-each select="bf:data/xf:group[@appearance='repeated'][1]">
                    <xsl:for-each select="*">
                        <xsl:element name="{local-name(.)}" namespace="namespace-uri(.)">
                            <xsl:attribute name="id">
                                <xsl:value-of select="$repeat-id"/>-prototype</xsl:attribute>
                            <xsl:attribute name="class">xfRepeatPrototype xfDisabled xfReadWrite xfOptional xfValid</xsl:attribute>
                            <xsl:apply-templates select="*"/>
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
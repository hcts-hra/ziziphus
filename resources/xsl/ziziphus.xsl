<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ev="http://www.w3.org/2001/xml-events" xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:bf="http://betterform.sourceforge.net/xforms" xmlns:xf="http://www.w3.org/2002/xforms" version="2.0" exclude-result-prefixes="xf bf" xpath-default-namespace="http://www.w3.org/1999/xhtml">
    <xsl:import href="xhtml.xsl"/>

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

<!--
    <xsl:template match="xf:input|xf:secret|xf:textarea" priority="10">
        <xsl:variable name="control-classes">
            <xsl:call-template name="assemble-control-classes">
                <xsl:with-param name="appearance" select="@appearance"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="label-classes"><xsl:call-template name="assemble-label-classes"/></xsl:variable>

        <span id="{@id}" class="{$control-classes}">

            <xsl:call-template name="copy-style-attribute"/>
            <xsl:if test="@bf:incremental-delay">
                <xsl:attribute name="bf:incremental-delay" select="@bf:incremental-delay"/>
            </xsl:if>

            <xsl:if test="exists(@bf:name)">
                <xsl:attribute name="data-bf-name" select="@bf:name"/>
            </xsl:if>

            <span class="widgetContainer">
                <xsl:call-template name="z-buildControl"/>
                <xsl:apply-templates select="xf:alert"/>
                <xsl:apply-templates select="xf:hint"/>
                <xsl:apply-templates select="xf:help"/>
            </span>
            <xsl:copy-of select="script"/>
        </span>
    </xsl:template>
-->

<!--
    <xsl:template name="z-buildControl">
        <xsl:choose>
            <xsl:when test="local-name()='input'">
                <xsl:call-template name="z-input"/>
            </xsl:when>
            <xsl:when test="local-name()='output'">
                <xsl:call-template name="output"/>
            </xsl:when>
            <xsl:when test="local-name()='range'">
                <xsl:call-template name="range"/>
            </xsl:when>
            <xsl:when test="local-name()='secret'">
                <xsl:call-template name="secret"/>
            </xsl:when>
            <xsl:when test="local-name()='select'">
                <xsl:call-template name="select"/>
            </xsl:when>
            <xsl:when test="local-name()='select1'">
                <xsl:call-template name="select1"/>
            </xsl:when>
            <xsl:when test="local-name()='submit'">
                <xsl:call-template name="trigger"/>

            </xsl:when>
            <xsl:when test="local-name()='trigger'">
                <xsl:call-template name="trigger"/>
            </xsl:when>
            <xsl:when test="local-name()='textarea'">
                <xsl:call-template name="textarea"/>
            </xsl:when>
            <xsl:when test="local-name()='upload'">
            </xsl:when>
        </xsl:choose>
    </xsl:template>
-->

<!--
    <xsl:template name="z-input">
        <xsl:variable name="id" select="@id"/>
        <xsl:variable name="name" select="concat($data-prefix,$id)"/>
        <xsl:variable name="navindex" select="if (exists(@navindex)) then @navindex else '0'"/>
        <xsl:variable name="type"><xsl:call-template name="getType"/></xsl:variable>

        <xsl:variable name="authorClasses">
            <xsl:call-template name="get-control-classes"/>
        </xsl:variable>
        <xsl:variable name="widgetClasses" select="normalize-space(concat($widgetClass,' ',$authorClasses))"/>
        <xsl:choose>
            <xsl:when test="$type='boolean'">
                <input  id="{$id}-value"
                        name="{$name}"
                        type="checkbox"
                        class="{$widgetClasses}"
                        tabindex="{$navindex}"
                        title="{xf:label/text()}">
                    <xsl:if test="bf:data/@bf:readonly='true'">
                        <xsl:attribute name="disabled">disabled</xsl:attribute>
                    </xsl:if>
                    <xsl:if test="bf:data/text()='true'">
                        <xsl:attribute name="checked">true</xsl:attribute>
                    </xsl:if>
                    <xsl:apply-templates select="xf:hint"/>
                </input>
            </xsl:when>
            <xsl:when test="$type='date' or $type='dateTime' or $type='time'">
                <xsl:call-template name="InputDateAndTime">
                    <xsl:with-param name="id" select="$id"/>
                    <xsl:with-param name="name" select="$name"/>
                    <xsl:with-param name="type" select="$type"/>
                    <xsl:with-param name="navindex" select="$navindex"/>
                    <xsl:with-param name="classes" select="$widgetClasses"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="z-InputDefault">
                    <xsl:with-param name="id" select="$id"/>
                    <xsl:with-param name="name" select="$name"/>
                    <xsl:with-param name="navindex" select="$navindex"/>
                    <xsl:with-param name="classes" select="$widgetClasses"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
-->

<!--
    <xsl:template name="z-InputDefault">
        <xsl:param name="id"/>
        <xsl:param name="name"/>
        <xsl:param name="navindex"/>
        <xsl:param name="classes"/>
        <input id="{$id}-value"
                name="{$name}"
                type="text"
                class="{$classes}"
                tabindex="{$navindex}"
                placeholder="{xf:label}"
                value="{bf:data/text()}"
                title="{xf:label}">
            <xsl:if test="bf:data/@bf:readonly='true'">
                <xsl:attribute name="disabled">disabled</xsl:attribute>
            </xsl:if>
            <xsl:for-each select="@*[not(local-name(.) = 'ref' or local-name(.) = 'style' or local-name(.) = 'id' or local-name(.) = 'class' or local-name(.) = 'placeholder')]">
                <xsl:copy/>
            </xsl:for-each>
        </input>
    </xsl:template>
-->

</xsl:stylesheet>
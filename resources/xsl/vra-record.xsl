<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ev="http://www.w3.org/2001/xml-events" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:vra="http://www.vraweb.org/vracore4.htm" xmlns:xf="http://www.w3.org/2002/xforms" xmlns:bfn="http://www.betterform.de/XSL/Functions" version="2.0" xpath-default-namespace="http://www.w3.org/2002/xforms" exclude-result-prefixes="bfn">
    <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>
    <xsl:strip-space elements="*"/>

    <!--
        VIEW GENERATION - includes embed actions for switching to forms
    -->


    <!-- include transforms for sections in VRA dataset -->
    <xsl:include href="vraSets/AgentSet.xsl"/>
    <xsl:include href="vraSets/CulturalContextSet.xsl"/>
    <xsl:include href="vraSets/DateSet.xsl"/>
    <xsl:include href="vraSets/DescriptionSet.xsl"/>
    <xsl:include href="vraSets/InscriptionSet.xsl"/>
    <xsl:include href="vraSets/LocationSet.xsl"/>
    <xsl:include href="vraSets/MaterialSet.xsl"/>
    <xsl:include href="vraSets/MeasurementsSet.xsl"/>
    <xsl:include href="vraSets/RelationSet.xsl"/>
    <xsl:include href="vraSets/RightsSet.xsl"/>
    <xsl:include href="vraSets/SourceSet.xsl"/>
    <xsl:include href="vraSets/StateEditionSet.xsl"/>
    <xsl:include href="vraSets/StylePeriodSet.xsl"/>
    <xsl:include href="vraSets/SubjectSet.xsl"/>
    <xsl:include href="vraSets/TechniqueSet.xsl"/>
    <xsl:include href="vraSets/TextrefSet.xsl"/>
    <xsl:include href="vraSets/TitleSet.xsl"/>
    <xsl:include href="vraSets/WorktypeSet.xsl"/>
    <xsl:param name="type" select="'GIVEN BY CALLER'"/>
    <xsl:param name="recordId" select="'GIVEN BY CALLER'"/>
    <xsl:variable name="root_id" select="if($type='work') then 'workrecord' else 'imagerecord'"/>
    <xsl:variable name="region" select="if($type='work') then 'leading' else 'trailing'"/>
    <xsl:variable name="title" select="if($type='work') then 'Work Record' else 'Image Record'"/>
    <xsl:variable name="id_pref" select="if($type='work') then 'w_' else 'i_'"/>

    <!-- top level - entry template - handles a work or an image record -->
    <xsl:template match="/vra:work |/vra:image">
        <td class="sidePanel">
            <div class="panel">
                <div class="columntitle">
                    <xsl:value-of select="$title"/>
                </div>
                <!--<xsl:apply-templates mode="titlePane"/>-->
                <xsl:call-template name="titlePane">
                    <xsl:with-param name="vraSetName" select="'AgentSet'"/>
                    <xsl:with-param name="vraSetNode" select="vra:agentSet"/>
                </xsl:call-template>
                <xsl:call-template name="titlePane">
                    <xsl:with-param name="vraSetName" select="'CulturalContextSet'"/>
                    <xsl:with-param name="vraSetNode" select="vra:culturalContextSet"/>
                </xsl:call-template>
                <xsl:call-template name="titlePane">
                    <xsl:with-param name="vraSetName" select="'DateSet'"/>
                    <xsl:with-param name="vraSetNode" select="vra:dateSet"/>
                </xsl:call-template>
                <xsl:call-template name="titlePane">
                    <xsl:with-param name="vraSetName" select="'DescriptionSet'"/>
                    <xsl:with-param name="vraSetNode" select="vra:descriptionSet"/>
                </xsl:call-template>
                <xsl:call-template name="titlePane">
                    <xsl:with-param name="vraSetName" select="'InscriptionSet'"/>
                    <xsl:with-param name="vraSetNode" select="vra:inscriptionSet"/>
                </xsl:call-template>
                <xsl:call-template name="titlePane">
                    <xsl:with-param name="vraSetName" select="'LocationSet'"/>
                    <xsl:with-param name="vraSetNode" select="vra:locationSet"/>
                </xsl:call-template>
                <xsl:call-template name="titlePane">
                    <xsl:with-param name="vraSetName" select="'MaterialSet'"/>
                    <xsl:with-param name="vraSetNode" select="vra:materialSet"/>
                </xsl:call-template>
                <xsl:call-template name="titlePane">
                    <xsl:with-param name="vraSetName" select="'MeasurementsSet'"/>
                    <xsl:with-param name="vraSetNode" select="vra:measurementsSet"/>
                </xsl:call-template>
                <xsl:call-template name="titlePane">
                    <xsl:with-param name="vraSetName" select="'RelationSet'"/>
                    <xsl:with-param name="vraSetNode" select="vra:relationSet"/>
                </xsl:call-template>
                <xsl:call-template name="titlePane">
                    <xsl:with-param name="vraSetName" select="'RightsSet'"/>
                    <xsl:with-param name="vraSetNode" select="vra:rightsSet"/>
                </xsl:call-template>
                <xsl:call-template name="titlePane">
                    <xsl:with-param name="vraSetName" select="'SourceSet'"/>
                    <xsl:with-param name="vraSetNode" select="vra:sourceSet"/>
                </xsl:call-template>
                <xsl:call-template name="titlePane">
                    <xsl:with-param name="vraSetName" select="'StateEditionSet'"/>
                    <xsl:with-param name="vraSetNode" select="vra:stateEditionSet"/>
                </xsl:call-template>
                <xsl:call-template name="titlePane">
                    <xsl:with-param name="vraSetName" select="'StylePeriodSet'"/>
                    <xsl:with-param name="vraSetNode" select="vra:stylePeriodSet"/>
                </xsl:call-template>
                <xsl:call-template name="titlePane">
                    <xsl:with-param name="vraSetName" select="'SubjectSet'"/>
                    <xsl:with-param name="vraSetNode" select="vra:subjectSet"/>
                </xsl:call-template>
                <xsl:call-template name="titlePane">
                    <xsl:with-param name="vraSetName" select="'TechniqueSet'"/>
                    <xsl:with-param name="vraSetNode" select="vra:techniqueSet"/>
                </xsl:call-template>
                <xsl:call-template name="titlePane">
                    <xsl:with-param name="vraSetName" select="'TextrefSet'"/>
                    <xsl:with-param name="vraSetNode" select="vra:textrefSet"/>
                </xsl:call-template>
                <xsl:call-template name="titlePane">
                    <xsl:with-param name="vraSetName" select="'TitleSet'"/>
                    <xsl:with-param name="vraSetNode" select="vra:titleSet"/>
                </xsl:call-template>
                <xsl:call-template name="titlePane">
                    <xsl:with-param name="vraSetName" select="'WorktypeSet'"/>
                    <xsl:with-param name="vraSetNode" select="vra:worktypeSet"/>
                </xsl:call-template>
            </div>
        </td>
    </xsl:template>
    <xsl:template match="vra:work/vra:image" mode="titlePane" priority="40"/>

    <!--
        single section - expandable section in view. Uses a XForms switch to toggle between VIEW and EDIT mode
    -->
    <xsl:template name="titlePane">
        <xsl:param name="vraSetName"/>
        <xsl:param name="vraSetNode" as="node()?"/>
        <xsl:variable name="title" select="bfn:sectionTitle($vraSetName)"/>
        <xsl:variable name="id" select="concat($id_pref,$title)"/>
        <!--<xsl:variable name="formName" select="$vraSetName"/>-->
        <div id="{$id}" data-dojo-type="dijit.TitlePane" data-dojo-props="title: '{$title}',open:true">
            <xsl:variable name="mountPoint" select="concat($id,'_MountPoint')"/>
            <xsl:variable name="caseId" select="concat('c-',$id)"/>
            <xsl:variable name="tableId" select="concat('table-',$id)"/>
            <xf:switch>
                <!-- VIEW CASE -->
                <xf:case id="{$caseId}-view" selected="true">
                    <div class="t-edit">
                        <xf:trigger class="-icon-edit">
                            <xf:label/>
                            <xf:action>
                                <!--                        <xf:message><xsl:value-of select="$type"/></xf:message>-->
                                <xf:setvariable name="record" select="'{$type}'"/>
                                <xf:setvariable name="recordId" select="'{$recordId}'"/>
                                <xf:load show="embed" targetid="{$mountPoint}">
                                    <xf:resource value="'forms/{$vraSetName}.xhtml#xforms'"/>
                                    <xf:extension includeCSS="false" includeScript="false"/>
                                </xf:load>
                                <xf:toggle case="{$caseId}-edit"/>
                                <xf:dispatch name="unload-subform" targetid="controlCenter"/>
                                <xf:setvalue model="model-1" ref="instance('i-control-center')/currentform" value="'{$id}'"/>
                            </xf:action>
                        </xf:trigger>
                        <button type="button" onclick="toggleDetail(this, '{$tableId}');" class="icon-zoom-in"/>
                    </div>
                    <div class="vraSection" id="{concat($id,'_HtmlContent')}">
                        <div class="simpleView" id="{$tableId}">
                            <xsl:choose>
                                <xsl:when test="$vraSetNode/vra:display">
                                    <xsl:apply-templates select="$vraSetNode/vra:display"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <!-- drill down into single stylesheets (the ones include at top of this file.-->
                                    <xsl:apply-templates select="$vraSetNode"/>
                                </xsl:otherwise>
                            </xsl:choose>

                            <xsl:apply-templates select="$vraSetNode/vra:notes"/>
                        </div>
                    </div>
                </xf:case>
                <!-- EDIT CASE -->
                <xf:case id="{$caseId}-edit">
                    <xf:trigger class="-icon-remove">
                        <xf:label/>
                        <xf:action>
                            <xf:toggle case="{$caseId}-view"/>
                            <xf:setvalue ref="instance('i-control-center')/currentform" value="''" model="model-1"/>
                        </xf:action>
                    </xf:trigger>
                    <div id="{$mountPoint}"/>
                </xf:case>
            </xf:switch>
        </div>
    </xsl:template>

    <!--    <xsl:template match="*[exists(*)]"  priority="20">
            <xsl:variable name="nodeName" select="local-name(.)"/>
            <div class="{$nodeName}">
                <div class="{$nodeName}Label complexLabel">
                    <xsl:value-of select="bfn:upperCase($nodeName)"/>:</div>
                <div class="attrEntry">
                    <xsl:apply-templates select="@*" />
                </div>
                <xsl:apply-templates select="*" />
            </div>
        </xsl:template>
    -->
    <xsl:template match="*[not(exists(*))]" priority="10">
        <xsl:choose>
            <xsl:when test="string-length(.) gt 0">
                <xsl:variable name="nodeName" select="local-name(.)"/>
                <div class="nodeEntry">
                    <span class="{$nodeName}Label simpleLabel">
                        <xsl:value-of select="bfn:upperCase($nodeName)"/>:</span>
                    <span class="{$nodeName}Value simpleValue">
                        <xsl:value-of select="normalize-space(.)"/>
                    </span>
                    <div class="attrEntry">
                        <xsl:apply-templates select="@*"/>
                    </div>
                </div>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="@*">
        <xsl:choose>
            <xsl:when test="string-length(.) gt 0">
                <xsl:variable name="attrName" select="local-name(.)"/>
                <span class="{$attrName}Label attrLabel">
                    <xsl:value-of select="$attrName"/>:</span>
                <span class="{$attrName}Value attrValue">
                    <xsl:value-of select="normalize-space(.)"/>
                </span>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="*"/>
    <xsl:template match="@*|text()" priority="5"/>
    <xsl:template match="comment()" priority="5"/>
    <xsl:function name="bfn:sectionTitle" as="xsd:string?">
        <xsl:param name="arg" as="xsd:string?"/>
        <xsl:sequence select="substring-before(bfn:upperCase($arg),'Set')"/>
    </xsl:function>
    <xsl:function name="bfn:upperCase" as="xsd:string?">
        <xsl:param name="arg" as="xsd:string?"/>
        <xsl:sequence select="concat(upper-case(substring($arg,1,1)),substring($arg,2))"/>
    </xsl:function>

    <xsl:template name="renderVraAttr">
        <xsl:param name="attrName"/>
        <xsl:param name="mode">inline</xsl:param>
        <xsl:param name="ifAbsent"/>

        <xsl:choose>
            <xsl:when test="@*[name()=$attrName]">
                <xsl:choose>
                    <xsl:when test="'inline'=$mode">
                        <span class="vraAttr"><span class="vraAttrName"><xsl:value-of select="$attrName"/></span><span class="vraAttrValue"><xsl:value-of select="@*[name()=$attrName]"/></span></span>
                    </xsl:when>
                    <xsl:when test="'simple'=$mode">
                        <xsl:value-of select="@*[name()=$attrName]"/>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$ifAbsent"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="vra:display" priority="40">
        <xsl:if test="text()">
            <div class="display-container"><xsl:value-of select="text()"/></div>
        </xsl:if>
    </xsl:template>

    <xsl:template match="vra:notes" priority="40">
        <xsl:if test="text()">
            <div class="notes-container"><span class="notes"><xsl:value-of select="text()"/></span></div>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>

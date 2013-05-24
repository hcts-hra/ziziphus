<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:vra="http://www.vraweb.org/vracore4.htm"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:bfn="http://www.betterform.de/XSL/Functions"
                version="2.0">
   <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes"
               omit-xml-declaration="no"></xsl:output>
   <xsl:template match="/vra:work |/vra:image">
      <xsl:variable name="side"
                    select="if(local-name(.)='work') then 'leftPanel' else 'rightPanel'"></xsl:variable>
      <div class="columntitle">
         <xsl:value-of select="$title"></xsl:value-of>
         <xsl:text> </xsl:text><button type="button" id="{$recordType}-versions-button" subject="{$recordId}"
                 title="Versions history for {$recordType} {$recordId}">H</button></div>
      <div id="{$side}" class="sidePanel ui-layout-content">
         <xsl:call-template name="titlePane">
            <xsl:with-param name="vraSetName" select="'AgentSet'"></xsl:with-param>
            <xsl:with-param name="vraSetNode" select="vra:agentSet"></xsl:with-param>
            <xsl:with-param name="visible" select="''"></xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="titlePane">
            <xsl:with-param name="vraSetName" select="'DateSet'"></xsl:with-param>
            <xsl:with-param name="vraSetNode" select="vra:dateSet"></xsl:with-param>
            <xsl:with-param name="visible" select="''"></xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="titlePane">
            <xsl:with-param name="vraSetName" select="'DescriptionSet'"></xsl:with-param>
            <xsl:with-param name="vraSetNode" select="vra:descriptionSet"></xsl:with-param>
            <xsl:with-param name="visible" select="''"></xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="titlePane">
            <xsl:with-param name="vraSetName" select="'LocationSet'"></xsl:with-param>
            <xsl:with-param name="vraSetNode" select="vra:locationSet"></xsl:with-param>
            <xsl:with-param name="visible" select="''"></xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="titlePane">
            <xsl:with-param name="vraSetName" select="'RightsSet'"></xsl:with-param>
            <xsl:with-param name="vraSetNode" select="vra:rightsSet"></xsl:with-param>
            <xsl:with-param name="visible" select="''"></xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="titlePane">
            <xsl:with-param name="vraSetName" select="'SubjectSet'"></xsl:with-param>
            <xsl:with-param name="vraSetNode" select="vra:subjectSet"></xsl:with-param>
            <xsl:with-param name="visible" select="''"></xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="titlePane">
            <xsl:with-param name="vraSetName" select="'TitleSet'"></xsl:with-param>
            <xsl:with-param name="vraSetNode" select="vra:titleSet"></xsl:with-param>
            <xsl:with-param name="visible" select="''"></xsl:with-param>
         </xsl:call-template>
         <div class="separator">Further VRA Sets</div>
         <xsl:call-template name="titlePane">
            <xsl:with-param name="vraSetName" select="'CulturalContextSet'"></xsl:with-param>
            <xsl:with-param name="vraSetNode" select="vra:culturalContextSet"></xsl:with-param>
            <xsl:with-param name="visible" select="'false'"></xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="titlePane">
            <xsl:with-param name="vraSetName" select="'InscriptionSet'"></xsl:with-param>
            <xsl:with-param name="vraSetNode" select="vra:inscriptionSet"></xsl:with-param>
            <xsl:with-param name="visible" select="'false'"></xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="titlePane">
            <xsl:with-param name="vraSetName" select="'MaterialSet'"></xsl:with-param>
            <xsl:with-param name="vraSetNode" select="vra:materialSet"></xsl:with-param>
            <xsl:with-param name="visible" select="'false'"></xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="titlePane">
            <xsl:with-param name="vraSetName" select="'MeasurementsSet'"></xsl:with-param>
            <xsl:with-param name="vraSetNode" select="vra:measurementsSet"></xsl:with-param>
            <xsl:with-param name="visible" select="'false'"></xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="titlePane">
            <xsl:with-param name="vraSetName" select="'RelationSet'"></xsl:with-param>
            <xsl:with-param name="vraSetNode" select="vra:relationSet"></xsl:with-param>
            <xsl:with-param name="visible" select="'false'"></xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="titlePane">
            <xsl:with-param name="vraSetName" select="'SourceSet'"></xsl:with-param>
            <xsl:with-param name="vraSetNode" select="vra:sourceSet"></xsl:with-param>
            <xsl:with-param name="visible" select="'false'"></xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="titlePane">
            <xsl:with-param name="vraSetName" select="'StateEditionSet'"></xsl:with-param>
            <xsl:with-param name="vraSetNode" select="vra:stateEditionSet"></xsl:with-param>
            <xsl:with-param name="visible" select="'false'"></xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="titlePane">
            <xsl:with-param name="vraSetName" select="'StylePeriodSet'"></xsl:with-param>
            <xsl:with-param name="vraSetNode" select="vra:stylePeriodSet"></xsl:with-param>
            <xsl:with-param name="visible" select="'false'"></xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="titlePane">
            <xsl:with-param name="vraSetName" select="'TechniqueSet'"></xsl:with-param>
            <xsl:with-param name="vraSetNode" select="vra:techniqueSet"></xsl:with-param>
            <xsl:with-param name="visible" select="'false'"></xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="titlePane">
            <xsl:with-param name="vraSetName" select="'TextrefSet'"></xsl:with-param>
            <xsl:with-param name="vraSetNode" select="vra:textrefSet"></xsl:with-param>
            <xsl:with-param name="visible" select="'false'"></xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="titlePane">
            <xsl:with-param name="vraSetName" select="'WorktypeSet'"></xsl:with-param>
            <xsl:with-param name="vraSetNode" select="vra:worktypeSet"></xsl:with-param>
            <xsl:with-param name="visible" select="'false'"></xsl:with-param>
         </xsl:call-template>
      </div>
   </xsl:template>
</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:vra="http://www.vraweb.org/vracore4.htm"
                version="2.0">
   <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes"
               omit-xml-declaration="no"></xsl:output>
   <xsl:preserve-space elements="vra:text"></xsl:preserve-space>
   <xsl:template match="vra:rightsSet">
      <xsl:param name="vraTableId"></xsl:param>
      <div class="simple" id="{$vraTableId}">
         <table class="vraSetView table table-striped">
            <tbody>
               <xsl:for-each select="vra:rights">
                  <tr>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(@type,'')) != 0">
                              <div class="  keepWhitespace" data-bf-type="select1" data-bf-bind="@type"
                                   tabindex="0"
                                   title="Type"
                                   id="b-d2e1173">
                                 <xsl:value-of select="@type"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata keepWhitespace" data-bf-type="select1" data-bf-bind="@type"
                                   tabindex="0">(Type)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:rightsHolder,'')) != 0">
                              <div class="keepWhitespace" data-bf-type="input" data-bf-bind="vra:rightsHolder"
                                   tabindex="0"
                                   title="RightsHolder"
                                   id="b-d2e1117">
                                 <xsl:value-of select="vra:rightsHolder"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata keepWhitespace" data-bf-type="input"
                                   data-bf-bind="vra:rightsHolder"
                                   tabindex="0">(RightsHolder)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:text,'')) != 0">
                              <div class="textarea keepWhitespace" data-bf-type="textarea" data-bf-bind="vra:text"
                                   tabindex="0"
                                   title="Text"
                                   id="b-d2e1138">
                                 <xsl:if xmlns="" test="string-length(vra:text) &gt; 100">
                                    <xsl:attribute name="data-expand">100%</xsl:attribute>
                                    <xsl:attribute name="data-collapse">150px</xsl:attribute>
                                 </xsl:if>
                                 <xsl:value-of select="vra:text"></xsl:value-of>
                              </div>
                              <xsl:if xmlns="" test="string-length(vra:text) &gt; 100">
                                 <p class="expand">
                                    <i class="fa fa-arrow-down"></i> Click to Read More 
                                    <i class="fa fa-arrow-down"></i>
                                 </p>
                                 <p class="contract hide">
                                    <i class="fa fa-arrow-up"></i> Click to Hide 
                                    <i class="fa fa-arrow-up"></i>
                                 </p>
                              </xsl:if>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="textarea nodata keepWhitespace" data-bf-type="textarea"
                                   data-bf-bind="vra:text"
                                   tabindex="0">
                                 <xsl:if xmlns="" test="string-length(vra:text) &gt; 100">
                                    <xsl:attribute name="data-expand">100%</xsl:attribute>
                                    <xsl:attribute name="data-collapse">150px</xsl:attribute>
                                 </xsl:if>(Text)
                              </div>
                              <xsl:if xmlns="" test="string-length(vra:text) &gt; 100">
                                 <p class="expand">
                                    <i class="fa fa-arrow-down"></i> Click to Read More 
                                    <i class="fa fa-arrow-down"></i>
                                 </p>
                                 <p class="contract hide">
                                    <i class="fa fa-arrow-up"></i> Click to Hide 
                                    <i class="fa fa-arrow-up"></i>
                                 </p>
                              </xsl:if>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                  </tr>
               </xsl:for-each>
            </tbody>
         </table>
      </div>
   </xsl:template>
</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:vra="http://www.vraweb.org/vracore4.htm"
                version="2.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xhtml" omit-xml-declaration="no"
               version="1.0"></xsl:output>
   <xsl:strip-space elements="*"></xsl:strip-space>
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
                              <div class="  keepWhitespace" data-bf-bind="@type" data-bf-type="select1"
                                   tabindex="0"
                                   title=""
                                   id="b-d2e1173">
                                 <xsl:value-of select="@type"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata keepWhitespace" data-bf-bind="@type" data-bf-type="select1"
                                   tabindex="0">
                                 <xsl:value-of select="normalize-space(concat('(', $language-files/language/rightsSet/rights/type/label, ')'))"></xsl:value-of>
                              </div>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:rightsHolder,'')) != 0">
                              <div class="keepWhitespace" data-bf-bind="vra:rightsHolder" data-bf-type="input"
                                   tabindex="0"
                                   title=""
                                   id="b-d2e1117">
                                 <xsl:value-of select="vra:rightsHolder"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata keepWhitespace" data-bf-bind="vra:rightsHolder"
                                   data-bf-type="input"
                                   tabindex="0">
                                 <xsl:value-of select="normalize-space(concat('(', $language-files/language/rightsSet/rights/rightsHolder/label, ')'))"></xsl:value-of>
                              </div>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:text,'')) != 0">
                              <div class="textarea keepWhitespace" data-bf-bind="vra:text" data-bf-type="textarea"
                                   tabindex="0"
                                   title=""
                                   id="b-d2e1138">
                                 <xsl:if xmlns=""
                                         test="string-length() - string-length(translate(vra:text, '&#xA;', '')) &gt; 5">
                                    <xsl:attribute name="data-expand">100%</xsl:attribute>
                                    <xsl:attribute name="data-collapse">75px</xsl:attribute>
                                 </xsl:if>
                                 <xsl:value-of select="vra:text"></xsl:value-of>
                              </div>
                              <xsl:if xmlns=""
                                      test="string-length() - string-length(translate(vra:text, '&#xA;', '')) &gt; 5">
                                 <div class="expand">
                                    <span class="fa fa-arrow-down"></span>
                                    <span>Click to Read More</span>
                                    <span class="fa fa-arrow-down"></span>
                                 </div>
                                 <div class="contract hide">
                                    <span class="fa fa-arrow-up"></span>
                                    <span>Click to Hide</span>
                                    <span class="fa fa-arrow-up"></span>
                                 </div>
                              </xsl:if>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="textarea nodata keepWhitespace" data-bf-bind="vra:text"
                                   data-bf-type="textarea"
                                   tabindex="0">
                                 <xsl:if xmlns=""
                                         test="string-length() - string-length(translate(vra:text, '&#xA;', '')) &gt; 5">
                                    <xsl:attribute name="data-expand">100%</xsl:attribute>
                                    <xsl:attribute name="data-collapse">75px</xsl:attribute>
                                 </xsl:if>
                                 <xsl:value-of select="normalize-space(concat('(', $language-files/language/rightsSet/rights/text/label, ')'))"></xsl:value-of>
                              </div>
                              <xsl:if xmlns=""
                                      test="string-length() - string-length(translate(vra:text, '&#xA;', '')) &gt; 5">
                                 <div class="expand">
                                    <span class="fa fa-arrow-down"></span>
                                    <span>Click to Read More</span>
                                    <span class="fa fa-arrow-down"></span>
                                 </div>
                                 <div class="contract hide">
                                    <span class="fa fa-arrow-up"></span>
                                    <span>Click to Hide</span>
                                    <span class="fa fa-arrow-up"></span>
                                 </div>
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
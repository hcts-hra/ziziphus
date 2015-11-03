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
                              <div data-bf-bind="@type" data-bf-type="select1" tabindex="0" title="" id="b-d2e753"
                                   class=" ">
                                 <xsl:value-of select="@type"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-bind="@type" data-bf-type="select1" tabindex="0">
                                 <xsl:value-of select="normalize-space(concat('(', $language-files/language/rightsSet/rights/type/label, ')'))"></xsl:value-of>
                              </div>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:rightsHolder,'')) != 0">
                              <div data-bf-bind="vra:rightsHolder" data-bf-type="input" tabindex="0" title=""
                                   id="b-d2e711">
                                 <xsl:value-of select="vra:rightsHolder"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-bind="vra:rightsHolder" data-bf-type="input"
                                   tabindex="0">
                                 <xsl:value-of select="normalize-space(concat('(', $language-files/language/rightsSet/rights/rightsHolder/label, ')'))"></xsl:value-of>
                              </div>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:text,'')) != 0">
                              <div data-bf-bind="vra:text" data-bf-type="input" tabindex="0" title=""
                                   id="b-d2e727">
                                 <xsl:value-of select="vra:text"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-bind="vra:text" data-bf-type="input" tabindex="0">
                                 <xsl:value-of select="normalize-space(concat('(', $language-files/language/rightsSet/rights/text/label, ')'))"></xsl:value-of>
                              </div>
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
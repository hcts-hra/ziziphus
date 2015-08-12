<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:vra="http://www.vraweb.org/vracore4.htm"
                version="2.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xhtml" omit-xml-declaration="no"
               version="1.0"></xsl:output>
   <xsl:strip-space elements="*"></xsl:strip-space>
   <xsl:preserve-space elements="vra:text"></xsl:preserve-space>
   <xsl:template match="vra:dateSet">
      <xsl:param name="vraTableId"></xsl:param>
      <div class="simple" id="{$vraTableId}">
         <table class="vraSetView table table-striped">
            <tbody xmlns="">
               <tr>
                  <td>Type of Date</td>
                  <td>Earliest Date</td>
                  <td>Latest Date</td>
               </tr>
               <xsl:for-each select="vra:date">
                  <tr>
                     <td xmlns="http://www.w3.org/1999/xhtml">
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(@type,'')) != 0">
                              <div data-bf-bind="@type" data-bf-type="select1" tabindex="0" title="" id="b-d2e265"
                                   class=" ">
                                 <xsl:value-of select="@type"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-bind="@type" data-bf-type="select1" tabindex="0">
                                 <xsl:value-of select="normalize-space(concat('(', $language-files/language/dateSet/date/type/label, ')'))"></xsl:value-of>
                              </div>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                     <td>
                        <table class="table viewDateTable">
                           <tbody>
                              <tr>
                                 <td></td>
                                 <td>
                                    <xsl:choose xmlns="http://www.w3.org/1999/xhtml">
                                       <xsl:when test="string-length(string-join(vra:earliestDate,'')) != 0">
                                          <div data-bf-bind="vra:earliestDate" data-bf-type="input" tabindex="0" title=""
                                               id="b-d2e249">
                                             <xsl:value-of select="vra:earliestDate"></xsl:value-of>
                                          </div>
                                       </xsl:when>
                                       <xsl:otherwise>
                                          <div class="nodata" data-bf-bind="vra:earliestDate" data-bf-type="input"
                                               tabindex="0">
                                             <xsl:value-of select="normalize-space(concat('(', $language-files/language/dateSet/date/earliestDate/label, ')'))"></xsl:value-of>
                                          </div>
                                       </xsl:otherwise>
                                    </xsl:choose>
                                 </td>
                              </tr>
                           </tbody>
                        </table>
                     </td>
                     <td class="viewDateTable">
                        <table class="table viewDateTable">
                           <tbody>
                              <tr>
                                 <td></td>
                                 <td>
                                    <xsl:choose xmlns="http://www.w3.org/1999/xhtml">
                                       <xsl:when test="string-length(string-join(vra:latestDate,'')) != 0">
                                          <div data-bf-bind="vra:latestDate" data-bf-type="input" tabindex="0" title=""
                                               id="b-d2e257">
                                             <xsl:value-of select="vra:latestDate"></xsl:value-of>
                                          </div>
                                       </xsl:when>
                                       <xsl:otherwise>
                                          <div class="nodata" data-bf-bind="vra:latestDate" data-bf-type="input" tabindex="0">
                                             <xsl:value-of select="normalize-space(concat('(', $language-files/language/dateSet/date/latestDate/label, ')'))"></xsl:value-of>
                                          </div>
                                       </xsl:otherwise>
                                    </xsl:choose>
                                 </td>
                              </tr>
                           </tbody>
                        </table>
                     </td>
                  </tr>
               </xsl:for-each>
            </tbody>
         </table>
      </div>
   </xsl:template>
</xsl:stylesheet>
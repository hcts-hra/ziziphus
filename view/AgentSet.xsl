<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:vra="http://www.vraweb.org/vracore4.htm"
                version="2.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xhtml" omit-xml-declaration="no"
               version="1.0"></xsl:output>
   <xsl:strip-space elements="*"></xsl:strip-space>
   <xsl:preserve-space elements="vra:text"></xsl:preserve-space>
   <xsl:template match="vra:agentSet">
      <xsl:param name="vraTableId"></xsl:param>
      <div class="simple" id="{$vraTableId}">
         <table class="vraSetView table table-striped">
            <tbody>
               <xsl:for-each select="vra:agent">
                  <tr>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:attribution,'')) != 0">
                              <div data-bf-bind="vra:attribution" data-bf-type="input" tabindex="0" title=""
                                   id="b-d2e63">
                                 <xsl:value-of select="vra:attribution"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-bind="vra:attribution" data-bf-type="input" tabindex="0">
                                 <xsl:value-of select="normalize-space(concat('(', $language-files/language/agentSet/agent/attribution/label, ')'))"></xsl:value-of>
                              </div>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:culture,'')) != 0">
                              <div data-bf-bind="vra:culture" data-bf-type="input" tabindex="0" title=""
                                   id="b-d2e79">
                                 <xsl:value-of select="vra:culture"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-bind="vra:culture" data-bf-type="input" tabindex="0">
                                 <xsl:value-of select="normalize-space(concat('(', $language-files/language/agentSet/agent/culture/label, ')'))"></xsl:value-of>
                              </div>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:dates/@type,'')) != 0">
                              <div data-bf-bind="vra:dates/@type" data-bf-type="select1" tabindex="0" title=""
                                   id="b-d2e114"
                                   class=" datesType">
                                 <xsl:value-of select="vra:dates/@type"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-bind="vra:dates/@type" data-bf-type="select1"
                                   tabindex="0">
                                 <xsl:value-of select="normalize-space(concat('(', $language-files/language/agentSet/agent/dates/type/label, ')'))"></xsl:value-of>
                              </div>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:dates/vra:earliestDate,'')) != 0">
                              <div data-bf-bind="vra:dates/vra:earliestDate" data-bf-type="input" tabindex="0"
                                   title=""
                                   id="b-d2e98">
                                 <xsl:value-of select="vra:dates/vra:earliestDate"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-bind="vra:dates/vra:earliestDate" data-bf-type="input"
                                   tabindex="0">
                                 <xsl:value-of select="normalize-space(concat('(', $language-files/language/agentSet/agent/dates/earliestDate/label, ')'))"></xsl:value-of>
                              </div>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:dates/vra:earliestDate/@circa,'')) != 0 and vra:dates/vra:earliestDate/@circa eq 'true'">
                              <div class="subtitle" data-bf-bind="vra:dates/vra:earliestDate/@circa"
                                   data-bf-type="input"
                                   tabindex="0"
                                   title="">circa</div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-bind="vra:dates/vra:earliestDate/@circa"
                                   data-bf-type="input"
                                   tabindex="0">
                                 <xsl:value-of select="normalize-space(concat('(', $language-files/language/agentSet/agent/dates/earliestDate/circa/label, ')'))"></xsl:value-of>
                              </div>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:dates/vra:latestDate,'')) != 0">
                              <div data-bf-bind="vra:dates/vra:latestDate" data-bf-type="input" tabindex="0"
                                   title=""
                                   id="b-d2e106">
                                 <xsl:value-of select="vra:dates/vra:latestDate"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-bind="vra:dates/vra:latestDate" data-bf-type="input"
                                   tabindex="0">
                                 <xsl:value-of select="normalize-space(concat('(', $language-files/language/agentSet/agent/dates/latestDate/label, ')'))"></xsl:value-of>
                              </div>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:dates/vra:latestDate/@circa,'')) != 0 and vra:dates/vra:latestDate/@circa eq 'true'">
                              <div class="subtitle" data-bf-bind="vra:dates/vra:latestDate/@circa"
                                   data-bf-type="input"
                                   tabindex="0"
                                   title="">circa</div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-bind="vra:dates/vra:latestDate/@circa"
                                   data-bf-type="input"
                                   tabindex="0">
                                 <xsl:value-of select="normalize-space(concat('(', $language-files/language/agentSet/agent/dates/latestDate/circa/label, ')'))"></xsl:value-of>
                              </div>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:name,'')) != 0">
                              <div data-bf-bind="vra:name" data-bf-type="input" tabindex="0" title=""
                                   id="b-d2e115">
                                 <xsl:value-of select="vra:name"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-bind="vra:name" data-bf-type="input" tabindex="0">
                                 <xsl:value-of select="normalize-space(concat('(', $language-files/language/agentSet/agent/name/label, ')'))"></xsl:value-of>
                              </div>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:name/@type,'')) != 0">
                              <div data-bf-bind="vra:name/@type" data-bf-type="select1" tabindex="0" title=""
                                   id="b-d2e122"
                                   class=" nameType">
                                 <xsl:value-of select="vra:name/@type"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-bind="vra:name/@type" data-bf-type="select1"
                                   tabindex="0">
                                 <xsl:value-of select="normalize-space(concat('(', $language-files/language/agentSet/agent/name/type/label, ')'))"></xsl:value-of>
                              </div>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                     <td xmlns="">
                        <table class="table viewADateTable">
                           <tr>
                              <td></td>
                              <td></td>
                           </tr>
                        </table>
                        <table class="table viewADateTable">
                           <tr>
                              <td></td>
                              <td></td>
                           </tr>
                        </table>
                     </td>
                  </tr>
               </xsl:for-each>
            </tbody>
         </table>
      </div>
   </xsl:template>
</xsl:stylesheet>
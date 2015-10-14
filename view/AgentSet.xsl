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
                           <xsl:when test="string-length(string-join(vra:name/@type,'')) != 0">
                              <div data-bf-bind="vra:name/@type" data-bf-type="select1" tabindex="0" title=""
                                   id="b-d2e187"
                                   class="detail nameType">
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
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:name,'')) != 0">
                              <div data-bf-bind="vra:name" data-bf-type="input" tabindex="0" title=""
                                   id="b-d2e180"
                                   class="Name-autocomplete">
                                 <xsl:value-of select="vra:name"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-bind="vra:name" data-bf-type="input" tabindex="0">
                                 <xsl:value-of select="normalize-space(concat('(', $language-files/language, ')'))"></xsl:value-of>
                              </div>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:role,'')) != 0">
                              <div data-bf-bind="vra:role" data-bf-type="select1" tabindex="0" title="">
                                 <xsl:variable name="role" select="vra:role"></xsl:variable>
                                 <xsl:value-of select="$role-codes-legend//item[value eq $role]/label"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-bind="vra:role" data-bf-type="select1" tabindex="0">
                                 <xsl:value-of select="normalize-space(concat('(', $language-files/language/agentSet/agent/role/label, ')'))"></xsl:value-of>
                              </div>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:attribution,'')) != 0">
                              <div data-bf-bind="vra:attribution" data-bf-type="input" tabindex="0" title=""
                                   id="b-d2e74">
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
                                   id="b-d2e95">
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
                     <td xmlns="">
                        <table class="table viewADateTable">
                           <tr>
                              <td>
                                 <xsl:choose xmlns="http://www.w3.org/1999/xhtml">
                                    <xsl:when test="string-length(string-join(vra:dates/vra:earliestDate/@type,'')) != 0">
                                       <div data-bf-bind="vra:dates/vra:earliestDate/@type" data-bf-type="select1"
                                            tabindex="0"
                                            title=""
                                            id="b-d2e127"
                                            class=" datesType">
                                          <xsl:value-of select="vra:dates/vra:earliestDate/@type"></xsl:value-of>
                                       </div>
                                    </xsl:when>
                                    <xsl:otherwise>
                                       <div class="nodata" data-bf-bind="vra:dates/vra:earliestDate/@type"
                                            data-bf-type="select1"
                                            tabindex="0">
                                          <xsl:value-of select="normalize-space(concat('(', $language-files/language/agentSet/agent/dates/earliestDate/type/label, ')'))"></xsl:value-of>
                                       </div>
                                    </xsl:otherwise>
                                 </xsl:choose>
                              </td>
                              <td>
                                 <xsl:choose xmlns="http://www.w3.org/1999/xhtml">
                                    <xsl:when test="string-length(string-join(vra:dates/vra:earliestDate,'')) != 0">
                                       <div data-bf-bind="vra:dates/vra:earliestDate" data-bf-type="input" tabindex="0"
                                            title=""
                                            id="b-d2e119">
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
                              </td>
                           </tr>
                        </table>
                        <table class="table viewADateTable">
                           <tr>
                              <td>
                                 <xsl:choose xmlns="http://www.w3.org/1999/xhtml">
                                    <xsl:when test="string-length(string-join(vra:dates/vra:latestDate/@type,'')) != 0">
                                       <div data-bf-bind="vra:dates/vra:latestDate/@type" data-bf-type="select1"
                                            tabindex="0"
                                            title=""
                                            id="b-d2e150"
                                            class=" datesType">
                                          <xsl:value-of select="vra:dates/vra:latestDate/@type"></xsl:value-of>
                                       </div>
                                    </xsl:when>
                                    <xsl:otherwise>
                                       <div class="nodata" data-bf-bind="vra:dates/vra:latestDate/@type"
                                            data-bf-type="select1"
                                            tabindex="0">
                                          <xsl:value-of select="normalize-space(concat('(', $language-files/language/agentSet/agent/dates/latestDate/type/label, ')'))"></xsl:value-of>
                                       </div>
                                    </xsl:otherwise>
                                 </xsl:choose>
                              </td>
                              <td>
                                 <xsl:choose xmlns="http://www.w3.org/1999/xhtml">
                                    <xsl:when test="string-length(string-join(vra:dates/vra:latestDate,'')) != 0">
                                       <div data-bf-bind="vra:dates/vra:latestDate" data-bf-type="input" tabindex="0"
                                            title=""
                                            id="b-d2e142">
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
                              </td>
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
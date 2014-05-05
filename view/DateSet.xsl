<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:vra="http://www.vraweb.org/vracore4.htm"
                version="2.0">
   <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes"
               omit-xml-declaration="no"></xsl:output>
   <xsl:template match="vra:dateSet">
      <xsl:param name="vraTableId"></xsl:param>
      <div class="simple" id="{$vraTableId}">
         <table>
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
                              <div data-bf-type="select1" data-bf-bind="@type" tabindex="0" title="Type"
                                   id="b-d2e451"
                                   class=" ">
                                 <xsl:value-of select="@type"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="select1" data-bf-bind="@type" tabindex="0">(Type)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                     <td>
                        <table class="table viewDateTable">
                           <tbody>
                              <tr>
                                 <td>
                                    <xsl:choose xmlns="http://www.w3.org/1999/xhtml">
                                       <xsl:when test="string-length(string-join(vra:earliestDate/vra:date/@type,'')) != 0">
                                          <div data-bf-type="select1" data-bf-bind="vra:earliestDate/vra:date/@type"
                                               tabindex="0"
                                               title="Type"
                                               id="b-d2e369"
                                               class=" earliestDateType">
                                             <xsl:value-of select="vra:earliestDate/vra:date/@type"></xsl:value-of>
                                          </div>
                                       </xsl:when>
                                       <xsl:otherwise>
                                          <div class="nodata" data-bf-type="select1"
                                               data-bf-bind="vra:earliestDate/vra:date/@type"
                                               tabindex="0">(Type)</div>
                                       </xsl:otherwise>
                                    </xsl:choose>
                                 </td>
                                 <td>
                                    <xsl:choose xmlns="http://www.w3.org/1999/xhtml">
                                       <xsl:when test="string-length(string-join(vra:earliestDate/vra:date,'')) != 0">
                                          <div data-bf-type="input" data-bf-bind="vra:earliestDate/vra:date" tabindex="0"
                                               title="Date"
                                               id="b-d2e361">
                                             <xsl:value-of select="vra:earliestDate/vra:date"></xsl:value-of>
                                          </div>
                                       </xsl:when>
                                       <xsl:otherwise>
                                          <div class="nodata" data-bf-type="input" data-bf-bind="vra:earliestDate/vra:date"
                                               tabindex="0">(Date)</div>
                                       </xsl:otherwise>
                                    </xsl:choose>
                                 </td>
                              </tr>
                           </tbody>
                        </table>
                        <table xmlns="http://www.w3.org/1999/xhtml" class="vraSetInnerRepeatView table">
                           <tbody>
                              <xsl:for-each select="vra:earliestDate/vra:alternativeNotation">
                                 <tr>
                                    <td>
                                       <xsl:choose>
                                          <xsl:when test="string-length(string-join(@type,'')) != 0">
                                             <div data-bf-type="select1" data-bf-bind="@type" tabindex="0" title="Type"
                                                  id="b-d2e388"
                                                  class=" ">
                                                <xsl:value-of select="@type"></xsl:value-of>
                                             </div>
                                          </xsl:when>
                                          <xsl:otherwise>
                                             <div class="nodata" data-bf-type="select1" data-bf-bind="@type" tabindex="0">(Type)</div>
                                          </xsl:otherwise>
                                       </xsl:choose>
                                    </td>
                                    <td>
                                       <xsl:choose>
                                          <xsl:when test="string-length(string-join(.,'')) != 0">
                                             <div data-bf-type="input" data-bf-bind="." tabindex="0" title="AlternativeNotation"
                                                  id="b-d2e384">
                                                <xsl:value-of select="."></xsl:value-of>
                                             </div>
                                          </xsl:when>
                                          <xsl:otherwise>
                                             <div class="nodata" data-bf-type="input" data-bf-bind="." tabindex="0">(AlternativeNotation)</div>
                                          </xsl:otherwise>
                                       </xsl:choose>
                                    </td>
                                 </tr>
                              </xsl:for-each>
                           </tbody>
                        </table>
                     </td>
                     <td class="viewDateTable">
                        <table class="table viewDateTable">
                           <tbody>
                              <tr>
                                 <td>
                                    <xsl:choose xmlns="http://www.w3.org/1999/xhtml">
                                       <xsl:when test="string-length(string-join(vra:latestDate/vra:date/@type,'')) != 0">
                                          <div data-bf-type="select1" data-bf-bind="vra:latestDate/vra:date/@type"
                                               tabindex="0"
                                               title="Type"
                                               id="b-d2e417"
                                               class=" latestDateType">
                                             <xsl:value-of select="vra:latestDate/vra:date/@type"></xsl:value-of>
                                          </div>
                                       </xsl:when>
                                       <xsl:otherwise>
                                          <div class="nodata" data-bf-type="select1"
                                               data-bf-bind="vra:latestDate/vra:date/@type"
                                               tabindex="0">(Type)</div>
                                       </xsl:otherwise>
                                    </xsl:choose>
                                 </td>
                                 <td>
                                    <xsl:choose xmlns="http://www.w3.org/1999/xhtml">
                                       <xsl:when test="string-length(string-join(vra:latestDate/vra:date,'')) != 0">
                                          <div data-bf-type="input" data-bf-bind="vra:latestDate/vra:date" tabindex="0"
                                               title="Date"
                                               id="b-d2e409">
                                             <xsl:value-of select="vra:latestDate/vra:date"></xsl:value-of>
                                          </div>
                                       </xsl:when>
                                       <xsl:otherwise>
                                          <div class="nodata" data-bf-type="input" data-bf-bind="vra:latestDate/vra:date"
                                               tabindex="0">(Date)</div>
                                       </xsl:otherwise>
                                    </xsl:choose>
                                 </td>
                              </tr>
                           </tbody>
                        </table>
                        <table xmlns="http://www.w3.org/1999/xhtml" class="vraSetInnerRepeatView table">
                           <tbody>
                              <xsl:for-each select="vra:latestDate/vra:alternativeNotation">
                                 <tr>
                                    <td>
                                       <xsl:choose>
                                          <xsl:when test="string-length(string-join(@type,'')) != 0">
                                             <div data-bf-type="select1" data-bf-bind="@type" tabindex="0" title="Type"
                                                  id="b-d2e436"
                                                  class=" ">
                                                <xsl:value-of select="@type"></xsl:value-of>
                                             </div>
                                          </xsl:when>
                                          <xsl:otherwise>
                                             <div class="nodata" data-bf-type="select1" data-bf-bind="@type" tabindex="0">(Type)</div>
                                          </xsl:otherwise>
                                       </xsl:choose>
                                    </td>
                                    <td>
                                       <xsl:choose>
                                          <xsl:when test="string-length(string-join(.,'')) != 0">
                                             <div data-bf-type="input" data-bf-bind="." tabindex="0" title="AlternativeNotation"
                                                  id="b-d2e432">
                                                <xsl:value-of select="."></xsl:value-of>
                                             </div>
                                          </xsl:when>
                                          <xsl:otherwise>
                                             <div class="nodata" data-bf-type="input" data-bf-bind="." tabindex="0">(AlternativeNotation)</div>
                                          </xsl:otherwise>
                                       </xsl:choose>
                                    </td>
                                 </tr>
                              </xsl:for-each>
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
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:vra="http://www.vraweb.org/vracore4.htm"
                version="2.0">
   <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes"
               omit-xml-declaration="no"></xsl:output>
   <xsl:template match="vra:dateSet">
      <xsl:param name="vraTableId"></xsl:param>
      <div class="simple DateSet" id="{$vraTableId}">
         <table class="vraSetView table table-striped">
            <tbody>
               <xsl:for-each select="vra:date">
                  <tr>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(@type,'')) != 0">
                              <div id="d6e42-Type" data-bf-type="select1" data-bf-bind="@type" tabindex="0"
                                   title="Type">
                                 <xsl:value-of select="@type"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="detail" data-bf-type="select1" data-bf-bind="@type" tabindex="0">(Type)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:earliestDate,'')) != 0">
                              <div id="d3e524-EarliestDate" data-bf-type="input" data-bf-bind="vra:earliestDate"
                                   tabindex="0"
                                   title="EarliestDate">
                                 <xsl:value-of select="vra:earliestDate"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="detail" data-bf-type="input" data-bf-bind="vra:earliestDate"
                                   tabindex="0">(EarliestDate)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:earliestDate/@circa,'')) != 0">
                              <div id="" data-bf-type="input" data-bf-bind="vra:earliestDate/@circa" tabindex="0"
                                   title="circa">
                                 <xsl:value-of select="vra:earliestDate/@circa"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="detail" data-bf-type="input" data-bf-bind="vra:earliestDate/@circa"
                                   tabindex="0">(circa)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:latestDate,'')) != 0">
                              <div id="d3e526-LatestDate" data-bf-type="input" data-bf-bind="vra:latestDate"
                                   tabindex="0"
                                   title="LatestDate">
                                 <xsl:value-of select="vra:latestDate"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="detail" data-bf-type="input" data-bf-bind="vra:latestDate" tabindex="0">(LatestDate)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:latestDate/@circa,'')) != 0">
                              <div id="" data-bf-type="input" data-bf-bind="vra:latestDate/@circa" tabindex="0"
                                   title="circa">
                                 <xsl:value-of select="vra:latestDate/@circa"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="detail" data-bf-type="input" data-bf-bind="vra:latestDate/@circa"
                                   tabindex="0">(circa)</div>
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
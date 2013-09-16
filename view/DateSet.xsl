<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:vra="http://www.vraweb.org/vracore4.htm" xmlns:html="http://www.w3.org/1999/xhtml" version="2.0">
   <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"></xsl:output>
   <xsl:template match="vra:dateSet">
      <xsl:param name="vraTableId"></xsl:param>
      <div class="simple" id="{$vraTableId}">
         <table class="vraSetView table table-striped">
            <tbody>
               <xsl:for-each select="vra:date">
                  <tr>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(@type,'')) != 0">
                              <div data-bf-type="select1" data-bf-bind="@type" tabindex="0" title="Type" id="b-d2e331">
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
                           <xsl:when test="string-length(string-join(vra:earliestDate/@circa,'')) != 0 and vra:earliestDate/@circa eq 'true'">
                              <div class="subtitle" data-bf-type="input" data-bf-bind="vra:earliestDate/@circa" tabindex="0" title="circa">circa</div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="input" data-bf-bind="vra:earliestDate/@circa" tabindex="0">(circa)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:earliestDate,'')) != 0">
                              <div data-bf-type="input" data-bf-bind="vra:earliestDate" tabindex="0" title="EarliestDate" id="b-d2e296">
                                 <xsl:value-of select="vra:earliestDate"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="input" data-bf-bind="vra:earliestDate" tabindex="0">(EarliestDate)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:latestDate/@circa,'')) != 0 and vra:latestDate/@circa eq 'true'">
                              <div class="subtitle" data-bf-type="input" data-bf-bind="vra:latestDate/@circa" tabindex="0" title="circa">circa</div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="input" data-bf-bind="vra:latestDate/@circa" tabindex="0">(circa)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:latestDate,'')) != 0">
                              <div data-bf-type="input" data-bf-bind="vra:latestDate" tabindex="0" title="LatestDate" id="b-d2e304">
                                 <xsl:value-of select="vra:latestDate"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="input" data-bf-bind="vra:latestDate" tabindex="0">(LatestDate)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:alternativeNotation/@type,'')) != 0">
                              <div data-bf-type="select1" data-bf-bind="vra:alternativeNotation/@type" tabindex="0" title="Type" id="b-d2e316">
                                 <xsl:value-of select="vra:alternativeNotation/@type"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="select1" data-bf-bind="vra:alternativeNotation/@type" tabindex="0">(Type)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:alternativeNotation,'')) != 0">
                              <div data-bf-type="input" data-bf-bind="vra:alternativeNotation" tabindex="0" title="AlternativeNotation" id="b-d2e312">
                                 <xsl:value-of select="vra:alternativeNotation"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="input" data-bf-bind="vra:alternativeNotation" tabindex="0">(AlternativeNotation)</div>
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
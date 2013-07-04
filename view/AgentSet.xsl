<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:vra="http://www.vraweb.org/vracore4.htm"
                version="2.0">
   <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes"
               omit-xml-declaration="no"></xsl:output>
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
                              <div data-bf-type="select1" data-bf-bind="vra:name/@type" tabindex="0" title="Type"
                                   id="b-d2e122"
                                   class="detail">
                                 <xsl:value-of select="vra:name/@type"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="select1" data-bf-bind="vra:name/@type"
                                   tabindex="0">(Type)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:name,'')) != 0">
                              <div data-bf-type="input" data-bf-bind="vra:name" tabindex="0" title="Name"
                                   id="b-d2e115">
                                 <xsl:value-of select="vra:name"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="input" data-bf-bind="vra:name" tabindex="0">(Name)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:role,'')) != 0">
                              <div data-bf-type="select1" data-bf-bind="vra:role" tabindex="0" title="Role">
                                 <xsl:value-of select="vra:role"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="select1" data-bf-bind="vra:role" tabindex="0">(Role)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:attribution,'')) != 0">
                              <div data-bf-type="input" data-bf-bind="vra:attribution" tabindex="0"
                                   title="Attribution"
                                   id="b-d2e63">
                                 <xsl:value-of select="vra:attribution"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="input" data-bf-bind="vra:attribution" tabindex="0">(Attribution)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:culture,'')) != 0">
                              <div data-bf-type="input" data-bf-bind="vra:culture" tabindex="0" title="Culture"
                                   id="b-d2e79">
                                 <xsl:value-of select="vra:culture"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="input" data-bf-bind="vra:culture" tabindex="0">(Culture)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:dates/@type,'')) != 0">
                              <div data-bf-type="select1" data-bf-bind="vra:dates/@type" tabindex="0" title="Type"
                                   id="b-d2e114"
                                   class="detail">
                                 <xsl:value-of select="vra:dates/@type"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="select1" data-bf-bind="vra:dates/@type"
                                   tabindex="0">(Type)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:dates/vra:earliestDate,'')) != 0">
                              <div data-bf-type="input" data-bf-bind="vra:dates/vra:earliestDate" tabindex="0"
                                   title="EarliestDate"
                                   id="b-d2e98">
                                 <xsl:value-of select="vra:dates/vra:earliestDate"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="input" data-bf-bind="vra:dates/vra:earliestDate"
                                   tabindex="0">(EarliestDate)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:dates/vra:earliestDate/@circa,'')) != 0 and vra:dates/vra:earliestDate/@circa eq 'true'">
                              <div class="subtitle" data-bf-type="input"
                                   data-bf-bind="vra:dates/vra:earliestDate/@circa"
                                   tabindex="0"
                                   title="circa">circa</div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="input"
                                   data-bf-bind="vra:dates/vra:earliestDate/@circa"
                                   tabindex="0">(circa)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:dates/vra:latestDate,'')) != 0">
                              <div data-bf-type="input" data-bf-bind="vra:dates/vra:latestDate" tabindex="0"
                                   title="LatestDate"
                                   id="b-d2e106">
                                 <xsl:value-of select="vra:dates/vra:latestDate"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="input" data-bf-bind="vra:dates/vra:latestDate"
                                   tabindex="0">(LatestDate)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:dates/vra:latestDate/@circa,'')) != 0 and vra:dates/vra:latestDate/@circa eq 'true'">
                              <div class="subtitle" data-bf-type="input"
                                   data-bf-bind="vra:dates/vra:latestDate/@circa"
                                   tabindex="0"
                                   title="circa">circa</div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="input"
                                   data-bf-bind="vra:dates/vra:latestDate/@circa"
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
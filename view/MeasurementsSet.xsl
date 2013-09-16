<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:vra="http://www.vraweb.org/vracore4.htm" xmlns:html="http://www.w3.org/1999/xhtml" version="2.0">
   <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"></xsl:output>
   <xsl:template match="vra:measurementsSet">
      <xsl:param name="vraTableId"></xsl:param>
      <div class="simple" id="{$vraTableId}">
         <table class="vraSetView table table-striped">
            <tbody>
               <xsl:for-each select="vra:measurements">
                  <tr>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(@type,'')) != 0">
                              <div data-bf-type="select1" data-bf-bind="@type" tabindex="0" title="Type" id="b-d2e781">
                                 <xsl:value-of select="@type"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="select1" data-bf-bind="@type" tabindex="0">(Type)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(.,'')) != 0">
                              <div data-bf-type="input" data-bf-bind="." tabindex="0" title="Measurements" id="b-d2e774">
                                 <xsl:value-of select="."></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="input" data-bf-bind="." tabindex="0">(Measurements)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(@unit,'')) != 0">
                              <div data-bf-type="input" data-bf-bind="@unit" tabindex="0" title="Unit" id="b-d2e782">
                                 <xsl:value-of select="@unit"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="input" data-bf-bind="@unit" tabindex="0">(Unit)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(@shape,'')) != 0">
                              <div data-bf-type="select1" data-bf-bind="@shape" tabindex="0" title="Shape" id="b-d2e783">
                                 <xsl:value-of select="@shape"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="select1" data-bf-bind="@shape" tabindex="0">(Shape)</div>
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
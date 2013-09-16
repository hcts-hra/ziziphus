<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:vra="http://www.vraweb.org/vracore4.htm" xmlns:html="http://www.w3.org/1999/xhtml" version="2.0">
   <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"></xsl:output>
   <xsl:template match="vra:descriptionSet">
      <xsl:param name="vraTableId"></xsl:param>
      <div class="simple" id="{$vraTableId}">
         <table class="vraSetView table table-striped">
            <tbody>
               <xsl:for-each select="vra:description">
                  <tr>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(.,'')) != 0">
                              <div data-bf-type="textarea" data-bf-bind="." tabindex="0" title="" id="b-d2e391">
                                 <xsl:value-of select="."></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="textarea" data-bf-bind="." tabindex="0">()</div>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(@stateOfPreservation,'')) != 0">
                              <div data-bf-type="input" data-bf-bind="@stateOfPreservation" tabindex="0" title="stateOfPreservation">
                                 <xsl:value-of select="@stateOfPreservation"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="input" data-bf-bind="@stateOfPreservation" tabindex="0">(stateOfPreservation)</div>
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
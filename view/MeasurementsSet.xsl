<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:vra="http://www.vraweb.org/vracore4.htm"
                version="2.0">
   <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes"
               omit-xml-declaration="no"></xsl:output>
   <xsl:template match="vra:measurementsSet">
      <xsl:param name="vraTableId"></xsl:param>
      <div class="simple" id="{$vraTableId}">
         <table class="vraSetView table table-striped">
            <tbody>
               <xsl:for-each select="vra:measurements">
                  <tr>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:measurements/@type,'')) != 0">
                              <div data-bf-type="select1" data-bf-bind="vra:measurements/@type" tabindex="0"
                                   title="Type"
                                   id="b-d2e948">
                                 <xsl:value-of select="vra:measurements/@type"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="select1" data-bf-bind="vra:measurements/@type"
                                   tabindex="0">(Type)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:measurements,'')) != 0">
                              <div data-bf-type="input" data-bf-bind="vra:measurements" tabindex="0"
                                   title="Measurements"
                                   id="b-d2e941">
                                 <xsl:value-of select="vra:measurements"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="input" data-bf-bind="vra:measurements"
                                   tabindex="0">(Measurements)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:measurements/@unit,'')) != 0">
                              <div data-bf-type="input" data-bf-bind="vra:measurements/@unit" tabindex="0"
                                   title="Unit"
                                   id="b-d2e949">
                                 <xsl:value-of select="vra:measurements/@unit"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="input" data-bf-bind="vra:measurements/@unit"
                                   tabindex="0">(Unit)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:measurements/@shape,'')) != 0">
                              <div data-bf-type="select1" data-bf-bind="vra:measurements/@shape" tabindex="0"
                                   title="Shape"
                                   id="b-d2e950">
                                 <xsl:value-of select="vra:measurements/@shape"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="select1" data-bf-bind="vra:measurements/@shape"
                                   tabindex="0">(Shape)</div>
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
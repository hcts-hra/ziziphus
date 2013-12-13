<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:vra="http://www.vraweb.org/vracore4.htm"
                version="2.0">
   <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes"
               omit-xml-declaration="no"></xsl:output>
   <xsl:template match="vra:subjectSet">
      <xsl:param name="vraTableId"></xsl:param>
      <div class="simple" id="{$vraTableId}">
         <table class="vraSetView table table-striped">
            <tbody>
               <xsl:for-each select="vra:subject">
                  <tr>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:term/@type,'')) != 0">
                              <div data-bf-type="select1" data-bf-bind="vra:term/@type" tabindex="0" title="Type"
                                   id="b-d2e1518"
                                   class=" termType">
                                 <xsl:value-of select="vra:term/@type"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="select1" data-bf-bind="vra:term/@type"
                                   tabindex="0">(Type)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:term,'')) != 0">
                              <div data-bf-type="input" data-bf-bind="vra:term" tabindex="0" title="Term"
                                   id="b-d2e1511"
                                   class="Term-autocomplete">
                                 <xsl:value-of select="vra:term"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="input" data-bf-bind="vra:term" tabindex="0">(Term)</div>
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
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:vra="http://www.vraweb.org/vracore4.htm"
                version="2.0">
   <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes"
               omit-xml-declaration="no"></xsl:output>
   <xsl:preserve-space elements="vra:text"></xsl:preserve-space>
   <xsl:template match="vra:subjectSet">
      <xsl:param name="vraTableId"></xsl:param>
      <div class="simple" id="{$vraTableId}">
         <table class="vraSetView table table-striped">
            <tbody xmlns="">
               <xsl:for-each-group select="vra:subject" group-by="vra:term/@type">
                  <xsl:sort select="current-grouping-key()"></xsl:sort>
                  <xsl:for-each select="current-group()">
                     <xsl:sort select="translate(vra:term, 'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"></xsl:sort>
                     <tr>
                        <td>
                           <xsl:choose>
                              <xsl:when test="string-length(string-join(vra:term,'')) != 0">
                                 <xsl:variable name="term" select="vra:term"></xsl:variable>
                                 <xsl:variable name="type">
                                    <xsl:choose>
                                       <xsl:when test="string-length(string-join($term/@type,'')) != 0">
                                          <xsl:value-of select="concat(' [', normalize-space($term/@type),']')"></xsl:value-of>
                                       </xsl:when>
                                       <xsl:otherwise></xsl:otherwise>
                                    </xsl:choose>
                                 </xsl:variable>
                                 <div data-bf-type="input" data-bf-bind="vra:term" tabindex="0" title="Term">
                                    <xsl:value-of select="$term"></xsl:value-of>
                                    <xsl:value-of select="$type"></xsl:value-of>
                                 </div>
                              </xsl:when>
                              <xsl:otherwise>
                                 <div class="nodata" data-bf-type="input" data-bf-bind="vra:term" tabindex="0">(Term)</div>
                              </xsl:otherwise>
                           </xsl:choose>
                        </td>
                     </tr>
                  </xsl:for-each>
               </xsl:for-each-group>
            </tbody>
         </table>
      </div>
   </xsl:template>
</xsl:stylesheet>
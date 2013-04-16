<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:vra="http://www.vraweb.org/vracore4.htm"
                version="2.0">
   <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes"
               omit-xml-declaration="no"></xsl:output>
   <xsl:template match="vra:inscriptionSet">
      <xsl:param name="vraTableId"></xsl:param>
      <div class="simple InscriptionSet" id="{$vraTableId}">
         <table class="vraSetView table table-striped">
            <tbody>
               <xsl:for-each select="vra:inscription">
                  <tr>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:author,'')) != 0">
                              <div id="d3e536-Author" data-bf-type="input" data-bf-bind="vra:author" tabindex="0"
                                   title="Author">
                                 <xsl:value-of select="vra:author"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="detail" data-bf-type="input" data-bf-bind="vra:author" tabindex="0">(Author)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:position,'')) != 0">
                              <div id="d3e537-Position" data-bf-type="input" data-bf-bind="vra:position"
                                   tabindex="0"
                                   title="Position">
                                 <xsl:value-of select="vra:position"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="detail" data-bf-type="input" data-bf-bind="vra:position" tabindex="0">(Position)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                     <td>Text
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:text/@type,'')) != 0">
                              <div id="d6e60-Type" data-bf-type="select1" data-bf-bind="vra:text/@type"
                                   tabindex="0"
                                   title="Type">
                                 <xsl:value-of select="vra:text/@type"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="detail" data-bf-type="select1" data-bf-bind="vra:text/@type"
                                   tabindex="0">(Type)</div>
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
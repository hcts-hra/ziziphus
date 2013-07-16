<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:vra="http://www.vraweb.org/vracore4.htm"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:diff="http://betterform.de/ziziphus/diff"
                version="2.0">
   <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes"
               omit-xml-declaration="no"></xsl:output>
   <xsl:template match="vra:inscriptionSet">
      <xsl:param name="vraTableId"></xsl:param>
      <div class="simple" id="{$vraTableId}">
         <table class="vraSetView table table-striped">
            <tbody>
               <xsl:for-each select="vra:inscription">
                  <tr>
                     <xsl:call-template name="diff:insert-element-diff-class"></xsl:call-template>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:text/@type,'')) != 0">
                              <div title="Type" id="b-d2e407">
                                 <xsl:apply-templates select="vra:text/@type"></xsl:apply-templates>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata">(Type)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:text,'')) != 0">
                              <div title="." id="b-d2e400">
                                 <xsl:apply-templates select="vra:text"></xsl:apply-templates>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata">(.)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:author,'')) != 0">
                              <div title="Author" id="b-d2e368">
                                 <xsl:apply-templates select="vra:author"></xsl:apply-templates>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata">(Author)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:position,'')) != 0">
                              <div title="Position" id="b-d2e384">
                                 <xsl:apply-templates select="vra:position"></xsl:apply-templates>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata">(Position)</div>
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
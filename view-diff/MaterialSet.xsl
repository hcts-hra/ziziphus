<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:vra="http://www.vraweb.org/vracore4.htm"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:diff="http://betterform.de/ziziphus/diff"
                version="2.0">
   <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes"
               omit-xml-declaration="no"></xsl:output>
   <xsl:template match="vra:materialSet">
      <xsl:param name="vraTableId"></xsl:param>
      <div class="simple" id="{$vraTableId}">
         <table class="vraSetView table table-striped">
            <tbody>
               <xsl:for-each select="vra:material">
                  <tr>
                     <xsl:call-template name="diff:insert-element-diff-class"></xsl:call-template>
                     <td>
                        <xsl:choose>
                           <xsl:when test="@diff:attr-before-type or @diff:attr-after-type">
                              <xsl:choose>
                                 <xsl:when test="string-length(string-join(@diff:attr-before-type,'')) != 0">
                                    <div title="Type" class="diffs-attr-before" id="b-d2e554">
                                       <xsl:value-of select="@diff:attr-before-type"></xsl:value-of>
                                    </div>
                                 </xsl:when>
                                 <xsl:otherwise>
                                    <div class="nodata diffs-attr-before">(Type)</div>
                                 </xsl:otherwise>
                              </xsl:choose>
                              <xsl:choose>
                                 <xsl:when test="string-length(string-join(@diff:attr-after-type,'')) != 0">
                                    <div title="Type" class="diffs-attr-after" id="b-d2e554">
                                       <xsl:value-of select="@diff:attr-after-type"></xsl:value-of>
                                    </div>
                                 </xsl:when>
                                 <xsl:otherwise>
                                    <div class="nodata diffs-attr-after">(Type)</div>
                                 </xsl:otherwise>
                              </xsl:choose>
                           </xsl:when>
                           <xsl:otherwise>
                              <xsl:choose>
                                 <xsl:when test="string-length(string-join(@type,'')) != 0">
                                    <div title="Type" id="b-d2e554">
                                       <xsl:value-of select="@type"></xsl:value-of>
                                    </div>
                                 </xsl:when>
                                 <xsl:otherwise>
                                    <div class="nodata">(Type)</div>
                                 </xsl:otherwise>
                              </xsl:choose>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(.,'')) != 0">
                              <div title="Material" id="b-d2e547">
                                 <xsl:apply-templates select="."></xsl:apply-templates>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata">(Material)</div>
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
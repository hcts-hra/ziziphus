<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:vra="http://www.vraweb.org/vracore4.htm"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:diff="http://betterform.de/ziziphus/diff"
                version="2.0">
   <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes"
               omit-xml-declaration="no"></xsl:output>
   <xsl:template match="vra:stateEditionSet">
      <xsl:param name="vraTableId"></xsl:param>
      <div class="simple" id="{$vraTableId}">
         <table class="vraSetView table table-striped">
            <tbody>
               <xsl:for-each select="vra:stateEdition">
                  <tr>
                     <xsl:call-template name="diff:insert-element-diff-class"></xsl:call-template>
                     <td>
                        <xsl:choose>
                           <xsl:when test="@diff:attr-before-type or @diff:attr-after-type">
                              <xsl:choose>
                                 <xsl:when test="string-length(string-join(@diff:attr-before-type,'')) != 0">
                                    <div title="Type" class="diffs-attr-before" id="b-d2e924">
                                       <xsl:value-of select="@diff:attr-before-type"></xsl:value-of>
                                    </div>
                                 </xsl:when>
                                 <xsl:otherwise>
                                    <div class="nodata diffs-attr-before">(Type)</div>
                                 </xsl:otherwise>
                              </xsl:choose>
                              <xsl:choose>
                                 <xsl:when test="string-length(string-join(@diff:attr-after-type,'')) != 0">
                                    <div title="Type" class="diffs-attr-after" id="b-d2e924">
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
                                    <div title="Type" id="b-d2e924">
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
                           <xsl:when test="@diff:attr-before-count or @diff:attr-after-count">
                              <xsl:choose>
                                 <xsl:when test="string-length(string-join(@diff:attr-before-count,'')) != 0">
                                    <div title="count" class="diffs-attr-before">
                                       <xsl:value-of select="@diff:attr-before-count"></xsl:value-of>
                                    </div>
                                 </xsl:when>
                                 <xsl:otherwise>
                                    <div class="nodata diffs-attr-before">(count)</div>
                                 </xsl:otherwise>
                              </xsl:choose>
                              <xsl:choose>
                                 <xsl:when test="string-length(string-join(@diff:attr-after-count,'')) != 0">
                                    <div title="count" class="diffs-attr-after">
                                       <xsl:value-of select="@diff:attr-after-count"></xsl:value-of>
                                    </div>
                                 </xsl:when>
                                 <xsl:otherwise>
                                    <div class="nodata diffs-attr-after">(count)</div>
                                 </xsl:otherwise>
                              </xsl:choose>
                           </xsl:when>
                           <xsl:otherwise>
                              <xsl:choose>
                                 <xsl:when test="string-length(string-join(@count,'')) != 0">
                                    <div title="count">
                                       <xsl:value-of select="@count"></xsl:value-of>
                                    </div>
                                 </xsl:when>
                                 <xsl:otherwise>
                                    <div class="nodata">(count)</div>
                                 </xsl:otherwise>
                              </xsl:choose>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="@diff:attr-before-num or @diff:attr-after-num">
                              <xsl:choose>
                                 <xsl:when test="string-length(string-join(@diff:attr-before-num,'')) != 0">
                                    <div title="num" class="diffs-attr-before">
                                       <xsl:value-of select="@diff:attr-before-num"></xsl:value-of>
                                    </div>
                                 </xsl:when>
                                 <xsl:otherwise>
                                    <div class="nodata diffs-attr-before">(num)</div>
                                 </xsl:otherwise>
                              </xsl:choose>
                              <xsl:choose>
                                 <xsl:when test="string-length(string-join(@diff:attr-after-num,'')) != 0">
                                    <div title="num" class="diffs-attr-after">
                                       <xsl:value-of select="@diff:attr-after-num"></xsl:value-of>
                                    </div>
                                 </xsl:when>
                                 <xsl:otherwise>
                                    <div class="nodata diffs-attr-after">(num)</div>
                                 </xsl:otherwise>
                              </xsl:choose>
                           </xsl:when>
                           <xsl:otherwise>
                              <xsl:choose>
                                 <xsl:when test="string-length(string-join(@num,'')) != 0">
                                    <div title="num">
                                       <xsl:value-of select="@num"></xsl:value-of>
                                    </div>
                                 </xsl:when>
                                 <xsl:otherwise>
                                    <div class="nodata">(num)</div>
                                 </xsl:otherwise>
                              </xsl:choose>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:description,'')) != 0">
                              <div title="Description" id="b-d2e880">
                                 <xsl:apply-templates select="vra:description"></xsl:apply-templates>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata">(Description)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:name,'')) != 0">
                              <div title="Name" id="b-d2e896" class="elementName">
                                 <xsl:apply-templates select="vra:name"></xsl:apply-templates>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata">(Name)</div>
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
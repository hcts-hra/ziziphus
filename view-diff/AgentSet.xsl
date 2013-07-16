<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:vra="http://www.vraweb.org/vracore4.htm"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:diff="http://betterform.de/ziziphus/diff"
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
                     <xsl:call-template name="diff:insert-element-diff-class"></xsl:call-template>
                     <td>
                        <xsl:choose>
                           <xsl:when test="vra:name/@diff:attr-before-type or vra:name/@diff:attr-after-type">
                              <xsl:choose>
                                 <xsl:when test="string-length(string-join(vra:name/@diff:attr-before-type,'')) != 0">
                                    <div title="Type" class="detail" id="b-d2e122">
                                       <xsl:apply-templates select="vra:name/@diff:attr-before-type"></xsl:apply-templates>
                                    </div>
                                 </xsl:when>
                                 <xsl:otherwise>
                                    <div class="nodata diffs-attr-before">(Type)</div>
                                 </xsl:otherwise>
                              </xsl:choose>
                              <xsl:choose>
                                 <xsl:when test="string-length(string-join(vra:name/@diff:attr-after-type,'')) != 0">
                                    <div title="Type" class="detail" id="b-d2e122">
                                       <xsl:apply-templates select="vra:name/@diff:attr-after-type"></xsl:apply-templates>
                                    </div>
                                 </xsl:when>
                                 <xsl:otherwise>
                                    <div class="nodata diffs-attr-after">(Type)</div>
                                 </xsl:otherwise>
                              </xsl:choose>
                           </xsl:when>
                           <xsl:otherwise>
                              <xsl:choose>
                                 <xsl:when test="string-length(string-join(vra:name/@type,'')) != 0">
                                    <div title="Type" id="b-d2e122" class="detail">
                                       <xsl:apply-templates select="vra:name/@type"></xsl:apply-templates>
                                    </div>
                                 </xsl:when>
                                 <xsl:otherwise>
                                    <div class="nodata">(Type)</div>
                                 </xsl:otherwise>
                              </xsl:choose>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:name,'')) != 0">
                              <div title="Name" id="b-d2e115">
                                 <xsl:apply-templates select="vra:name"></xsl:apply-templates>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata">(Name)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:role,'')) != 0">
                              <div title="Role" id="b-d2e132">
                                 <xsl:apply-templates select="vra:role"></xsl:apply-templates>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata">(Role)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:attribution,'')) != 0">
                              <div title="Attribution" id="b-d2e63">
                                 <xsl:apply-templates select="vra:attribution"></xsl:apply-templates>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata">(Attribution)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:culture,'')) != 0">
                              <div title="Culture" id="b-d2e79">
                                 <xsl:apply-templates select="vra:culture"></xsl:apply-templates>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata">(Culture)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                     <td>
                        <xsl:choose>
                           <xsl:when test="vra:dates/@diff:attr-before-type or vra:dates/@diff:attr-after-type">
                              <xsl:choose>
                                 <xsl:when test="string-length(string-join(vra:dates/@diff:attr-before-type,'')) != 0">
                                    <div title="Type" class="detail" id="b-d2e114">
                                       <xsl:apply-templates select="vra:dates/@diff:attr-before-type"></xsl:apply-templates>
                                    </div>
                                 </xsl:when>
                                 <xsl:otherwise>
                                    <div class="nodata diffs-attr-before">(Type)</div>
                                 </xsl:otherwise>
                              </xsl:choose>
                              <xsl:choose>
                                 <xsl:when test="string-length(string-join(vra:dates/@diff:attr-after-type,'')) != 0">
                                    <div title="Type" class="detail" id="b-d2e114">
                                       <xsl:apply-templates select="vra:dates/@diff:attr-after-type"></xsl:apply-templates>
                                    </div>
                                 </xsl:when>
                                 <xsl:otherwise>
                                    <div class="nodata diffs-attr-after">(Type)</div>
                                 </xsl:otherwise>
                              </xsl:choose>
                           </xsl:when>
                           <xsl:otherwise>
                              <xsl:choose>
                                 <xsl:when test="string-length(string-join(vra:dates/@type,'')) != 0">
                                    <div title="Type" id="b-d2e114" class="detail">
                                       <xsl:apply-templates select="vra:dates/@type"></xsl:apply-templates>
                                    </div>
                                 </xsl:when>
                                 <xsl:otherwise>
                                    <div class="nodata">(Type)</div>
                                 </xsl:otherwise>
                              </xsl:choose>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:dates/vra:earliestDate,'')) != 0">
                              <div title="EarliestDate" id="b-d2e98">
                                 <xsl:apply-templates select="vra:dates/vra:earliestDate"></xsl:apply-templates>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata">(EarliestDate)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="vra:dates/vra:earliestDate/@diff:attr-before-circa or vra:dates/vra:earliestDate/@diff:attr-after-circa">
                              <xsl:choose>
                                 <xsl:when test="string-length(string-join(vra:dates/vra:earliestDate/@diff:attr-before-circa,'')) != 0">
                                    <div title="circa" class="diffs-attr-before">
                                       <xsl:apply-templates select="vra:dates/vra:earliestDate/@diff:attr-before-circa"></xsl:apply-templates>
                                    </div>
                                 </xsl:when>
                                 <xsl:otherwise>
                                    <div class="nodata diffs-attr-before">(circa)</div>
                                 </xsl:otherwise>
                              </xsl:choose>
                              <xsl:choose>
                                 <xsl:when test="string-length(string-join(vra:dates/vra:earliestDate/@diff:attr-after-circa,'')) != 0">
                                    <div title="circa" class="diffs-attr-after">
                                       <xsl:apply-templates select="vra:dates/vra:earliestDate/@diff:attr-after-circa"></xsl:apply-templates>
                                    </div>
                                 </xsl:when>
                                 <xsl:otherwise>
                                    <div class="nodata diffs-attr-after">(circa)</div>
                                 </xsl:otherwise>
                              </xsl:choose>
                           </xsl:when>
                           <xsl:otherwise>
                              <xsl:choose>
                                 <xsl:when test="string-length(string-join(vra:dates/vra:earliestDate/@circa,'')) != 0">
                                    <div title="circa">
                                       <xsl:apply-templates select="vra:dates/vra:earliestDate/@circa"></xsl:apply-templates>
                                    </div>
                                 </xsl:when>
                                 <xsl:otherwise>
                                    <div class="nodata">(circa)</div>
                                 </xsl:otherwise>
                              </xsl:choose>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:dates/vra:latestDate,'')) != 0">
                              <div title="LatestDate" id="b-d2e106">
                                 <xsl:apply-templates select="vra:dates/vra:latestDate"></xsl:apply-templates>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata">(LatestDate)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="vra:dates/vra:latestDate/@diff:attr-before-circa or vra:dates/vra:latestDate/@diff:attr-after-circa">
                              <xsl:choose>
                                 <xsl:when test="string-length(string-join(vra:dates/vra:latestDate/@diff:attr-before-circa,'')) != 0">
                                    <div title="circa" class="diffs-attr-before">
                                       <xsl:apply-templates select="vra:dates/vra:latestDate/@diff:attr-before-circa"></xsl:apply-templates>
                                    </div>
                                 </xsl:when>
                                 <xsl:otherwise>
                                    <div class="nodata diffs-attr-before">(circa)</div>
                                 </xsl:otherwise>
                              </xsl:choose>
                              <xsl:choose>
                                 <xsl:when test="string-length(string-join(vra:dates/vra:latestDate/@diff:attr-after-circa,'')) != 0">
                                    <div title="circa" class="diffs-attr-after">
                                       <xsl:apply-templates select="vra:dates/vra:latestDate/@diff:attr-after-circa"></xsl:apply-templates>
                                    </div>
                                 </xsl:when>
                                 <xsl:otherwise>
                                    <div class="nodata diffs-attr-after">(circa)</div>
                                 </xsl:otherwise>
                              </xsl:choose>
                           </xsl:when>
                           <xsl:otherwise>
                              <xsl:choose>
                                 <xsl:when test="string-length(string-join(vra:dates/vra:latestDate/@circa,'')) != 0">
                                    <div title="circa">
                                       <xsl:apply-templates select="vra:dates/vra:latestDate/@circa"></xsl:apply-templates>
                                    </div>
                                 </xsl:when>
                                 <xsl:otherwise>
                                    <div class="nodata">(circa)</div>
                                 </xsl:otherwise>
                              </xsl:choose>
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
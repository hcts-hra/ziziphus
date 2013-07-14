<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:vra="http://www.vraweb.org/vracore4.htm"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
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
                              <div class="diffs-attr-before">
                                 <xsl:choose>
                                    <xsl:when test="string-length(string-join(@diff:attr-before-type,'')) != 0">
                                       <div data-bf-type="select1" data-bf-bind="@type" tabindex="0" title="Type"
                                            id="b-d2e924">
                                          <xsl:value-of select="@diff:attr-before-type"></xsl:value-of>
                                       </div>
                                    </xsl:when>
                                    <xsl:otherwise>
                                       <div class="nodata" data-bf-type="select1" data-bf-bind="@type" tabindex="0">(Type)</div>
                                    </xsl:otherwise>
                                 </xsl:choose>
                              </div>
                              <div class="diffs-attr-after">
                                 <xsl:choose>
                                    <xsl:when test="string-length(string-join(@diff:attr-after-type,'')) != 0">
                                       <div data-bf-type="select1" data-bf-bind="@type" tabindex="0" title="Type"
                                            id="b-d2e924">
                                          <xsl:value-of select="@diff:attr-after-type"></xsl:value-of>
                                       </div>
                                    </xsl:when>
                                    <xsl:otherwise>
                                       <div class="nodata" data-bf-type="select1" data-bf-bind="@type" tabindex="0">(Type)</div>
                                    </xsl:otherwise>
                                 </xsl:choose>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <xsl:choose>
                                 <xsl:when test="string-length(string-join(@type,'')) != 0">
                                    <div data-bf-type="select1" data-bf-bind="@type" tabindex="0" title="Type"
                                         id="b-d2e924">
                                       <xsl:value-of select="@type"></xsl:value-of>
                                    </div>
                                 </xsl:when>
                                 <xsl:otherwise>
                                    <div class="nodata" data-bf-type="select1" data-bf-bind="@type" tabindex="0">(Type)</div>
                                 </xsl:otherwise>
                              </xsl:choose>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="@diff:attr-before-count or @diff:attr-after-count">
                              <div class="diffs-attr-before">
                                 <xsl:choose>
                                    <xsl:when test="string-length(string-join(@diff:attr-before-count,'')) != 0">
                                       <div data-bf-type="input" data-bf-bind="@count" tabindex="0" title="count">
                                          <xsl:value-of select="@diff:attr-before-count"></xsl:value-of>
                                       </div>
                                    </xsl:when>
                                    <xsl:otherwise>
                                       <div class="nodata" data-bf-type="input" data-bf-bind="@count" tabindex="0">(count)</div>
                                    </xsl:otherwise>
                                 </xsl:choose>
                              </div>
                              <div class="diffs-attr-after">
                                 <xsl:choose>
                                    <xsl:when test="string-length(string-join(@diff:attr-after-count,'')) != 0">
                                       <div data-bf-type="input" data-bf-bind="@count" tabindex="0" title="count">
                                          <xsl:value-of select="@diff:attr-after-count"></xsl:value-of>
                                       </div>
                                    </xsl:when>
                                    <xsl:otherwise>
                                       <div class="nodata" data-bf-type="input" data-bf-bind="@count" tabindex="0">(count)</div>
                                    </xsl:otherwise>
                                 </xsl:choose>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <xsl:choose>
                                 <xsl:when test="string-length(string-join(@count,'')) != 0">
                                    <div data-bf-type="input" data-bf-bind="@count" tabindex="0" title="count">
                                       <xsl:value-of select="@count"></xsl:value-of>
                                    </div>
                                 </xsl:when>
                                 <xsl:otherwise>
                                    <div class="nodata" data-bf-type="input" data-bf-bind="@count" tabindex="0">(count)</div>
                                 </xsl:otherwise>
                              </xsl:choose>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="@diff:attr-before-num or @diff:attr-after-num">
                              <div class="diffs-attr-before">
                                 <xsl:choose>
                                    <xsl:when test="string-length(string-join(@diff:attr-before-num,'')) != 0">
                                       <div data-bf-type="input" data-bf-bind="@num" tabindex="0" title="num">
                                          <xsl:value-of select="@diff:attr-before-num"></xsl:value-of>
                                       </div>
                                    </xsl:when>
                                    <xsl:otherwise>
                                       <div class="nodata" data-bf-type="input" data-bf-bind="@num" tabindex="0">(num)</div>
                                    </xsl:otherwise>
                                 </xsl:choose>
                              </div>
                              <div class="diffs-attr-after">
                                 <xsl:choose>
                                    <xsl:when test="string-length(string-join(@diff:attr-after-num,'')) != 0">
                                       <div data-bf-type="input" data-bf-bind="@num" tabindex="0" title="num">
                                          <xsl:value-of select="@diff:attr-after-num"></xsl:value-of>
                                       </div>
                                    </xsl:when>
                                    <xsl:otherwise>
                                       <div class="nodata" data-bf-type="input" data-bf-bind="@num" tabindex="0">(num)</div>
                                    </xsl:otherwise>
                                 </xsl:choose>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <xsl:choose>
                                 <xsl:when test="string-length(string-join(@num,'')) != 0">
                                    <div data-bf-type="input" data-bf-bind="@num" tabindex="0" title="num">
                                       <xsl:value-of select="@num"></xsl:value-of>
                                    </div>
                                 </xsl:when>
                                 <xsl:otherwise>
                                    <div class="nodata" data-bf-type="input" data-bf-bind="@num" tabindex="0">(num)</div>
                                 </xsl:otherwise>
                              </xsl:choose>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:description,'')) != 0">
                              <div data-bf-type="input" data-bf-bind="vra:description" tabindex="0"
                                   title="Description"
                                   id="b-d2e880">
                                 <xsl:apply-templates select="vra:description"></xsl:apply-templates>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="input" data-bf-bind="vra:description" tabindex="0">(Description)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:name,'')) != 0">
                              <div data-bf-type="input" data-bf-bind="vra:name" tabindex="0" title="Name"
                                   id="b-d2e896"
                                   class="elementName">
                                 <xsl:apply-templates select="vra:name"></xsl:apply-templates>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="input" data-bf-bind="vra:name" tabindex="0">(Name)</div>
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
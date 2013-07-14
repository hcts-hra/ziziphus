<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:vra="http://www.vraweb.org/vracore4.htm"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:diff="http://betterform.de/ziziphus/diff"
                version="2.0">
   <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes"
               omit-xml-declaration="no"></xsl:output>
   <xsl:template match="vra:locationSet">
      <xsl:param name="vraTableId"></xsl:param>
      <div class="simple" id="{$vraTableId}">
         <table class="vraSetView table table-striped">
            <tbody>
               <xsl:for-each select="vra:location">
                  <tr>
                     <xsl:call-template name="diff:insert-element-diff-class"></xsl:call-template>
                     <td>
                        <xsl:choose>
                           <xsl:when test="@diff:attr-before-type or @diff:attr-after-type">
                              <div class="diffs-attr-before">
                                 <xsl:choose>
                                    <xsl:when test="string-length(string-join(@diff:attr-before-type,'')) != 0">
                                       <div data-bf-type="select1" data-bf-bind="@type" tabindex="0" title="Type"
                                            id="b-d2e511">
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
                                            id="b-d2e511">
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
                                         id="b-d2e511">
                                       <xsl:value-of select="@type"></xsl:value-of>
                                    </div>
                                 </xsl:when>
                                 <xsl:otherwise>
                                    <div class="nodata" data-bf-type="select1" data-bf-bind="@type" tabindex="0">(Type)</div>
                                 </xsl:otherwise>
                              </xsl:choose>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:name,'')) != 0">
                              <div data-bf-type="input" data-bf-bind="vra:name" tabindex="0" title="Name"
                                   id="b-d2e484">
                                 <xsl:apply-templates select="vra:name"></xsl:apply-templates>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="input" data-bf-bind="vra:name" tabindex="0">(Name)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:name/@type,'')) != 0">
                              <div data-bf-type="select1" data-bf-bind="vra:name/@type" tabindex="0" title="Type"
                                   id="b-d2e491">
                                 <xsl:apply-templates select="vra:name/@type"></xsl:apply-templates>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="select1" data-bf-bind="vra:name/@type"
                                   tabindex="0">(Type)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:refid,'')) != 0">
                              <div data-bf-type="input" data-bf-bind="vra:refid" tabindex="0" title="Refid"
                                   id="b-d2e467">
                                 <xsl:apply-templates select="vra:refid"></xsl:apply-templates>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="input" data-bf-bind="vra:refid" tabindex="0">(Refid)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:refid/@type,'')) != 0">
                              <div data-bf-type="select1" data-bf-bind="vra:refid/@type" tabindex="0" title="Type"
                                   id="b-d2e474">
                                 <xsl:apply-templates select="vra:refid/@type"></xsl:apply-templates>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="select1" data-bf-bind="vra:refid/@type"
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
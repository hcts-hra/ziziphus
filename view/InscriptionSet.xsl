<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:vra="http://www.vraweb.org/vracore4.htm"
                version="2.0">
   <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes"
               omit-xml-declaration="no"></xsl:output>
   <xsl:preserve-space elements="vra:text"></xsl:preserve-space>
   <xsl:template match="vra:inscriptionSet">
      <xsl:param name="vraTableId"></xsl:param>
      <div class="simple" id="{$vraTableId}">
         <table class="vraSetView table table-striped">
            <tbody>
               <xsl:for-each select="vra:inscription">
                  <tr>
                     <td>
                        <table class="vraSetInnerRepeatView table">
                           <tbody>
                              <xsl:for-each select="vra:text">
                                 <tr>
                                    <td>
                                       <xsl:choose>
                                          <xsl:when test="string-length(string-join(@type,'')) != 0">
                                             <div xmlns="" class=" textType nodata" data-bf-type="select1" data-bf-bind="@type"
                                                  tabindex="0"
                                                  title="Type">
                                                <xsl:value-of xmlns="http://www.w3.org/1999/xhtml" select="@type"></xsl:value-of>
                                             </div>
                                          </xsl:when>
                                          <xsl:otherwise>
                                             <div class="nodata" data-bf-type="select1" data-bf-bind="@type" tabindex="0">(Type)</div>
                                          </xsl:otherwise>
                                       </xsl:choose>
                                    </td>
                                    <td>
                                       <xsl:choose>
                                          <xsl:when test="string-length(string-join(.,'')) != 0">
                                             <div class="textarea keepWhitespace" data-bf-type="textarea" data-bf-bind="."
                                                  tabindex="0"
                                                  title="Text">
                                                <xsl:if xmlns="" test="string-length() - string-length(translate(., '&#xA;', '')) &gt; 5">
                                                   <xsl:attribute name="data-expand">100%</xsl:attribute>
                                                   <xsl:attribute name="data-collapse">75px</xsl:attribute>
                                                </xsl:if>
                                                <xsl:value-of select="."></xsl:value-of>
                                             </div>
                                             <xsl:if xmlns="" test="string-length() - string-length(translate(., '&#xA;', '')) &gt; 5">
                                                <div class="expand">
                                                   <span class="fa fa-arrow-down"></span>
                                                   <span>Click to Read More</span>
                                                   <span class="fa fa-arrow-down"></span>
                                                </div>
                                                <div class="contract hide">
                                                   <span class="fa fa-arrow-up"></span>
                                                   <span>Click to Hide</span>
                                                   <span class="fa fa-arrow-up"></span>
                                                </div>
                                             </xsl:if>
                                          </xsl:when>
                                          <xsl:otherwise>
                                             <div class="textarea nodata keepWhitespace" data-bf-type="textarea" data-bf-bind="."
                                                  tabindex="0">
                                                <xsl:if xmlns="" test="string-length() - string-length(translate(., '&#xA;', '')) &gt; 5">
                                                   <xsl:attribute name="data-expand">100%</xsl:attribute>
                                                   <xsl:attribute name="data-collapse">75px</xsl:attribute>
                                                </xsl:if>(Text)
                                             </div>
                                             <xsl:if xmlns="" test="string-length() - string-length(translate(., '&#xA;', '')) &gt; 5">
                                                <div class="expand">
                                                   <span class="fa fa-arrow-down"></span>
                                                   <span>Click to Read More</span>
                                                   <span class="fa fa-arrow-down"></span>
                                                </div>
                                                <div class="contract hide">
                                                   <span class="fa fa-arrow-up"></span>
                                                   <span>Click to Hide</span>
                                                   <span class="fa fa-arrow-up"></span>
                                                </div>
                                             </xsl:if>
                                          </xsl:otherwise>
                                       </xsl:choose>
                                    </td>
                                 </tr>
                              </xsl:for-each>
                           </tbody>
                        </table>
                     </td>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:author,'')) != 0">
                              <div data-bf-type="input" data-bf-bind="vra:author" tabindex="0" title="Author"
                                   id="b-d2e665"
                                   class="Author-autocomplete">
                                 <xsl:value-of select="vra:author"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="input" data-bf-bind="vra:author" tabindex="0">(Author)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:position,'')) != 0">
                              <div data-bf-type="input" data-bf-bind="vra:position" tabindex="0" title="Position"
                                   id="b-d2e686">
                                 <xsl:value-of select="vra:position"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="input" data-bf-bind="vra:position" tabindex="0">(Position)</div>
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
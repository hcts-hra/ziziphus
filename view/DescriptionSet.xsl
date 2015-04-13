<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:vra="http://www.vraweb.org/vracore4.htm"
                version="2.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xhtml" omit-xml-declaration="no"
               version="1.0"></xsl:output>
   <xsl:strip-space elements="*"></xsl:strip-space>
   <xsl:preserve-space elements="vra:text"></xsl:preserve-space>
   <xsl:template match="vra:descriptionSet">
      <xsl:param name="vraTableId"></xsl:param>
      <div class="simple" id="{$vraTableId}">
         <table class="vraSetView table table-striped">
            <xsl:for-each xmlns="" select="vra:description">
               <tbody class="vraSetView">
                  <xsl:choose>
                     <xsl:when test="string-length(string-join(@type,'')) != 0">
                        <div data-bf-type="input" data-bf-bind="@type" tabindex="0" title="type">
                           <xsl:value-of select="@type"></xsl:value-of>
                        </div>
                     </xsl:when>
                     <xsl:otherwise>
                        <div class="nodata" data-bf-type="input" data-bf-bind="@type" tabindex="0">(type)</div>
                     </xsl:otherwise>
                  </xsl:choose>
                  <xsl:for-each select="vra:text">
                     <tr>
                        <td colspan="3">
                           <xsl:choose>
                              <xsl:when test="string-length(string-join(. ,'')) != 0">
                                 <div data-bf-type="textarea" data-bf-bind="vra:text" tabindex="0" title="Text"
                                      class="textarea keepWhitespace">
                                    <xsl:if test="string-length() - string-length(translate(., '&#xA;', '')) &gt; 5">
                                       <xsl:attribute name="data-expand">100%</xsl:attribute>
                                       <xsl:attribute name="data-collapse">75px</xsl:attribute>
                                    </xsl:if>
                                    <xsl:value-of select="."></xsl:value-of>
                                 </div>
                                 <xsl:if test="string-length() - string-length(translate(., '&#xA;', '')) &gt; 5">
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
                                 <div class="nodata" data-bf-type="textarea" data-bf-bind="vra:text" tabindex="0">(Text)</div>
                              </xsl:otherwise>
                           </xsl:choose>
                        </td>
                     </tr>
                  </xsl:for-each>
                  <xsl:for-each select="vra:author">
                     <xsl:if test="string-length(string-join(vra:name,'')) != 0 or string-length(string-join(vra:name/@type,'')) != 0 or string-length(string-join(vra:role,'')) != 0">
                        <tr>
                           <td>
                              <xsl:choose>
                                 <xsl:when test="string-length(string-join(vra:name,'')) != 0">
                                    <div data-bf-type="input" data-bf-bind="vra:name" tabindex="0" title="Name"
                                         class="Name-autocomplete">
                                       <xsl:value-of select="vra:name"></xsl:value-of>
                                    </div>
                                 </xsl:when>
                                 <xsl:otherwise>
                                    <div class="nodata" data-bf-type="input" data-bf-bind="vra:name" tabindex="0">(Name)</div>
                                 </xsl:otherwise>
                              </xsl:choose>
                           </td>
                           <td>
                              <xsl:choose>
                                 <xsl:when test="string-length(string-join(vra:name/@type,'')) != 0">
                                    <div data-bf-type="select1" data-bf-bind="vra:name/@type" tabindex="0" title="Type"
                                         class=" nameType">
                                       <xsl:value-of select="vra:name/@type"></xsl:value-of>
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
                                 <xsl:when test="string-length(string-join(vra:role,'')) != 0">
                                    <div data-bf-type="select1" data-bf-bind="vra:role" tabindex="0" title="Role">
                                       <xsl:variable name="role" select="vra:role"></xsl:variable>
                                       <xsl:value-of select="$role-codes-legend//item[value eq $role]/label"></xsl:value-of>
                                    </div>
                                 </xsl:when>
                                 <xsl:otherwise>
                                    <div class="nodata" data-bf-type="select1" data-bf-bind="vra:role" tabindex="0">(Role)</div>
                                 </xsl:otherwise>
                              </xsl:choose>
                           </td>
                        </tr>
                     </xsl:if>
                  </xsl:for-each>
               </tbody>
            </xsl:for-each>
         </table>
      </div>
   </xsl:template>
</xsl:stylesheet>
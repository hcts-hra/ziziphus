<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:vra="http://www.vraweb.org/vracore4.htm"
                version="2.0">
   <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes"
               omit-xml-declaration="no"></xsl:output>
   <xsl:preserve-space elements="vra:text"></xsl:preserve-space>
   <xsl:template match="vra:descriptionSet">
      <xsl:param name="vraTableId"></xsl:param>
      <div class="simple" id="{$vraTableId}">
         <table class="vraSetView table table-striped">
            <xsl:for-each xmlns="" select="vra:description">
               <tbody>
                  <table>
                     <tbody>
                        <tr xmlns="http://www.w3.org/1999/xhtml">
                           <td>
                              <xsl:choose>
                                 <xsl:when test="string-length(string-join(@type,'')) != 0">
                                    <div data-bf-type="input" data-bf-bind="@type" tabindex="0" title="type">
                                       <xsl:value-of select="@type"></xsl:value-of>
                                    </div>
                                 </xsl:when>
                                 <xsl:otherwise>
                                    <div class="nodata" data-bf-type="input" data-bf-bind="@type" tabindex="0"></div>
                                 </xsl:otherwise>
                              </xsl:choose>
                           </td>
                           <td>
                              <xsl:choose>
                                 <xsl:when test="string-length(string-join(vra:text,'')) != 0">
                                    <div data-bf-type="textarea" data-bf-bind="vra:text" tabindex="0" title="Text"
                                         id="b-d2e517">
                                       <xsl:value-of select="vra:text"></xsl:value-of>
                                    </div>
                                 </xsl:when>
                                 <xsl:otherwise>
                                    <div class="nodata" data-bf-type="textarea" data-bf-bind="vra:text" tabindex="0"></div>
                                 </xsl:otherwise>
                              </xsl:choose>
                           </td>
                           <td></td>
                        </tr>
                     </tbody>
                  </table>
               </tbody>
               <tbody>
                  <table xmlns="http://www.w3.org/1999/xhtml" class="vraSetInnerRepeatView table">
                     <tbody>
                        <xsl:for-each select="vra:author">
                           <tr>
                              <td>
                                 <xsl:choose>
                                    <xsl:when test="string-length(string-join(vra:name,'')) != 0">
                                       <div data-bf-type="input" data-bf-bind="vra:name" tabindex="0" title="Name"
                                            id="b-d2e541"
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
                                            id="b-d2e548"
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
                        </xsl:for-each>
                     </tbody>
                  </table>
               </tbody>
            </xsl:for-each>
         </table>
      </div>
   </xsl:template>
</xsl:stylesheet>
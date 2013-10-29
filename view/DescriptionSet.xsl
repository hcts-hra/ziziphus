<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:vra="http://www.vraweb.org/vracore4.htm"
                version="2.0">
   <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes"
               omit-xml-declaration="no"></xsl:output>
   <xsl:template match="vra:descriptionSet">
      <xsl:param name="vraTableId"></xsl:param>
      <div class="simple" id="{$vraTableId}">
         <table class="vraSetView table table-striped">
            <tbody>
               <xsl:for-each select="vra:description">
                  <tr>
                     <td>
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
                     </td>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:text,'')) != 0">
                              <div data-bf-type="input" data-bf-bind="vra:text" tabindex="0" title="Text"
                                   id="b-d2e403">
                                 <xsl:value-of select="vra:text"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="input" data-bf-bind="vra:text" tabindex="0">(Text)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:author/vra:name,'')) != 0">
                              <div data-bf-type="input" data-bf-bind="vra:author/vra:name" tabindex="0"
                                   title="Name"
                                   id="b-d2e412">
                                 <xsl:value-of select="vra:author/vra:name"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="input" data-bf-bind="vra:author/vra:name"
                                   tabindex="0">(Name)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:author/vra:name/@type,'')) != 0">
                              <div data-bf-type="select1" data-bf-bind="vra:author/vra:name/@type" tabindex="0"
                                   title="Type"
                                   id="b-d2e419">
                                 <xsl:value-of select="vra:author/vra:name/@type"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="select1" data-bf-bind="vra:author/vra:name/@type"
                                   tabindex="0">(Type)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:author/vra:role,'')) != 0">
                              <div data-bf-type="input" data-bf-bind="vra:author/vra:role" tabindex="0"
                                   title="Role"
                                   id="b-d2e434">
                                 <xsl:value-of select="vra:author/vra:role"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="input" data-bf-bind="vra:author/vra:role"
                                   tabindex="0">(Role)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:author/vra:role/@type,'')) != 0">
                              <div data-bf-type="select1" data-bf-bind="vra:author/vra:role/@type" tabindex="0"
                                   title="Type"
                                   id="b-d2e442">
                                 <xsl:value-of select="vra:author/vra:role/@type"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="select1" data-bf-bind="vra:author/vra:role/@type"
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
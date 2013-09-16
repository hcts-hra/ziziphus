<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:vra="http://www.vraweb.org/vracore4.htm" xmlns:html="http://www.w3.org/1999/xhtml" version="2.0">
   <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"></xsl:output>
   <xsl:template match="vra:locationSet">
      <xsl:param name="vraTableId"></xsl:param>
      <div class="simple" id="{$vraTableId}">
         <table class="vraSetView table table-striped">
            <tbody>
               <xsl:for-each select="vra:location">
                  <tr>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(@type,'')) != 0">
                              <div data-bf-type="select1" data-bf-bind="@type" tabindex="0" title="Type" id="b-d2e661">
                                 <xsl:value-of select="@type"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="select1" data-bf-bind="@type" tabindex="0">(Type)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:name,'')) != 0">
                              <div data-bf-type="input" data-bf-bind="vra:name" tabindex="0" title="Name" id="b-d2e615">
                                 <xsl:value-of select="vra:name"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="input" data-bf-bind="vra:name" tabindex="0">(Name)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:name/@type,'')) != 0">
                              <div data-bf-type="select1" data-bf-bind="vra:name/@type" tabindex="0" title="Type" id="b-d2e622">
                                 <xsl:value-of select="vra:name/@type"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="select1" data-bf-bind="vra:name/@type" tabindex="0">(Type)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:refid,'')) != 0">
                              <div data-bf-type="input" data-bf-bind="vra:refid" tabindex="0" title="Refid" id="b-d2e593">
                                 <xsl:value-of select="vra:refid"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="input" data-bf-bind="vra:refid" tabindex="0">(Refid)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:refid/@type,'')) != 0">
                              <div data-bf-type="select1" data-bf-bind="vra:refid/@type" tabindex="0" title="Type" id="b-d2e600">
                                 <xsl:value-of select="vra:refid/@type"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="select1" data-bf-bind="vra:refid/@type" tabindex="0">(Type)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:point/@epsg,'')) != 0">
                              <div data-bf-type="input" data-bf-bind="vra:point/@epsg" tabindex="0" title="epsg">
                                 <xsl:value-of select="vra:point/@epsg"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="input" data-bf-bind="vra:point/@epsg" tabindex="0">(epsg)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:point/@url,'')) != 0">
                              <div data-bf-type="input" data-bf-bind="vra:point/@url" tabindex="0" title="url">
                                 <xsl:value-of select="vra:point/@url"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="input" data-bf-bind="vra:point/@url" tabindex="0">(url)</div>
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
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
                              <div data-bf-type="textarea" data-bf-bind="vra:text" tabindex="0" title="Text"
                                   id="b-d2e486">
                                 <xsl:value-of select="vra:text"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="textarea" data-bf-bind="vra:text" tabindex="0">(Text)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                     <td></td>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:name,'')) != 0">
                              <div data-bf-type="input" data-bf-bind="vra:name" tabindex="0" title="Name"
                                   id="b-d2e510"
                                   class="Name-autocomplete">
                                 <xsl:value-of select="vra:name"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="input" data-bf-bind="vra:name" tabindex="0">(Name)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:name/@type,'')) != 0">
                              <div data-bf-type="select1" data-bf-bind="vra:name/@type" tabindex="0" title="Type"
                                   id="b-d2e517"
                                   class=" nameType">
                                 <xsl:value-of select="vra:name/@type"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="select1" data-bf-bind="vra:name/@type"
                                   tabindex="0">(Type)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:role,'')) != 0">
                              <div data-bf-type="input" data-bf-bind="vra:role" tabindex="0" title="Role"
                                   id="b-d2e532">
                                 <xsl:variable name="role" select="vra:role"></xsl:variable>
                                 <xsl:value-of select="$role-codes-legend//item[value eq $role]/label"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="input" data-bf-bind="vra:role" tabindex="0">(Role)</div>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(vra:role/@type,'')) != 0">
                              <div data-bf-type="select1" data-bf-bind="vra:role/@type" tabindex="0" title="Type"
                                   id="b-d2e539"
                                   class=" roleType"></div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-type="select1" data-bf-bind="vra:role/@type"
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
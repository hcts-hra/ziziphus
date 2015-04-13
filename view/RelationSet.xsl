<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:vra="http://www.vraweb.org/vracore4.htm"
                version="2.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xhtml" omit-xml-declaration="no"
               version="1.0"></xsl:output>
   <xsl:strip-space elements="*"></xsl:strip-space>
   <xsl:preserve-space elements="vra:text"></xsl:preserve-space>
   <xsl:template match="vra:relationSet">
      <xsl:param name="vraTableId"></xsl:param>
      <div class="simple" id="{$vraTableId}">
         <table class="vraSetView table table-striped">
            <tbody>
               <xsl:for-each select="vra:relation">
                  <tr>
                     <td>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(@type,'')) != 0">
                              <div data-bf-bind="@type" data-bf-type="select1" tabindex="0" title=""
                                   id="b-d2e1051"
                                   class=" ">
                                 <xsl:value-of select="@type"></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-bind="@type" data-bf-type="select1" tabindex="0">
                                 <xsl:value-of select="normalize-space(concat('(', $language-files/language/relationSet/relation/type/label, ')'))"></xsl:value-of>
                              </div>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(.,'')) != 0">
                              <div data-bf-bind="." data-bf-type="input" tabindex="0" title="" id="b-d2e1043">
                                 <xsl:value-of select="."></xsl:value-of>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-bind="." data-bf-type="input" tabindex="0">
                                 <xsl:value-of select="normalize-space(concat('(', $language-files/language/relationSet/relation/label, ')'))"></xsl:value-of>
                              </div>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                           <xsl:when test="string-length(string-join(@relids,'')) != 0">
                              <div data-bf-bind="@relids" data-bf-type="input" tabindex="0" title="">
                                 <img xmlns="">
                                    <xsl:attribute name="src"
                                                   select="concat('/exist/apps/ziziphus/imageService/?imagerecord=', @relids)"></xsl:attribute>
                                    <xsl:attribute name="alt" select="@relids"></xsl:attribute>
                                    <xsl:attribute name="class" select="relationSetImage"></xsl:attribute>
                                 </img>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div class="nodata" data-bf-bind="@relids" data-bf-type="input" tabindex="0">
                                 <xsl:value-of select="normalize-space(concat('(', $language-files/language/relationSet/relation/relids/label, ')'))"></xsl:value-of>
                              </div>
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
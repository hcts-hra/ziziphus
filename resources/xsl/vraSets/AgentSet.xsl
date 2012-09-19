<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ev="http://www.w3.org/2001/xml-events" xmlns:vra="http://www.vraweb.org/vracore4.htm" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xf="http://www.w3.org/2002/xforms" xmlns:bfn="http://www.betterform.de/XSL/Functions" version="2.0" xpath-default-namespace="http://www.w3.org/2002/xforms" exclude-result-prefixes="bfn">
    <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>
    <xsl:template match="vra:agentSet" priority="40">
        <xsl:param name="tableId"/>
            <table id="{$tableId}" class="table table-condensed simpleView">
                <thead>
                    <tr>
                        <th>Role</th>
                        <th>Name</th>
                        <th/>
                    </tr>
                </thead>
                <tbody>
                    <xsl:for-each select="vra:agent">
                        <tr>
                            <td>
                                <xsl:value-of select="bfn:upperCase(vra:role)"/>
                            </td>
                            <td>
                                <xsl:value-of select="bfn:upperCase(vra:name)"/>
                                <xsl:if test="(vra:birth/vra:year) or (vra:death/vra:year)">
                                    <xsl:text> (</xsl:text>
                                    <xsl:value-of select="vra:birth/vra:year"/>
                                    <xsl:text>-</xsl:text>
                                    <xsl:value-of select="vra:death/vra:year"/>
                                    <xsl:text>)</xsl:text>
                                </xsl:if>
                                <div class="detail">
                                    <xsl:value-of select="concat('(', vra:name/@type , ')', ' ' , vra:culture)"/>
                                </div>
                            </td>
                            <td>
                                <div class="detail">
                                    <xsl:value-of select="vra:name/@vocab "/>
                                </div>
                            </td>
                        </tr>
                    </xsl:for-each>
                </tbody>
            </table>

            <xsl:call-template name="renderVraNotes"/>

            <!--
            <span class="vraNode vraDisplay">
                <xsl:value-of select="vra:display"/>
            </span>
            <span class="vraNode vraNotes">
                <xsl:value-of select="vra:notes"/>
            </span>
            -->
    </xsl:template>
</xsl:stylesheet>
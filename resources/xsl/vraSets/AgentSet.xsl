<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ev="http://www.w3.org/2001/xml-events" xmlns:vra="http://www.vraweb.org/vracore4.htm" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xf="http://www.w3.org/2002/xforms" xmlns:bfn="http://www.betterform.de/XSL/Functions" version="2.0" xpath-default-namespace="http://www.w3.org/2002/xforms" exclude-result-prefixes="bfn">
    <xsl:output method="xhtml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>
    <xsl:template match="vra:agentSet" priority="40">
        <div class="vraSection">
            <table class="table table-condensed">
                <thead>
                    <tr>
                        <th>Role</th>
                        <th>Name</th>
                    </tr>
                </thead>
                <tbody>
                    <xsl:for-each select="vra:agent">
                        <tr class="vraRepeated vraAgent">
                            <td>
                                <xsl:value-of select="concat(upper-case(substring(vra:role,1,1)),substring(vra:role,2))"/>
                            </td>
                            <td>
                                <xsl:value-of select="concat(upper-case(substring(vra:name,1,1)),substring(vra:name,2))"/>
                            </td>
                        </tr>
                    </xsl:for-each>
                </tbody>
            </table>
            <!--
            <span class="vraNode vraDisplay">
                <xsl:value-of select="vra:display"/>
            </span>
            <span class="vraNode vraNotes">
                <xsl:value-of select="vra:notes"/>
            </span>
            -->
        </div>
    </xsl:template>
</xsl:stylesheet>
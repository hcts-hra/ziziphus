<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:vra="http://www.vraweb.org/vracore4.htm"
                xmlns:xf="http://www.w3.org/2002/xforms"
                xmlns:ev="http://www.w3.org/2001/xml-events"
                xmlns:bf="http://betterform.sourceforge.net/xforms"
                xmlns:bfc="http://betterform.sourceforge.net/xforms/controls"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xmlns:transform="boohoo"
                >

    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>

    <xsl:namespace-alias stylesheet-prefix="transform" result-prefix="xsl"/>

    <xsl:strip-space elements="*"/>

<!--
    ########################################################################################
        EXTERNAL PARAMETERS
    ########################################################################################
-->
    <xsl:param name="debug" select="'TAKEN_FROM_BUILD.XML'" as="xsd:string"/>

    <!--
        ########################################################################################
            GLOBAL VARIABLES
        ########################################################################################
    -->

    <xsl:variable name="debugEnabled" as="xsd:boolean">
        <xsl:choose>
            <xsl:when test="$debug eq 'true' or $debug eq 'true()' or number($debug) gt 0">true</xsl:when>
            <xsl:otherwise>false</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:template match="/">
        <!-- generate XSL stylesheet skeleton -->
        <xsl:text>
</xsl:text>
        <xsl:element name="xsl:stylesheet" namespace="http://www.w3.org/1999/XSL/Transform">
            <xsl:attribute name="version">2.0</xsl:attribute>
            <xsl:text>
</xsl:text>
            <transform:output method="xml" version="1.0"/><xsl:text>
    </xsl:text>

            <transform:preserve-space elements="untagged"/><xsl:text>
</xsl:text>

            <transform:strip-space elements="*"/><xsl:text>
</xsl:text>


            <transform:template match="vra:dates" priority="40">
                <transform:if test="(vra:earliestDate) or (vra:latestDate)">
                    <transform:value-of select="vra:earliestDate"/>
                    <transform:text>-</transform:text>
                    <transform:value-of select="vra:latestDate"/>
                </transform:if>
            </transform:template>            
            
            <transform:template match="vra:agentSet" priority="40"><xsl:text>
</xsl:text>
                <!-- START FOR DEBUGGING PURPOSE ONLY -->
                <!--
                                <transform:result-document href="DUMP_{$styleSheetname}_IN.xml" encoding="UTF-8">
                                        <transform:copy-of select="."/>
                                </transform:result-document>
                -->
                <!-- END FOR DEBUGGING PURPOSE ONLY -->



                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Role</th>
                            <th>Culture</th>
                            <th class="detail-cell">Period (life)</th>
                            <th>Period (activity)</th>
                            <th class="detail-cell">Period (other)</th>
                        </tr>
                    </thead>
                    <tbody resource="vra:agentSet">
                        <transform:for-each select="vra:agent">
                            <tr property="vra:agent">
                                <transform:variable name="ref">
                                    <transform:call-template name="getRef"/>
                                </transform:variable>
                                <td property="vra:name" data-xf-ref="{{$ref}}" contenteditable="true">
                                    <!-- todo: all to all sets -->
                                    <transform:if test="vra:name/@pref='true'">
                                        <transform:attribute name="class">pref</transform:attribute>
                                    </transform:if>
                                    <transform:value-of select="bfn:upperCase(vra:name)"/>
                                </td>
                                <td property="vra:role" contenteditable="true">
                                    <transform:value-of select="bfn:upperCase(vra:role)"/>
                                </td>
                                <td property="vra:culture" contenteditable="true">
                                    <transform:value-of select="vra:culture"/>
                                </td>
                                <td class="detail-cell" property="vra:dates[@type='life']" contenteditable="true">
                                    <transform:apply-templates select="vra:dates[@type='life']"/>
                                </td>
                                <td property="vra:dates[@type='activity']" contenteditable="true">
                                    <transform:apply-templates select="vra:dates[@type='activity']"/>
                                </td>
                                <td class="detail-cell" property="vra:dates[@type='other']" contenteditable="true">
                                    <transform:apply-templates select="vra:dates[@type='other']"/>
                                </td>
                            </tr>
                        </transform:for-each>
                    </tbody>
                </table>
            </transform:template>

            <transform:template name="getRef">
                <transform:for-each select="ancestor-or-self::node()[@property]">
                    <transform:value-of select="@property"/>/
                </transform:for-each>
            </transform:template>
            
        </xsl:element>
    </xsl:template>



</xsl:stylesheet>
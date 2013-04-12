<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:html="http://www.w3.org/1999/xhtml" xmlns="http://www.w3.org/1999/xhtml" xmlns:vra="http://www.vraweb.org/vracore4.htm" version="2.0">
    <xsl:output method="xhtml" omit-xml-declaration="yes"></xsl:output>
    <xsl:template match="vra:agentSet">
        <html>
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
                <title>Ziziphus_Image_DB</title>
            </head>
            <body>
                <table class="vraSetView table table-striped">
                    <tbody>
                        <xsl:for-each select="vra:agent">
                            <tr>
                                <td>
                                    <div id="d3e512-Name" data-bf-type="input" data-bf-bind="vra:name" contenteditable="true">
                                        <xsl:choose>
                                            <xsl:when test="string-length(vra:name) != 0">
                                                <xsl:value-of select="vra:name"></xsl:value-of>
                                            </xsl:when>
                                            <xsl:otherwise><span class="detail"><a href="#">+</a></span></xsl:otherwise>
                                        </xsl:choose>
                                    </div>
                                    <div id="d6e36-Type" data-bf-type="select1" data-bf-bind="vra:name/@type" contenteditable="true">
                                        <xsl:choose>
                                            <xsl:when test="string-length(vra:name/@type) != 0">
                                                <xsl:value-of select="vra:name/@type"></xsl:value-of>
                                            </xsl:when>
                                            <xsl:otherwise><span class="detail"><a href="#">+</a></span></xsl:otherwise>
                                        </xsl:choose>
                                    </div>
                                </td>
                                <td>
                                    <div id="d3e504-Attribution" data-bf-type="input" data-bf-bind="vra:attribution" contenteditable="true">
                                        <xsl:choose>
                                            <xsl:when test="string-length(vra:attribution) != 0">
                                                <xsl:value-of select="vra:attribution"></xsl:value-of>
                                            </xsl:when>
                                            <xsl:otherwise><span class="detail"><a href="#">+</a></span></xsl:otherwise>
                                        </xsl:choose>
                                    </div>
                                </td>
                                <td>
                                    <div id="d3e505-Culture" data-bf-type="input" data-bf-bind="vra:culture" contenteditable="true">
                                        <xsl:choose>
                                            <xsl:when test="string-length(vra:culture) != 0">
                                                <xsl:value-of select="vra:culture"></xsl:value-of>
                                            </xsl:when>
                                            <xsl:otherwise><span class="detail"><a href="#">+</a></span></xsl:otherwise>
                                        </xsl:choose>
                                    </div>
                                </td>
                                <td>
                                    <div id="d6e31-Type" data-bf-type="select1" data-bf-bind="vra:dates/@type" contenteditable="true">
                                        <xsl:choose>
                                            <xsl:when test="string-length(vra:dates/@type) != 0">
                                                <xsl:value-of select="vra:dates/@type"></xsl:value-of>
                                            </xsl:when>
                                            <xsl:otherwise><span class="detail"><a href="#">+</a></span></xsl:otherwise>
                                        </xsl:choose>
                                    </div>
                                    <div id="d3e508-EarliestDate" data-bf-type="input" data-bf-bind="vra:dates/vra:earliestDate" contenteditable="true">
                                        <xsl:choose>
                                            <xsl:when test="string-length(vra:dates/vra:earliestDate) != 0">
                                                <xsl:value-of select="vra:dates/vra:earliestDate"></xsl:value-of>
                                            </xsl:when>
                                            <xsl:otherwise><span class="detail"><a href="#">+</a></span></xsl:otherwise>
                                        </xsl:choose>
                                    </div>
                                    <div id="" data-bf-type="input" data-bf-bind="vra:dates/vra:earliestDate/@circa" contenteditable="true">
                                        <xsl:choose>
                                            <xsl:when test="string-length(vra:dates/vra:earliestDate/@circa) != 0">
                                                <xsl:value-of select="vra:dates/vra:earliestDate/@circa"></xsl:value-of>
                                            </xsl:when>
                                            <xsl:otherwise><span class="detail"><a href="#">+</a></span></xsl:otherwise>
                                        </xsl:choose>
                                    </div>
                                    <div id="d3e510-LatestDate" data-bf-type="input" data-bf-bind="vra:dates/vra:latestDate" contenteditable="true">
                                        <xsl:choose>
                                            <xsl:when test="string-length(vra:dates/vra:latestDate) != 0">
                                                <xsl:value-of select="vra:dates/vra:latestDate"></xsl:value-of>
                                            </xsl:when>
                                            <xsl:otherwise><span class="detail"><a href="#">+</a></span></xsl:otherwise>
                                        </xsl:choose>
                                    </div>
                                    <div id="" data-bf-type="input" data-bf-bind="vra:dates/vra:latestDate/@circa" contenteditable="true">
                                        <xsl:choose>
                                            <xsl:when test="string-length(vra:dates/vra:latestDate/@circa) != 0">
                                                <xsl:value-of select="vra:dates/vra:latestDate/@circa"></xsl:value-of>
                                            </xsl:when>
                                            <xsl:otherwise><span class="detail"><a href="#">+</a></span></xsl:otherwise>
                                        </xsl:choose>
                                    </div>
                                </td>
                                <td>
                                    <div id="d3e514-Role" data-bf-type="input" data-bf-bind="vra:role" contenteditable="true">
                                        <xsl:choose>
                                            <xsl:when test="string-length(vra:role) != 0">
                                                <xsl:value-of select="vra:role"></xsl:value-of>
                                            </xsl:when>
                                            <xsl:otherwise><span class="detail"><a href="#">+</a></span></xsl:otherwise>
                                        </xsl:choose>
                                    </div>
                                </td>
                            </tr>
                        </xsl:for-each>
                    </tbody>
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
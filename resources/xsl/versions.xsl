<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:v="http://exist-db.org/versioning"
	xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="xml" version="1.0"/>
    
    <!-- Should result be a full HTML document ('yes') or only content to be placed into a div ('no'). -->
    <xsl:param name="ajax" select="'no'"/>
    
    <xsl:variable name="path" select="/result/file/@path"/>
    
    <xsl:template match="/">
        <xsl:choose>
            <xsl:when test="$ajax = 'yes'">
                <xsl:apply-templates select="result" mode="ajax"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="result" mode="full-html"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="result" mode="full-html">
        <html>
            <head>
                <title>
                    <xsl:text>File history for </xsl:text>
                    <xsl:value-of select="$path"/>
                </title>
                <xsl:call-template name="css"/>
            </head>
            <body>
                <h1>File versions history</h1>
                <p>Path = <xsl:value-of select="$path"/></p>
                <xsl:apply-templates />
            </body>
        </html>    
    </xsl:template>
    
    <xsl:template match="result" mode="ajax">
        <div id="versions-body">
            <xsl:apply-templates />
        </div>
    </xsl:template>
    
    <xsl:template match="error">
        <p class="error">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="file">
        <div class="history">
            <xsl:apply-templates>
                <xsl:with-param name="path" select="@path"/>
            </xsl:apply-templates>
        </div>
    </xsl:template>
    <xsl:template match="v:document">
		<!-- Ignored to avoid double printing of paths. -->
    </xsl:template>
    <xsl:template match="v:revisions">
        <xsl:param name="path"/>
        <xsl:choose>
            <xsl:when test="v:revision">
                <table class="table table-stripped revisions">
                    <tr>
                        <th>Revision nr</th>
                        <th>Date</th>
                        <th>User</th>
                        <th>Resources</th>
                    </tr>
                    <xsl:call-template name="revision">
                        <xsl:with-param name="path" select="$path"/>
                        <xsl:with-param name="rev">0</xsl:with-param>
                    </xsl:call-template>
                    <xsl:apply-templates select="v:revision">
                        <xsl:with-param name="path" select="$path"/>
                    </xsl:apply-templates>
                </table>
            </xsl:when>
            <xsl:otherwise>
                <p>No revisions recorded.</p>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Template creates one table row. It can be applied for 'v:revision' element
         or called by name 'revision', in which case revision number should be given
         by parameter $rev. -->
    <xsl:template match="v:revision" name="revision">
        <xsl:param name="path"/>
        <xsl:param name="rev" select="@rev"/>
        <xsl:variable name="versions-xql">/exist/admin/versions.xql</xsl:variable>
        
        <tr>
            <td>
                <xsl:value-of select="$rev"/>
            </td>
            <td>
                <xsl:apply-templates select="v:date"/>
            </td>
            <td>
                <xsl:apply-templates select="v:user"/>
            </td>
            <td>
                <a href="{$versions-xql}?action=restore&amp;rev={$rev}&amp;resource={$path}">content</a>
                <xsl:text>, </xsl:text>
                <a href="{$versions-xql}?action=diff&amp;rev={$rev}&amp;resource={$path}">diff</a>
                <xsl:text>, </xsl:text>
                <a href="{$versions-xql}?action=annotate&amp;rev={$rev}&amp;resource={$path}">annotation</a>
            </td>
        </tr>
    </xsl:template>
    <xsl:template name="css">
        <style type="text/css">
<![CDATA[
body {
	font-size: 10pt;
	background-color: #DDDDDD;
}

#versions-body {
    font-size: 8pt;
	background-color: #FFFFFF;
    padding: 1em 2em;
}

.id {
	font-family: 'Arial', sans-serif;
	color: green;
}

table.revisions {
	border-collapse: collapse;
}

table.revisions th, table.revisions td {
	text-align: center;
	padding: 1px 2px;
	border-style: solid;
	border-color: black;
	border-width: 1px;
}

table.revisions th {
	background-color: #CCCCCC;
}

table.revisions td {
	background-color: #FFFFFF;
}]]>
</style>
    </xsl:template>
</xsl:stylesheet>
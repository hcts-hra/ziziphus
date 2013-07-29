<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:v="http://exist-db.org/versioning">

	<xsl:output method="xml" version="1.0" />

	<!-- Is result to be pasted in a div in AJAX style ('yes') or should it 
		be a regular HTML document ('no'). -->
	<xsl:param name="ajax" select="'no'" />

	<xsl:variable name="path" select="/result/file/@path" />
	<xsl:variable name="versions-xql">/exist/admin/versions.xql</xsl:variable>
	<xsl:variable name="diff">show-diff.html</xsl:variable>
	<xsl:variable name="xqdiff">modules/diff.xql</xsl:variable>

	<xsl:template match="/">
		<xsl:choose>
			<xsl:when test="$ajax = 'yes'">
				<xsl:apply-templates select="result" mode="ajax" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="result" mode="full-html" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="result" mode="full-html">
		<html>
			<head>
				<title>
					<xsl:text>File history for </xsl:text>
					<xsl:value-of select="$path" />
				</title>
				<xsl:call-template name="css" />
			</head>
			<body>
				<h1>File versions history</h1>
				<p>Path = <code><xsl:value-of select="$path" /></code></p>
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
			<xsl:apply-templates />
		</p>
	</xsl:template>

	<xsl:template match="file">
		<div class="history">
			<xsl:apply-templates>
				<xsl:with-param name="path" select="@path" />
			</xsl:apply-templates>
		</div>
	</xsl:template>

	<xsl:template match="v:document">
		<!-- Ignored to avoid double printing of paths. -->
	</xsl:template>

	<xsl:template match="v:revisions">
		<xsl:param name="path" />
		<xsl:variable name="last-rev" select="v:revision[last()]/@rev" />
		<xsl:choose>
			<xsl:when test="v:revision">
				<table class="table table-stripped revisions">
					<tr>
						<th rowspan="2">Revision nr</th>
						<th rowspan="2">Date</th>
						<th rowspan="2">User</th>
						<th colspan="3" style="text-align: center">Resources</th>
					</tr>
					<tr>
						<th>eXistDB</th>
						<th>Formatted changes</th>
						<th>XML source changes</th>
					</tr>
					<xsl:call-template name="revision">
						<xsl:with-param name="path" select="$path" />
						<xsl:with-param name="rev">0</xsl:with-param>
						<xsl:with-param name="prev-rev" select="'empty'" />
					</xsl:call-template>
					<xsl:apply-templates select="v:revision">
						<xsl:with-param name="path" select="$path" />
					</xsl:apply-templates>
				</table>
			</xsl:when>
			<xsl:otherwise>
				<p>No revisions recorded.</p>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- Template creates one table row. It can be applied for 'v:revision' 
		element or called by name 'revision', in which case revision number should 
		be given by parameter $rev. -->
	<xsl:template match="v:revision" name="revision">
		<xsl:param name="path" />
		<xsl:param name="rev" select="@rev" />
		<xsl:param name="prev-rev">
			<xsl:choose>
				<xsl:when test="preceding-sibling::v:revision[1]/@rev">
					<xsl:value-of select="preceding-sibling::v:revision[1]/@rev" />
				</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:param>
		<tr>
			<td>
				<xsl:value-of select="$rev" />
			</td>
			<xsl:choose>
				<xsl:when test="self::v:revision">
					<td>
						<xsl:apply-templates select="v:date" />
					</td>
					<td>
						<xsl:apply-templates select="v:user" />
					</td>
				</xsl:when>
				<xsl:otherwise>
					<td colspan="2"
						title="First recorded revision or last version known before versioning was configured in eXist-DB.">Initial version</td>
				</xsl:otherwise>
			</xsl:choose>
			<td>
				<a href="{$versions-xql}?action=restore&amp;rev={$rev}&amp;resource={$path}"
					target="_blank" title="XML content of that revision.">content</a>
				<xsl:text>, </xsl:text><br/>
				<a href="{$versions-xql}?action=diff&amp;rev={$rev}&amp;resource={$path}"
					target="_blank" title="eXistsDB-provided diffs recorded in that revision.">diff</a>
			</td>
			<td>
				<a href="{$xqdiff}?resource={$path}&amp;rev1={$prev-rev}&amp;rev2={$rev}"
					target="_blank" title="Formatted content changes recorded in that revision.">changes</a>
				<xsl:text>, </xsl:text><br/>
				<a href="{$xqdiff}?resource={$path}&amp;rev1={$rev}&amp;rev2=last"
					target="_blank" title="Formatted content changes since that revision until now.">changes since then</a>
			</td>
			<td>
				<a href="{$diff}?resource={$path}&amp;rev1={$prev-rev}&amp;rev2={$rev}"
					target="_blank"
					title="Presetation of XML-source changes recorded in that revision.">changes</a>
				<xsl:text>, </xsl:text><br/>
				<a href="{$diff}?resource={$path}&amp;rev1={$rev}&amp;rev2=last"
					target="_blank"
					title="Presetation of XML-source changes since that revision until now.">changes since then</a>
			</td>
		</tr>
	</xsl:template>
	<xsl:template name="css">
		<style type="text/css"><![CDATA[
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
}
		]]></style>
	</xsl:template>
</xsl:stylesheet>
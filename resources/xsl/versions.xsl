<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:v="http://exist-db.org/versioning"
	xmlns="http://www.w3.org/1999/xhtml">

	<xsl:output method="xml" version="1.0" />
	<xsl:variable name="uuid" select="/result/@uuid" />

	<xsl:template match="/">
		<html>
			<head>
				<title>
					<xsl:text>Record history for uuid </xsl:text>
					<xsl:value-of select="$uuid" />
				</title>
				<xsl:call-template name="css" />
			</head>
			<body>
				<xsl:apply-templates />
			</body>
		</html>
	</xsl:template>
	
	<xsl:template match="result">
		<div id="hbody">
			<h1>
				<xsl:text>Record history for uuid </xsl:text>
				<span class="id">
					<xsl:value-of select="$uuid" />
				</span>
			</h1>
			<h2>Work</h2>
			<xsl:apply-templates select="work"/>
			<h2>Related images</h2>
			<xsl:apply-templates select="image"/>
		</div>
	</xsl:template>

	<xsl:template match="error">
		<p class="error">
			<xsl:apply-templates />
		</p>
	</xsl:template>

	<xsl:template match="work | image">
		<xsl:variable name="what">
			<xsl:choose>
				<xsl:when test="local-name() = 'work'">Work</xsl:when>
				<xsl:when test="local-name() = 'image'">Image</xsl:when>
			</xsl:choose>
		</xsl:variable>
		<div class="history {local-name()}-history">
			<h3><xsl:value-of select="$what" />
				<xsl:text> </xsl:text>
				<span class="id"><xsl:value-of select="@id"/></span></h3>
			<p>Path = <a href="{@url}"><xsl:value-of select="@path"/></a></p>
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
		<xsl:choose>
			<xsl:when test="v:revision">
				<table class="revisions">
					<tr>
						<th>Revision nr</th>
						<th>Date</th>
						<th>User</th>
						<th>Resources</th>
					</tr>
					<tr>
						<td>0</td>
						<td> </td>
						<td> </td>
						<td>
							<a href="/exist/admin/versions.xql?action=restore&amp;rev=0&amp;resource={$path}">content</a>
							<xsl:text>, </xsl:text>
							<a href="/exist/admin/versions.xql?action=diff&amp;rev=0&amp;resource={$path}">diff</a>
							<xsl:text>, </xsl:text>
							<a href="/exist/admin/versions.xql?action=annotate&amp;rev=0&amp;resource={$path}">annotation</a>
						</td>
					</tr>
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

	<xsl:template match="v:revision">
		<xsl:param name="path" />
		<tr>
			<td><xsl:value-of select="@rev"/></td>
			<td><xsl:apply-templates select="v:date"/></td>
			<td><xsl:apply-templates select="v:user"/></td>
			<td>
				<a href="/exist/admin/versions.xql?action=restore&amp;rev={@rev}&amp;resource={$path}">content</a>
				<xsl:text>, </xsl:text>
				<a href="/exist/admin/versions.xql?action=diff&amp;rev={@rev}&amp;resource={$path}">diff</a>
				<xsl:text>, </xsl:text>
				<a href="/exist/admin/versions.xql?action=annotate&amp;rev={@rev}&amp;resource={$path}">annotation</a>
			</td>
		</tr>
	</xsl:template>
	
	<xsl:template name="css">
		<style type="text/css">
<![CDATA[
#hbody {
	font-size: 8pt;
	background-color: #DDDDDD;
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
	background-color: #FFCCFF;
}

table.revisions td {
	background-color: #FFFFFF;
}
]]>
		</style>
	</xsl:template>
</xsl:stylesheet>

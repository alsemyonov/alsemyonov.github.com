<?xml version="1.0" encoding="UTF-8"?>
<!--suppress CheckTagEmptyBody -->
<!--suppress XmlUnusedNamespaceDeclaration -->
<xsl:stylesheet
        xmlns:html="http://www.w3.org/TR/REC-html40"
        xmlns:image="http://www.google.com/schemas/sitemap-image/1.1"
        xmlns:sitemap="http://www.sitemaps.org/schemas/sitemap/0.9"
        xmlns:news="http://www.google.com/schemas/sitemap-news/0.9"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        version="2.0">
	<xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<html xmlns="http://www.w3.org/1999/xhtml">
			<head>
				<title>XML News Sitemap</title>
				<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
				<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
				<script type="text/javascript" src="/javascripts/sitemap.js"></script>
        <link href="/stylesheets/screen.css" rel="stylesheet" type="text/css"/>
			</head>
			<body>
				<article class="b-sitemap">
					<h1>XML News Sitemap</h1>
					<p>You can find more information about XML News sitemaps <a
                  href="http://www.google.com/support/webmasters/bin/answer.py?hl=en&amp;answer=74288">here</a>.</p>
					<p>This sitemap contains <xsl:value-of select="count(s:urlset/s:url)"/> URLs.</p>
					<table class="b-sitemap__table">
						<thead>
							<tr>
								<th width="50%">Title</th>
								<th width="25%">Keyword(s)</th>
								<th width="10%">Genre(s)</th>
								<th width="15%">Publication Date</th>
							</tr>
						</thead>
						<tbody>
							<xsl:for-each select="s:urlset/s:url">
								<tr>
                  <xsl:if test="position() mod 2 = 1"><xsl:attribute name="class">odd</xsl:attribute></xsl:if>

									<td>
										<xsl:variable name="itemURL"><xsl:value-of select="s:loc"/></xsl:variable>
										<a href="{$itemURL}"><xsl:value-of select="n:news/n:title"/></a>
									</td>
									<td><xsl:value-of select="n:news/n:keywords"/></td>
									<td><xsl:value-of select="n:news/n:genres"/></td>
									<td><xsl:value-of
                          select="concat(substring(n:news/n:publication_date,0,11),concat(' ', substring(n:news/n:publication_date,12,5)))"/></td>
								</tr>
							</xsl:for-each>
						</tbody>
					</table>
				</article>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>

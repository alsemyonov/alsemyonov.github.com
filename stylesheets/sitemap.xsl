<?xml version="1.0" encoding="UTF-8"?>
<!--suppress CheckTagEmptyBody -->
<!--suppress XmlUnusedNamespaceDeclaration -->
<xsl:stylesheet
        xmlns:html="http://www.w3.org/TR/REC-html40"
        xmlns:image="http://www.google.com/schemas/sitemap-image/1.1"
        xmlns:sitemap="http://www.sitemaps.org/schemas/sitemap/0.9"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        version="2.0">
	<xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<html xmlns="http://www.w3.org/1999/xhtml">
			<head>
				<title>XML Sitemap</title>
				<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
				<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
				<script type="text/javascript" src="/javascripts/sitemap.js"></script>
        <link href="/stylesheets/screen.css" rel="stylesheet" type="text/css"/>
			</head>
			<body>
				<article class="b-sitemap">
					<h1>XML Sitemap</h1>
					<p>You can find more information about XML sitemaps on <a href="http://sitemaps.org">sitemaps.org</a>.</p>
					<p>This sitemap contains <xsl:value-of select="count(sitemap:urlset/sitemap:url)"/> URLs.</p>
					<table class="b-sitemap__table">
						<thead>
							<tr>
								<th width="75%">URL</th>
								<th width="5%">Priority</th>
								<th width="5%">Images</th>
								<th width="5%">Change Freq.</th>
								<th width="10%">Last Change</th>
							</tr>
						</thead>
						<tbody>
							<xsl:variable name="lower" select="'abcdefghijklmnopqrstuvwxyz'"/>
							<xsl:variable name="upper" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
							<xsl:for-each select="sitemap:urlset/sitemap:url">
								<tr>
                  <xsl:if test="position() mod 2 = 1"><xsl:attribute name="class">odd</xsl:attribute></xsl:if>
									<td>
										<xsl:variable name="itemURL"><xsl:value-of select="sitemap:loc"/></xsl:variable>
										<a href="{$itemURL}"><xsl:value-of select="sitemap:loc"/></a>
									</td>
									<td><xsl:value-of select="concat(sitemap:priority*100,'%')"/></td>
									<td><xsl:value-of select="count(image:image)"/></td>
									<td><xsl:value-of
                          select="concat(translate(substring(sitemap:changefreq, 1, 1),concat($lower, $upper),concat($upper, $lower)),substring(sitemap:changefreq, 2))"/></td>
									<td><xsl:value-of
                          select="concat(substring(sitemap:lastmod,0,11),concat(' ', substring(sitemap:lastmod,12,5)))"/></td>
								</tr>
							</xsl:for-each>
						</tbody>
					</table>
				</article>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>

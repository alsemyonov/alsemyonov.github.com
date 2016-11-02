<?xml version="1.0" encoding="UTF-8"?>
<!--suppress CheckTagEmptyBody -->
<!--suppress XmlUnusedNamespaceDeclaration -->
<xsl:stylesheet
        xmlns:html="http://www.w3.org/TR/REC-html40"
        xmlns:image="http://www.google.com/schemas/sitemap-image/1.1"
        xmlns:sitemap="http://www.sitemaps.org/schemas/sitemap/0.9"
        xmlns:news="http://www.google.com/schemas/sitemap-news/0.9"
        xmlns:video="http://www.google.com/schemas/sitemap-video/1.1"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        version="2.0">
  <xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
  <xsl:template match="/">
    <html xmlns="http://www.w3.org/1999/xhtml">
      <head>
        <title>XML Video Sitemap</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
        <script type="text/javascript" src="/javascripts/sitemap.js"></script>
        <link href="/stylesheets/screen.css" rel="stylesheet" type="text/css"/>
      </head>
      <body>
        <article class="b-sitemap">
          <h1>XML Video Sitemap</h1>
          <p>You can find more information about XML Video sitemaps <a
                  href="http://www.google.com/support/webmasters/bin/answer.py?hl=en&amp;answer=80472">here</a>.</p>
          <p>This sitemap contains <xsl:value-of select="count(sitemap:urlset/sitemap:url)"/> URLs.</p>
          <table class="b-sitemap__table">
            <thead>
              <tr>
                <th width="10%">Video</th>
                <th width="25%">Post / Page</th>
                <th width="30%">Description</th>
                <th width="20%">Tags</th>
                <th width="15%">Pub Date</th>
              </tr>
            </thead>
            <tbody>
              <xsl:for-each select="sitemap:urlset/sitemap:url">
                <tr>
                  <xsl:if test="position() mod 2 = 1"><xsl:attribute name="class">odd</xsl:attribute></xsl:if>

                  <td>
                    <xsl:variable name="thumbURL"><xsl:value-of select="video:video/video:thumbnail_loc"/></xsl:variable>
                    <xsl:variable name="flvURL"><xsl:value-of select="video:video/video:player_loc"/></xsl:variable>
                    <a href="{$flvURL}"><img src="{$thumbURL}" width="80" height="60"/></a>
                  </td>

                  <td>
                    <xsl:variable name="itemURL"><xsl:value-of select="sitemap:loc"/></xsl:variable>
                    <a href="{$itemURL}"><strong><xsl:value-of select="video:video/video:title"/></strong></a>
                  </td>

                  <td>
                    <xsl:variable name="desc"><xsl:value-of select="video:video/video:description"/></xsl:variable>
                    <xsl:choose>
                      <xsl:when test="string-length($desc) &lt; 200"><xsl:value-of select="$desc"/></xsl:when>
                      <xsl:otherwise><xsl:value-of select="concat(substring($desc,1,200),' ...')"/></xsl:otherwise>
                    </xsl:choose>
                  </td>

                  <td>
                    <xsl:for-each select="video:video/video:tag"><xsl:value-of select="."/>,</xsl:for-each>
                  </td>

                  <td>
                    <xsl:value-of
                            select="concat(substring(video:video/video:publication_date,0,11),concat(' ', substring(video:video/video:publication_date,12,5)))"/>
                  </td>
                </tr>
              </xsl:for-each>
              </tbody>
          </table>
        </article>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>

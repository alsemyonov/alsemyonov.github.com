xml.instruct!
xml.instruct! 'xml-stylesheet', type: 'text/xsl', href: '/stylesheets/sitemap.xsl'
xml.urlset(
  xmlns: 'http://www.sitemaps.org/schemas/sitemap/0.9',
  image: 'http://www.google.com/schemas/sitemap-image/1.1',
  news: 'http://www.google.com/schemas/sitemap-news/0.9',
  video: 'http://www.google.com/schemas/sitemap-video/1.1'
) do
  last_modified = Date.today.to_time.iso8601
  sitemap.resources.select { |page| page.path =~ /\.html/ }.each do |page|
    xml.url do
      location = "#{data.site.url}#{page.url}"
      change_frequency = page.data.changefreq || 'monthly'
      priority = page.data.priority || '0.5'

      xml.loc location
      xml.lastmod last_modified
      xml.changefreq change_frequency
      xml.priority priority
    end
  end
end

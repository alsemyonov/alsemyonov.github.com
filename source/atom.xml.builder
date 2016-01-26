blog_url = absolute_url(blog.options.prefix.to_s)
site_author_name = data.site.author
site_author_email = data.site.email

xml.instruct!
xml.feed xmlns: 'http://www.w3.org/2005/Atom' do
  xml.title data.site.title
  xml.subtitle data.site.description
  xml.link href: blog_url, rel: 'alternate', type: 'text/html'
  xml.link href: absolute_url(current_page.path), rel: 'self', type: 'application/atom+xml'
  xml.link href: absolute_url('/rss.xml'), rel: 'alternate', type: 'application/rss+xml'
  xml.updated(blog.articles.first.date.to_time.iso8601) unless blog.articles.empty?
  xml.generator "Middleman v#{Middleman::VERSION}"

  xml.id blog_url
  xml.author do
    xml.name site_author_name
    xml.email site_author_email
  end

  blog.articles[0..10].each do |article|
    article_url = absolute_url(article.url)
    xml.entry do
      xml.id article_url
      xml.link rel: 'alternate', href: article_url, type: 'text/html'
      xml.published article.date.to_time.iso8601
      xml.updated File.mtime(article.source_file).iso8601
      xml.title article.title
      xml.summary article.summary, type: 'html' if article.summary
      xml.content article.body, type: 'html'

      article_author_name = article.data.author
      article_author_email = article.data.email
      xml.author do
        xml.name article_author_name || site_author_name
        xml.email article_author_email || site_author_email
      end if article_author_name || article_author_email

      article.tags.each do |tag|
        xml.category term: tag.parameterize, label: tag, scheme: blog_url
      end
    end
  end
end

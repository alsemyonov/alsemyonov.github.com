# ---
# title: Последние статьи в Блоге Разработчика Веба
# menu: false
# published: true
# ---

blog_url = absolute_url(blog.options.prefix.to_s)
site_author_name = data.author.name
site_author_email = data.author.email

xml.instruct!
xml.rss 'xmlns:atom': 'http://www.w3.org/2005/Atom' do
  xml.channel do
    xml.title data.site.title
    xml.subtitle data.site.description
    xml.link absolute_url(blog_url)
    xml.atom :link, href: blog_url, rel: 'alternate', type: 'text/html'
    xml.atom :link, href: absolute_url(current_page.path), rel: 'self', type: 'application/atom+xml'
    xml.atom :link, href: absolute_url('/rss.xml'), rel: 'alternate', type: 'application/rss+xml'
    unless blog.articles.empty?
      xml.pubDate(blog.articles.first.date.to_time.iso8601)
      xml.lastBuildDate(blog.articles.first.date.to_time.iso8601)
    end
    xml.generator "Middleman v#{Middleman::VERSION}"

    xml.atom :id, blog_url
    xml.atom :author do
      xml.atom :name, site_author_name
      xml.atom :email, site_author_email
    end

    blog.articles[0..10].each do |article|
      article_url = absolute_url(article.url)
      xml.item do
        xml.atom :id, article_url
        xml.atom :link, rel: 'alternate', href: article_url, type: 'text/html'
        xml.title article.title
        xml.description article.body
        xml.pubDate article.date.to_time.rfc822
        xml.link article_url
        xml.guid(isPermalink: true) { article.url }
        xml.updated File.mtime(article.source_file).iso8601
        xml.summary article.summary, type: 'html' if article.summary

        article_author_name = article.data.author
        article_author_email = article.data.email
        xml.atom :author do
          xml.atom :name, article_author_name || site_author_name
          xml.atom :email, article_author_email || site_author_email
        end if article_author_name || article_author_email

        article.tags.each { |tag| xml.category tag }
      end
    end
  end
end

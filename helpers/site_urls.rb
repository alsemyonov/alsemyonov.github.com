module SiteUrls
  def cgi_escape(string)
    CGI::escape(string)
  end

  def canonicalize_url(url)
    url = url.gsub('index.html', '')
    absolute_url(url)
  end

  def absolute_url(url)
    # url = root_url + url
    # url = data.site.url + url
    URI.join(data.site.url, url)
  end

  def root_path(*paths)
    uri_root_path(*paths)
  end
end

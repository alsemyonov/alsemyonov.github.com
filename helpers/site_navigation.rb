module SiteNavigation
  def title(text)
    content_for(:title, text)
    text
  end

  def navigation_resources
    sitemap.root.children.select { |resource| resource.try(:menu?) }
  end
end

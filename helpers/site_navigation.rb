module SiteNavigation
  def title(text)
    content_for(:title, text)
    text
  end

  def navigation_resources
    sitemap.roots.map do |root|
      root.children.select do |resource|
        resource.menu? && !resource.year?
      end
    end.flatten
  end
end

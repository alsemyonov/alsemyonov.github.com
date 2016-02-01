module SiteNavigation
  def title(text)
    content_for(:title, text)
    text
  end

  def navigation_resources
    sitemap.resources.select do |resource|
      resource.navigation?
    end.sort_by do |resource|
      resource.data.position
    end
  end
end

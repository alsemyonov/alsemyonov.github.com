module SiteNavigation
  def navigation_resources
    sitemap.resources.select do |resource|
      resource.data.navigation == true &&
        (!resource.locals['page_number'] || (resource.locals['page_number'] == 1)) &&
        !resource.locals['category']
    end.sort_by do |resource|
      resource.data.position
    end
  end
end

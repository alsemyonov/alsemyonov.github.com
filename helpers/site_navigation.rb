module SiteNavigation
  def title(text)
    content_for(:title, text)
    text
  end

  def navigation_resources
    sitemap.roots.map do |root|
      root.children.select do |resource|
        resource.menu? && resource.published?
      end
    end.flatten
  end

  def page_classes(path=current_path.dup, options={})
    if path.is_a? Hash
      options = path
      path = current_path.dup
    end

    path << index_file if path.end_with?('/')
    path = ::Middleman::Util.strip_leading_slash(path)

    classes = Set.new
    parts = path.split('.').first.split('/')
    parts.each_with_index { |_, i| classes << parts.first(i + 1).join('_') }

    numeric_prefix = options[:numeric_prefix] || 'x'
    prefix = options[:prefix]
    classes.map do |c|
      # Replace weird class name characters
      c = c.gsub(/[^a-zA-Z0-9\-_]/, '-')

      # Class names can't start with a digit
      c = "#{numeric_prefix}#{c}" if c =~ /\A\d/
      c = "#{prefix}_#{c}" if prefix
      c
    end.join(' ')
  end
end

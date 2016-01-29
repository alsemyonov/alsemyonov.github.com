module SiteBlogging
  def make_excerpt(text)
    # text = text.strip_html
    # text = text.strip_newlines
    # text.truncate(60)
    text
  end

  def tags(page)
    page.tags.map { |tag| link_to(tag, tag_path(tag)) }.join(', ')
  end

  def related(page)
    all_pages = blog.tags.slice(*page.tags).values.first
    return [] if all_pages.blank?

    all_pages.delete_if { |p| p == page }
  end

  def tag_cloud(options = {})
    [].tap do |html|
      TagCloud.new(options).render(blog.tags) do |tag, size, unit|
        html << link_to(tag, tag_path(tag), style: "font-size: #{size}#{unit}")
      end
    end.join(' ')
  end

  class TagCloud
    cattr_accessor :default_options
    self.default_options = {
      size_min: 70,
      size_max: 170,
      precision: 0,
      unit: '%',
      threshold: 1
    }

    attr_reader :options

    def initialize(options = {})
      @options = default_options.update(options)
    end

    def render(tags)
      tags_weight(tags_count(tags)).each do |tag_pair|
        tag, weight = tag_pair
        size = sprintf("%.#{options[:precision]}f", calculate_size(weight))

        yield(tag, size, options[:unit])
      end
    end

    private

    def tags_count(tags)
      tags.map do |tag, articles|
        [tag, articles.count] if articles.count >= options[:threshold]
      end.compact
    end

    def tags_weight(count)
      # get the minimum, and maximum tag count
      min, max = count.map(&:last).minmax

      # map: [[tag, tag count]] -> [[tag, tag weight]]
      count.map do |tag, count|
        # logarithmic distribution
        weight = (Math.log(count) - Math.log(min))/(Math.log(max) - Math.log(min))

        [tag, weight]
      end
    end

    def calculate_size(weight)
      options[:size_min] + ((options[:size_max] - options[:size_min]) * weight).to_f
    end
  end
end

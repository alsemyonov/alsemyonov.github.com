require 'middleman/cv/object'

class Middleman::CV::Language < Middleman::CV::Object
  attr_accessor :locale
  attr_accessor :level

  def to_html
    item = content_tag(:strong, language) << ' — ' << content_tag(:span, level_description)
    content_tag(:li, item)
  end

  def level_description
    I18n.t(level, scope: 'cv.language_level')
  end

  def language
    I18n.t(locale, scope: 'i18n.languages')
  end
end

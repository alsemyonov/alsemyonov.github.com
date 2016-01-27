module SiteUi
  def l(date, options)
    ::I18n.localize(date, options)
  end

  def icon(name)
    content_tag(:i, nil, class: "fa fa-#{name}")
  end

  def rss_link
    link_to(t('blog.subscribe.rss') << ' ' << icon(:feed), '/rss.xml', class: 'b-feed b-feed_rss')
  end

  def atom_link
    link_to(t('blog.subscribe.atom') << ' ' << icon(:feed), '/atom.xml', class: 'b-feed b-feed_atom')
  end
end

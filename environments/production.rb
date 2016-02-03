# Build-specific configuration
configure :build do
  activate :autoprefixer
  # Minify CSS on build
  activate :minify_css
  # Minify Javascript on build
  activate :minify_javascript
  # Minify HTML on build
  activate :minify_html
  # Provide GZipped versions of files
  activate :gzip, exts: %w(.js .css .html .htm .xml)
  # # Uniquely-named assets
  # activate :asset_hash
end

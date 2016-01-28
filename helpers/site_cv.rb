module SiteCv
  def cv
    require 'middleman-cv'
    @cv ||= Middleman::CV.new(self)
  end
end

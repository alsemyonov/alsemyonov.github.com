instance_eval File.read(File.expand_path('../config/environment.rb', __FILE__))
Dir[File.expand_path('../lib/**/*.rb', __FILE__)].each do |file|
  load file
end
instance_eval File.read(File.expand_path('../config/routes.rb', __FILE__))

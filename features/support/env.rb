PROJECT_ROOT_PATH = File.expand_path('../../..', __FILE__)
$LOAD_PATH << File.join(PROJECT_ROOT_PATH, 'lib')

ENV['TEST'] = 'true'

require 'middleman-core/step_definitions'

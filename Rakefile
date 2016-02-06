task(:setup) { exec './bin/setup' }
task(bundle: :setup) { exec './bin/bundle' }
task(build: :setup) { exec './bin/middleman build' }
if File.exist?(File.expand_path('../bin/cucumber', __FILE__))
  task(:cucumber) { exec './bin/cucumber' }
  task build: :cucumber
  task default: :cucumber
end
task(default: :build) unless Rake::Task.task_defined?(:default)

Given(/^a successfully built app$/) do
  step "I run `middleman build --verbose --environment=#{ENV['MM_ENV'] || 'production'}`"
  step 'was successfully built'
end

Given(/^in :([^ ]+) environment$$/) do |environment|
  ENV['MM_ENV'] = environment
  @initialize_commands ||= []
  @initialize_commands << lambda {
    config[:environment] = environment.to_sym
  }
end

Given(/^the Server is running in :([^ ]+) environment$/) do |environment|
  step %(in :#{environment} environment)
  step 'the Server is running'
end


Given(/^a successfully built in :([^ ]+) environment app$/) do |environment|
  step %(in :#{environment} environment)
  step 'a successfully built app'
end

Given(/^current application$/) do
  @dirs = %w()
  cd PROJECT_ROOT_PATH

  ENV['MM_ROOT'] = PROJECT_ROOT_PATH

  if File.exists?(File.join(ENV['MM_ROOT'], 'source'))
    ENV['MM_SOURCE'] = 'source'
  else
    ENV['MM_SOURCE'] = ''
  end

  step 'a directory named "build"'
end

task default: :spec

desc "Run the test suite"
task spec: ['spec:setup', 'db:create', 'spec:app', 'spec:cleanup']

namespace :spec do
  desc "Setup the test environment"
  task :setup do
    ENV['ANALYTICS_ENV'] = 'test'
    system "cd #{Dir.pwd} && bundle install && mkdir -p #{Dir.pwd}/db/test"
  end

  desc "Cleanup the test environment"
  task :cleanup do
    FileUtils.rm_rf "#{Dir.pwd}/db/test"
  end

  desc "Test the app"
  RSpec::Core::RakeTask.new(:app) do |task|
    task.pattern = Dir.pwd + '/spec/**/*_spec.rb'
  end
end

#!/usr/bin/env rake
task :default => [:test]

task :test do
  sh("bundle exec rspec spec/")
end

desc "commit and push"
task :cp do
  system "git add ."
  system "git commit -m \"work in progress #{Time.now.hour}:#{Time.now.min}:#{Time.now.sec}\""
  system "git push origin master"
end


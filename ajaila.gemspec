$LOAD_PATH.push File.expand_path("../lib", __FILE__)
require "ajaila_version"

Gem::Specification.new do |s|
  s.name = "ajaila"
  s.version = Ajaila::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ["Max Makarochkin"]
  s.email = ["maxim.makarochkin at gmail.com"]
  s.homepage = "http://ajaila.com"
  s.summary = %q{datamining framework}
  s.description = %q{Develop your datamining project following Agile practices}
  s.rubyforge_project = "ajaila"
  s.files = ["bin/ajaila"]
  s.executables = ["ajaila"]
end
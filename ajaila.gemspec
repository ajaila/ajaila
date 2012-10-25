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
  s.add_dependency("bundler")
  s.add_dependency("gli")
  s.add_dependency("sinatra")
  s.add_dependency("sinatra-assetpack")
  s.add_dependency("mongo_mapper")
  s.add_dependency("json")
  s.add_dependency("typhoeus")
  s.add_dependency("rio")
  s.add_development_dependency("rspec")
  s.add_development_dependency("rake")
  s.add_development_dependency("rdoc")
end
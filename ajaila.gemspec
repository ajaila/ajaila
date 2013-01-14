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
  s.executables = ["ajaila"]
  s.files = Dir.glob("{bin,lib,spec}/**/*")
  s.add_dependency("rio")
  s.add_dependency("gli")
  s.add_dependency("tilt")
  s.add_dependency("liquid")
  s.add_dependency("foreman")
  s.add_dependency("sinatra")
  s.add_dependency("mongo_mapper")
end
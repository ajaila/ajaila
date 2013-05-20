$LOAD_PATH.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name = "ajaila"
  s.version = '0.0.1'
  s.platform = Gem::Platform::RUBY
  s.authors = ["Max Makarochkin"]
  s.email = ["maxim.makarochkin at gmail.com"]
  s.homepage = "http://ajaila.com"
  s.summary = %q{Ajaila}
  s.description = %q{Modular DSL for Predictive Analysis}
  s.rubyforge_project = "ajaila"
  s.executables = ["ajaila"]
  s.files = Dir.glob("{bin,lib,spec}/**/*")
  s.add_dependency("rio")
  s.add_dependency("gli")
  s.add_dependency("tilt")
  s.add_dependency("liquid")
  s.add_dependency("foreman")
  s.add_dependency("sinatra")
end

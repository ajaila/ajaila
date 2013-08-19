$LOAD_PATH.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name = "ajaila"
  s.version = "0.0.2"
  s.platform = Gem::Platform::RUBY
  s.authors = ["Max Makarochkin"]
  s.email = ["maxim.makarochkin at gmail.com"]
  s.homepage = "http://ajaila.com"
  s.summary = %q{Ajaila}
  s.description = %q{Modular DSL for Predictive Analysis}
  s.files = Dir.glob("{bin,lib,spec}/**/*")

  s.add_dependency("rake")
  s.add_dependency("active_record_inline_schema")
  s.add_dependency("activerecord")
  s.add_dependency("activesupport")
  s.add_dependency("squeel")
  s.add_dependency("awesome_print")
  s.add_dependency("bundler")
end

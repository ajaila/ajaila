$LOAD_PATH.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name = "ajaila"
  s.version = '0.0.2alpha' # 19 of March Release, later commits are not included
  s.platform = Gem::Platform::RUBY
  s.authors = ["Max Makarochkin"]
  s.email = ["maxim.makarochkin at gmail.com"]
  s.homepage = "http://ajaila.com"
  s.summary = %q{Ajaila: Modular DSL for Predictive Analysis}
  s.description = %q{The application helps you to work with statistical datasets, normalize the data into a common format and build the required data models. Additionally, you can visualize your data with Protovis / Highcharts.js and scale your service with Hadoop (HDFS).

During your work the application is provided with usefull snippets and generators. Ajaila can be easily extended with common Machine Learning packages written in Ruby and C. Among supported libraries are Statsample, MadLib (EMC corporation) and Vowpal Wabbit (Yahoo! Research), online learning library based on stochastic gradient discent for classification problems and regression analysis.

After prototyping you can deploy your application to the web and provide your predictive models with unstructured data from Hadoop via MapReduce, which is hidden from you behind classy ORM (Massive Record or Treasure Data Extensions).

Ajaila helps you build long-lasting software and provides you with environment, which can be easily tested with RSpec. }
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
  s.add_dependency("rubyvis")
end

#!/usr/bin/env rake

task :default => [:test]

task :test do
  sh("bundle exec rspec spec/")
end

desc "commit and push"
task :cp do
  system "git add ."
  nouns = ["beer", "wine", "vodka", "tequila", "whiskey", "vermouth", "jelly", "soda", "milk", "brew", "orange juice", "birch juice", "yogurt", "rum", "port", "mate", "green tea", "Ceylon tea", "Lapacho", "Catuaba", "cranberry liqueur"]
  quantity = Random.rand(2...100500)
  ni = Random.rand(0...(nouns.length - 1))
  system "git commit -m \"mac-r drank #{quantity} bottles of #{nouns[ni]}\""
  system "git push origin master"
end


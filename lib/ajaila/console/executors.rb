command :run do |c|
  #`foreman start`
  c.action do |global_options,options,args|
    puts "#############################################################################".color(Colors::INFO)
    puts "#                                                                           #".color(Colors::INFO)
    puts "#             Running Ajaila Environment. Just a few seconds...             #".color(Colors::INFO)
    puts "#                                                                           #".color(Colors::INFO)
    puts "#############################################################################".color(Colors::INFO)
  end
  post do |global_options,command,options,args|
    system "foreman start"
  end
end

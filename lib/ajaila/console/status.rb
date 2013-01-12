command :help do |c|
  c.action do |global_options,options,args|
    puts "Ajaila Datamining Sandbox v. 0.0.1"
    puts "\tDo Science Magic Smoothly and Efficiently!"
    puts "\nCommands:"
    puts "  generate new application:\n\t - ajaila new YourApp\n"
    puts "  generate table:\n\t - ajaila generate table SomeTable"
    puts "  generate selector:\n\t - ajaila generate selector SomeSelector using file:input.csv table:sometable"
    puts "  generate miner:\n\t - ajaila generate miner SomeMiner using table:sometable"
    puts "  generate presenter:\n\t - ajaila generate presenter SomePresenter using table:sometable"
    puts "  generate api:\n\t - ajaila generate api MyApi using table:sometable"
    puts "  list of tables:\n\t - ajaila tables"
    puts "  list of selectors:\n\t - ajaila seletors"
    puts "  list of miners:\n\t - ajaila miners"   
    puts "  list of presenters:\n\t - ajaila presenters" 
  end
end

command :tables do |c|
  c.action do |global_options,options,args|
         puts "These are the app tables:"
         tables, ind = {}, 1
         Dir.glob("sandbox/tables/*.rb").each do |table|
           tables[ind] = table.split("/").last.split(".").first
           ind += 1
         end
         tables[0] = "There are now tables" if tables == {}
         tables.each_key do |ind|
           puts "\t#{ind}) #{tables[ind]}"
         end
  end
end

command :miners do |c|
  c.action do |global_options,options,args|
         puts "These are the app miners:"
         miners, ind = {}, 1
         Dir.glob("sandbox/miners/*.rb").each do |miner|
           miners[ind] = miner.split("/").last.split(".").first
           ind += 1
         end
         miners[0] = "There are now miners" if miners == {}
         miners.each_key do |ind|
           puts "\t#{ind}) #{miners[ind]}"
         end
  end
end

command :selectors do |c|
  c.action do |global_options,options,args|
         puts "These are the app selectors:"
         selectors, ind = {}, 1
         Dir.glob("datasets/*.selector.rb").each do |selector|
           selectors[ind] = selector.split("/").last.split(".").first
           ind += 1
         end
         selectors[0] = "There are now selectors" if selectors == {}
         selectors.each_key do |ind|
           puts "\t#{ind}) #{selectors[ind]}"
         end
  end
end

command :presenters do |c|
  c.action do |global_options,options,args|
         puts "These are the app presenters:"
         presenters, ind = {}, 1
         Dir.glob("sandbox/presenters/*.presenter.rb").each do |presenter|
           presenters[ind] = presenter.split("/").last.split(".").first
           ind += 1
         end
         presenters[0] = "There are now presenters" if presenters == {}
         presenters.each_key do |ind|
           puts "\t#{ind}) #{presenters[ind]}"
         end
  end
end

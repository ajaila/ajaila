command :help do |c|
  c.action do |global_options,options,args|
    puts "Ajaila: modular DSL for predictive analysis (stealthmode version)." 
  end
end

command :tables do |c|
  c.action do |global_options,options,args|
    Ajaila::RootDefiner.set_root
    puts "These are the app tables:"
    tables, ind = {}, 1
    Dir.glob(ROOT + "/sandbox/tables/*.rb").each do |table|
      tables[ind] = Ajaila::ConsoleHelper.file_to_name(table.split("/").last.split(".").first)
      ind += 1
    end
    tables[0] = "There are no tables" if tables == {}
    tables.each_key do |ind|
      puts "\t#{ind}) #{tables[ind]}"
    end
  end
end

command :miners do |c|
  c.action do |global_options,options,args|
    Ajaila::RootDefiner.set_root
    puts "These are the app miners:"
    miners, ind = {}, 1
    Dir.glob(ROOT + "/sandbox/miners/*.rb").each do |miner|
      miners[ind] = Ajaila::ConsoleHelper.file_to_name(miner.split("/").last.split(".").first)
      ind += 1
    end
    miners[0] = "There are no miners" if miners == {}
    miners.each_key do |ind|
      puts "\t#{ind}) #{miners[ind]}"
    end
  end
end

command :selectors do |c|
  c.action do |global_options,options,args|
    Ajaila::RootDefiner.set_root
    puts "These are the app selectors:"
    selectors, ind = {}, 1
    Dir.glob(ROOT + "/datasets/*.selector.rb").each do |selector|
      selectors[ind] = Ajaila::ConsoleHelper.file_to_name(selector.split("/").last.split(".").first)
      ind += 1
    end
    selectors[0] = "There are no selectors" if selectors == {}
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
      presenters[ind] = Ajaila::ConsoleHelper.file_to_name(presenter.split("/").last.split(".").first)
      ind += 1
    end
    presenters[0] = "There are no presenters" if presenters == {}
    presenters.each_key do |ind|
      puts "\t#{ind}) #{presenters[ind]}"
    end
  end
end

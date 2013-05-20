command :run do |c|
  c.action do |global_options,options,args|
    Ajaila::RootDefiner.set_root
    if args == []
      puts Ajaila::Messager.info("This feature is not supported currently. To run dashboard you can type 'foreman start' or 'ruby service.rb' from the root folder of your application.")
    else
      options = args
      instance_file = Ajaila::ConsoleHelper.name_to_file(options[1])
      instance_title = options[1]
      types = ["miner", "selector"]
      message = "CHECK YOURSELF\n   To run ajaila environment: ajaila run\n   To run miner: ajaila run miner some_miner\n   To run selector: ajaila run selector some_selector"
      raise Ajaila::Messager.info(message) if types.include?(options.first) == false

      if options.first == "miner"
        miners = []
        Dir[ROOT + "/sandbox/miners/*.miner.rb"].each do |miner|
          miners << File.basename(miner).split(".").first
        end 
        message = "MINER \"#{instance_title}\" DOESN'T EXIST\nTo create miner type: ajaila g miner"
        raise Ajaila::Messager.warning(message) if miners == [] or miners.include?(instance_file) == false        
        puts Ajaila::Messager.info("Running Miner \"#{instance_title}\". Just a few seconds...")
      end
      if options.first == "selector"
        selectors = []
        Dir[ROOT + "/datasets/*.selector.rb"].each do |miner|
          selectors << File.basename(miner).split(".").first
        end
        warn = "SELECTOR \"#{instance_title}\" DOESN'T EXIST\nTo create selector type: ajaila g selector #{instance_title}"
        raise Ajaila::Messager.warning(warn) if selectors == [] or selectors.include?(instance_file) == false
        puts Ajaila::Messager.info("Running Selector \"#{instance_title}\". Just a few seconds...")
      end
    end  
  end
end

post do |global_options,command,options,args|
  if command.name == :run
    if args == []
      
    else
      options = args
      instance_file = Ajaila::ConsoleHelper.name_to_file(options[1])
      instance_title = options[1]
      if options.first == "miner"
        system "ruby #{ROOT}/sandbox/miners/#{instance_file}.miner.rb"
      end
      if options.first == "selector"
        system "ruby #{ROOT}/datasets/#{instance_file}.selector.rb"
      end
    end
  end
end
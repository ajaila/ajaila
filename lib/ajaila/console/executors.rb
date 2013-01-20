command :run do |c|
  c.action do |global_options,options,args|
    Ajaila::RootDefiner.set_root
    if args == []
      puts Ajaila::Messager.info("Running Ajaila Environment. Just a few seconds...")
    else

      options = args #[0].split(":")
      types = ["miner","selector"]
      message = "CHECK YOURSELF\n   To run ajaila environment: ajaila run\n   To run miner: ajaila run miner some_miner\n   To run selector: ajaila run selector some_selector"
      raise Ajaila::Messager.info(message) if types.include?(options.first) == false

      if options.first == "miner"
        miners = []
        Dir[ROOT + "/sandbox/miners/*.miner.rb"].each do |miner|
          miners << File.basename(miner).downcase.split(".").first
        end 
        message = "MINER \"#{options[1]}\" DOESN'T EXIST\nTo create miner type: ajaila g miner"
        raise Ajaila::Messager.warning(message) if miners == [] or miners.include?(options[1].downcase) == false        
        puts Ajaila::Messager.info("Running Miner \"#{options[1]}\". Just a few seconds...")
      end
      if options.first == "selector"
        selectors = []
        Dir[ROOT + "/datasets/*.selector.rb"].each do |miner|
          selectors << File.basename(miner).downcase.split(".").first
        end
        warn = "SELECTOR \"#{options[1]}\" DOESN'T EXIST\nTo create selector type: ajaila g selector #{options[1]}"
        raise Ajaila::Messager.warning(warn) if selectors == [] or selectors.include?(options[1].downcase) == false
        puts Ajaila::Messager.info("Running Selector \"#{options[1]}\". Just a few seconds...")
      end
    end  
  end
end

post do |global_options,command,options,args|
  if command.name == :run
    if args == []
      system "foreman start"
    else
      options = args
      if options.first == "miner"
        system "ruby #{ROOT}/sandbox/miners/#{options[1].downcase}.miner.rb"
      end
      if options.first == "selector"
        system "ruby #{ROOT}/datasets/#{options[1].downcase}.selector.rb"
      end
    end
  end
end
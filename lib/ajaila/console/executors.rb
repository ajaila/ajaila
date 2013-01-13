command :run do |c|
  #`foreman start`
  c.action do |global_options,options,args|
    if args == []
      puts "#############################################################################".color(Colors::INFO)
      puts "#                                                                           #".color(Colors::INFO)
      puts "#          STATUS: Running Ajaila Environment. Just a few seconds...        #".color(Colors::INFO)
      puts "#                                                                           #".color(Colors::INFO)
      puts "#############################################################################".color(Colors::INFO)
    else
      
      options = args[0].split(":")
      types = ["m","s"]
      error = %Q{
#############################################################################
#                                                                           #
#                             CHECK YOURSELF                                #
#                                                                           #
#   To run ajaila environment: ajaila run                                   #
#   To run miner: ajaila run m:some_miner                                   #
#   To run selector: ajaila run s:some_selector                             #
#                                                                           #  
#############################################################################
                }
      raise error.color(Colors::INFO) if types.include?(options.first) == false

      if options.first == "m"
        miners = []
        Dir[ROOT + "/sandbox/miners/*.miner.rb"].each do |miner|
          miners << File.basename(miner).downcase.split(".").first
        end 
        error = %Q{
#############################################################################
#                                                                           # }
        error += "\n#"+"ERROR: MINER \"#{options[1]}\" DOESN'T EXIST".center(75)+"#"
        error += "\n#"+"To create miner type: ajaila g m:#{options[1]}".center(75)+"#"
        error += %Q{
#                                                                           #
#############################################################################
                }
        raise error.color(Colors::WARNING) if miners == [] or miners.include?(options[1].downcase) == false        
        puts "#############################################################################".color(Colors::INFO)
        puts "#                                                                           #".color(Colors::INFO)
        message = "#"+"STATUS: Running Miner \"#{options[1]}\". Just a few seconds...".center(75)+"#"
        puts message.color(Colors::INFO)
        puts "#                                                                           #".color(Colors::INFO)
        puts "#############################################################################".color(Colors::INFO)
      end
      if options.first == "s"
        selectors = []
        Dir[ROOT + "/datasets/*.selector.rb"].each do |miner|
          selectors << File.basename(miner).downcase.split(".").first
        end
        error = %Q{
#############################################################################
#                                                                           # }
        error += "\n#"+"ERROR: SELECTOR \"#{options[1]}\" DOESN'T EXIST".center(75)+"#"
        error += "\n#"+"To create selector type: ajaila g s:#{options[1]}".center(75)+"#"
        error += %Q{
#                                                                           #
#############################################################################
                }
        raise error.color(Colors::WARNING) if selectors == [] or selectors.include?(options[1].downcase) == false
        puts "#############################################################################".color(Colors::INFO)
        puts "#                                                                           #".color(Colors::INFO)
        message = "#"+"STATUS: Running Selector \"#{options[1]}\". Just a few seconds...".center(75)+"#"
        puts message.color(Colors::INFO)
        puts "#                                                                           #".color(Colors::INFO)
        puts "#############################################################################".color(Colors::INFO)
      end
    end  
  end
  post do |global_options,command,options,args|
    # puts "global: #{global_options}"
    # puts "command: #{command}"
    # puts "options: #{options}"
    if args == []
      system "foreman start"
    else
      options = args[0].split(":")
      if options.first == "m"
        system "ruby #{ROOT}/sandbox/miners/#{options[1].downcase}.miner.rb"
      end
      if options.first == "s"
        system "ruby #{ROOT}/datasets/#{options[1].downcase}.selector.rb"
      end
    end
  end
end
#"STATUS: Running Miner \"#{options[1]}\". Just a few seconds...".center(75)




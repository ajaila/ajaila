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
        Dir[ROOT + "/sandbox/miners/*"].each do |miner|
          miners << File.basename(miner).downcase.split(".").first
        end
        puts "#{miners}"
        error = %Q{
#############################################################################
#                                                                           # }
        error += "\n#"+"MINER \"#{options[1]}\" DOESN'T EXIST".center(75)+"#"
        error += %Q{
#                                                                           #
#############################################################################
                }
        raise error.color(Colors::WARNING) if miners.include?(options[1].downcase) == false        
        puts "#############################################################################".color(Colors::INFO)
        puts "#                                                                           #".color(Colors::INFO)
        message = "#"+"STATUS: Running Miner \"#{options[1]}\". Just a few seconds...".center(75)+"#"
        puts message.color(Colors::INFO)
        puts "#                                                                           #".color(Colors::INFO)
        puts "#############################################################################".color(Colors::INFO)
      end
      if options.first == "s"
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
    puts "args: #{args}"
    if args == []
      system "foreman start"
    else
      options = args[0].split(":")
      if options.first == "m"
        system "ruby #{ROOT}/sandbox/miners/#{options[1].downcase}.miner.rb"
      end
      if options.first == "s"
        dir = ""
      end
    end
  end
end
#"STATUS: Running Miner \"#{options[1]}\". Just a few seconds...".center(75)




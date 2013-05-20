# generating miners, selectors, tables and presenters 
command :g do |c|
  c.action do |global_options,options,args|
    Ajaila::RootDefiner.set_root
    Ajaila::ConsoleHelper.check_inputs_g(args)
    content = ""
    instance_title = args[1]
    instance_file = Ajaila::ConsoleHelper.name_to_file(instance_title)
    if args[0] == "table"
      columns = Ajaila::ConsoleHelper.additional_params(args)
      collection = instance_title
      key_pairs = Ajaila::ConsoleHelper.parse_columns(columns)
      content = Ajaila::ConsoleHelper.render("table", :collection => collection, :keys => key_pairs)
    end

    if args[0] == "selector"
      content = Ajaila::ConsoleHelper.render("selector")
      if args[2] != nil
        puts Ajaila::Messager.warning("Snippets are deprecated.")
      end
    end

    if args[0] == "miner"
      content = Ajaila::ConsoleHelper.render("miner", :miner => instance_file)
      puts Ajaila::Messager.warning("Snippets are deprecated.")
    end
    
    instance = args[0]
    dir = Ajaila::ConsoleHelper.target_dir(instance)
    helper_content = Ajaila::ConsoleHelper.render("helper", :miner => instance_title) if args[0] == "miner"
    File.open(ROOT + "/sandbox/helpers/#{instance_file}.helper.rb", 'w') {|f| f.write(helper_content) } if args[0] == "miner"
    puts Ajaila::Messager.success("Generated #{instance} #{args[1]} successfully!")    
  end
end
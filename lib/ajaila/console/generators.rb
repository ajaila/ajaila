# generating miners, selectors, tables and presenters 
command :g do |c|
  c.action do |global_options,options,args|
    Ajaila::RootDefiner.set_root
    Ajaila::ConsoleHelper.check_inputs_g(args)
    content = ""
    if args[0] == "table"
      columns = Ajaila::ConsoleHelper.additional_params(args)
      collection = args[1]
      key_pairs = Ajaila::ConsoleHelper.parse_columns(columns)
      content = Ajaila::ConsoleHelper.render("table", :collection => collection, :keys => key_pairs)
    end

    if args[0] == "selector"
      content = Ajaila::ConsoleHelper.render("selector")
      io = Ajaila::ConsoleHelper.additional_params(args)
      file = Ajaila::ConsoleHelper.get_file(io)
      file_name = Ajaila::ConsoleHelper.get_file(io).split(".").first.upcase
      table = Ajaila::ConsoleHelper.get_table(io)
      all_columns = Ajaila::ConsoleHelper.get_columns(table)
      clast = all_columns.pop
      cleft = all_columns
      content += "\n" + Ajaila::ConsoleHelper.render( "_parser", :columns => cleft, :last => clast, :collection => table, :file => file, :file_name => file_name )
    end

    if args[0] == "miner"
      content = Ajaila::ConsoleHelper.render("miner", :miner => args[1].downcase)
      io = Ajaila::ConsoleHelper.additional_params(args)
      Ajaila::ConsoleHelper.get_tables(io).each do |table|
        all_columns = Ajaila::ConsoleHelper.get_columns(table)
        clast = all_columns.pop
        cleft = all_columns
        content += "\n" + Ajaila::ConsoleHelper.render( "_input", :columns => cleft, :last => clast, :collection => table )
        content += "\n" + Ajaila::ConsoleHelper.render( "_output", :columns => cleft, :last => clast, :collection => table )
      end
    end
    
    if args[0] == "presenter"
      raise TypeError, Ajaila::Messager.warning("Presenters are not available, sorry")
    end
    instance = args[0]
    dir = Ajaila::ConsoleHelper.target_dir(instance)
    instance_title = args[1]
    instance_file = Ajaila::ConsoleHelper.name_to_file(instance_title)
    helper_content = Ajaila::ConsoleHelper.render("helper", :miner => instance_title) if args[0] == "miner"
    File.open(ROOT + "/#{dir}#{instance_file}.#{args[0]}.rb", 'w') {|f| f.write(content) }
    File.open(ROOT + "/sandbox/helpers/#{instance_file}.helper.rb", 'w') {|f| f.write(helper_content) } if args[0] == "miner"
    puts Ajaila::Messager.success("Generated #{instance} #{args[1]} successfully!")    
  end
end
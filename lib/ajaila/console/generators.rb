# generating miners, selectors, tables and presenters 
command :g do |c|
  c.action do |global_options,options,args|

    check_inputs(args)
    content = ""
    if args[0] == "table"
      columns = additional_params(args)
      collection = args[1].capitalize
      key_pairs = parse_columns(columns)
      content = render("table", :collection => collection, :keys => key_pairs)
    end

    if args[0] == "selector"
      content = render("selector")
      io = additional_params(args)
      file = get_file(io)
      file_name = get_file(io).split(".").first.upcase
      table = get_table(io)
      all_columns = get_columns(table)
      clast = all_columns.pop
      cleft = all_columns
      content += "\n" + render( "_parser", :columns => cleft, :last => clast, :collection => table.capitalize, :file => file, :file_name => file_name )
    end

    if args[0] == "miner"
      content = render("miner", :miner => args[1].downcase)
      io = additional_params(args)
      get_tables(io).each do |table|
        all_columns = get_columns(table)
        clast = all_columns.pop
        cleft = all_columns
        content += "\n" + render( "_input", :columns => cleft, :last => clast, :collection => table.capitalize )
        content += "\n" + render( "_output", :columns => cleft, :last => clast, :collection => table.capitalize )
      end
    end
    
    if args[0] == "presenter"
      raise TypeError, warning("Presenters are not available, sorry")
    end

    dir = target_dir(args)
    File.open(ROOT + "/#{dir}#{args[1].downcase}.#{args[0]}.rb", 'w') {|f| f.write(content) }
    File.open(ROOT + "/sandbox/helpers/#{args[1].downcase}.helper.rb", 'w') {|f| f.write("") } if args[0] == "miner"
    puts success("Generated #{args[0]} #{args[1]} successfully!")    
  end
end
$:.unshift File.expand_path( "../generator_templates", __FILE__)
puts File.expand_path( "../generator_templates", __FILE__)
# generating miners,selectors,tables and presenters 
command :g do |c|
  c.action do |global_options,options,args|
  	root = true if Dir['*/'].include?("sandbox/") and Dir['*/'].include?("datasets/")
  	raise TypeError, 'Ajaila: please, run commands from the root directory'.color(Colors::YELLOW) if root != true
    known_instances = ["miner","selector","presenter","table","api"]
    raise TypeError, 'Ajaila: unknown command...'.color(Colors::YELLOW) if args == nil
  	instance_type = args[0]
  	raise TypeError, 'Ajaila: unknown instance (ex. miner SomeMiner, selector SomeSelector, presenter SomePresenter, table SomeTable)'.color(Colors::YELLOW) if known_instances.include?(instance_type) == false
    begin
      raise TypeError, 'Ajaila: unknown command...'.color(Colors::YELLOW) if args[1] == nil
      instance_name = args[1]
     rescue
      raise TypeError, 'Ajaila: define instance name (use only A-Z and a-z symbols)'.color(Colors::YELLOW) #if instance_name == nil
    end
    raise TypeError, 'Ajaila: wrong format for the instance name (use only A-Z and a-z symbols)'.color(Colors::YELLOW) if instance_name[/^[A-Z]+$/i] == nil
    puts "\tGenerating #{instance_type} #{instance_name}"
    dir = "datasets/" if instance_type == "selector"
    dir = "sandbox/miners/" if instance_type == "miner"
    dir = "sandbox/presenters/" if instance_type == "presenter"
    dir = "sandbox/tables/" if instance_type == "table"

    #content = "Uncle Tom\nwas singing in the dorm!"
    ext = "rb"
    if instance_type == "table"
      k, keys = 0, []
      args.each do |arg|
        k += 1
        next if k <= 2
        keys << arg
      end
      raise TypeError, 'Ajaila: define table parameters (name:String/Integer/Date/etc)'.color(Colors::YELLOW) if keys == nil
      content = ""
      begin
        lines = []
        lines << "MongoMapper.database = \"ajaila_db\"\n"
        lines << "class #{instance_name.capitalize}\n  include MongoMapper::Document\n"
        keys.each do |key_string|
          params = key_string.split(':')
          key_name = params[0]
          key_type = params[1]
          known_types = ["Array", "Float", "Hash", "Integer", "NilClass", "Object", "String", "Time", "Binary", "Boolean", "Date", "ObjectId", "Set"]
          raise TypeError, 'Ajaila: wrong format of table parameters (name:String/Integer/Date/etc)'.color(Colors::YELLOW) if known_types.include?(key_type.capitalize) == false
          line = "  key :#{key_name.downcase}, #{key_type.capitalize}\n"
          lines << line
        end
        lines << "end\n"
        content = lines.join
       rescue
        raise TypeError, 'Ajaila: wrong format of table parameters (name:String/Integer/Date/etc)'.color(Colors::YELLOW)
      end
    end


    if instance_type == "selector"
      begin
         using = false
         k, files, tables  = 0, [], []
         args.each do |arg|
           k += 1
           using = true if arg == "using" and k == 3
           next if k <= 3
           additions = arg.split(':')
           addition_type = additions[0].downcase
           addition_core = additions[1].downcase
           files << addition_core if addition_type == "file"
           tables << addition_core if addition_type == "table"
         end
         content = ""
         puts 'Ajaila: wrong parameters usage (ex. using file:SomeFile.csv)'.color(Colors::YELLOW) if using == true and files.empty?
         raise TypeError if using == true and files.empty?
         supported_files = ["csv"]
         lines = []
         table_data = {}
         if tables != []
           lines << "require \"csv\"\n"
           lines << "require \"mongo_mapper\"\n"
           tables.each do |table|
             lines << "require \"./sandbox/tables/#{table}.table\"\n"
             File.open("sandbox/tables/#{table}.table.rb", "r") do |infile|
               while (line = infile.gets)
                 clas = line[/class\s(\S+)/,1] if clas == nil
                 key = line[/key\s:(\S+),/,1]
                 table_data[clas] = [] if clas != nil and table_data[clas] == nil
                 table_data[clas] << key if key != nil
               end
             end
           end
         end

         if files != []
           files.each do |key_string|
             file = key_string.split('.')
             file_name = file[0]
             file_type = file[1]
             puts 'Ajaila: sorry, but we support only .csv for now...'.color(Colors::YELLOW) if supported_files.include?(file_type) == false or file_type == nil
             raise TypeError if supported_files.include?(file_type.to_s) == false or file_type == nil
             if file_type == "csv"
               cs = 1 if cs == nil
               kf = "qwerty".split("").shuffle.join.upcase
               lines << "require \"csv\"\n" if cs == nil
               lines << "#{kf} = File.expand_path(\"./datasets/raw/#{file_name.downcase}.#{file_type.downcase}\")\n\n"
               lines << "CSV.foreach(#{kf}) do |row|\n"
               table_data.each_key do |table|
                 table_data[table].each do |key|
                   lines <<  "  #{key} = row[0] # put other indexes instead of 0\n"
                 end
               end
               if tables != []
                 table_data.each_key do |table|
                   lines << "  #{table}.create("
                   table_data[table].each do |key|
                     lines << "#{key}: #{key}, " if key != table_data[table].last
                     lines << "#{key}: #{key}" if key == table_data[table].last
                   end
                   lines << ")\n"
                 end
               end
               lines << "end\n\n"
             end
           end
         end


        if using == true
         puts "Ajaila: No selector title, file or table was selected \n( add: using file:SomeFile.csv table:SomeTable )".color(Colors::YELLOW) if files == [] or tables == [] 
         raise TypeError if files == [] or tables == [] 
        end
         content = lines.join
       rescue
        raise TypeError, 'Ajaila: wrong command...'.color(Colors::RED)
      end
    end

    if instance_type == "miner"
      begin
         using = false
         k, tables  = 0, []
         args.each do |arg|
           k += 1
           using = true if arg == "using" and k == 3
           next if k <= 3
           additions = arg.split(':')
           addition_type = additions[0].downcase
           addition_core = additions[1].downcase
           tables << addition_core if addition_type == "table"
         end
         content = ""
         lines = []
         table_data = {}
         if tables != []
           lines << "require \"mongo_mapper\"\n"
           tables.each do |table|
             lines << "require \"./sandbox/tables/#{table}.table\"\n"
             File.open("sandbox/tables/#{table}.table.rb", "r") do |infile|
               while (line = infile.gets)
                 clas = line[/class\s(\S+)/,1] if clas == nil
                 key = line[/key\s:(\S+),/,1]
                 table_data[clas] = [] if clas != nil and table_data[clas] == nil
                 table_data[clas] << key if key != nil
               end
             end
           end

           table_data.each_key do |table|
             lines << "  #{table}.create("
             table_data[table].each do |key|
               lines << "#{key}: #{key}, " if key != table_data[table].last
               lines << "#{key}: #{key}" if key == table_data[table].last
             end
             lines << ")\n"
           end
         end

        if using == true
         puts "Ajaila: No selector title or table was selected \n( add: using file:SomeFile.csv table:SomeTable )".color(Colors::YELLOW) if files == [] or tables == [] 
         raise TypeError if tables == [] 
        end
         content = lines.join
       rescue
        raise TypeError, 'Ajaila: wrong command...'.color(Colors::RED)
      end
    end
    
    if instance_type == "presenter"
      begin
         ext = "erb"
         using = false
         k, tables  = 0, []
         args.each do |arg|
           k += 1
           using = true if arg == "using" and k == 3
           next if k <= 3
           additions = arg.split(':')
           addition_type = additions[0].downcase
           addition_core = additions[1].downcase
           tables << addition_core if addition_type == "table"
         end
         content = ""
         lines = []
         table_data = {}
         if tables != []
           tables.each do |table|
             File.open("sandbox/tables/#{table}.table.rb", "r") do |infile|
               while (line = infile.gets)
                 clas = line[/class\s(\S+)/,1] if clas == nil
                 key = line[/key\s:(\S+),/,1]
                 table_data[clas] = [] if clas != nil and table_data[clas] == nil
                 table_data[clas] << key if key != nil
               end
             end
           end

           table_data.each_key do |table|
             lines << "<% #{table}.all.each do |d| %>\n"
             table_data[table].each do |key|
               lines << "  <div><b>#{key}</b>: <%= d.#{key} %></div>\n"
             end
             lines << "  <br>\n"
             lines << "<% end %>"
           end
         end

         route = []
         route << "\n"
         route << "get \"/#{instance_name.downcase}\" do\n"
         route << "  erb \"#{instance_name.downcase}.presenter\".to_sym\n"
         route << "end\n"
         File.open("service.rb", "a") do |file|
           file.puts route
         end

        if using == true
         puts "Ajaila: No presenter title or table was selected \n( add: using file:SomeFile.csv table:SomeTable )".color(Colors::YELLOW) if files == [] or tables == [] 
         raise TypeError if tables == [] 
        end
         content = lines.join
       rescue
        raise TypeError, 'Ajaila: wrong command...'.color(Colors::RED)
      end
    end

    if instance_type == "api"
      begin
         using = false
         k, tables  = 0, []
         route = []
         args.each do |arg|
           k += 1
           using = true if arg == "using" and k == 3
           next if k <= 3
           additions = arg.split(':')
           addition_type = additions[0].downcase
           addition_core = additions[1].downcase
           tables << addition_core if addition_type == "table"
         end
         content = ""
         lines = []
         table_data = {}
         if tables != []
           tables.each do |table|
             File.open("sandbox/tables/#{table}.table.rb", "r") do |infile|
               while (line = infile.gets)
                 clas = line[/class\s(\S+)/,1] if clas == nil
                 key = line[/key\s:(\S+),/,1]
                 table_data[clas] = [] if clas != nil and table_data[clas] == nil
                 table_data[clas] << key if key != nil
               end
             end
           end
           table_data.each_key do |table|
             table_data[table].each do |key|
               route << "\nget '/api/#{instance_name.downcase}/#{key}/:key' do\n"
               route << "  data = #{table}.where(:#{key} => params[:key] )\n"
               route << "  if data\n"
               route << "    data.to_json\n"
               route << "   else\n"
               route << "     error 404, {:error => \"item not found\"}.to_json\n"
               route << "  end\n"
               route << "end\n"
             end
           end
         end
         route.join
         File.open("service.rb", "a") do |file|
           file.puts route
         end

        if using == true
         puts "Ajaila: No api title or table was selected \n".color(Colors::YELLOW) if tables == [] 
         raise TypeError if tables == [] 
        end
         content = lines.join
       rescue
        raise TypeError, 'Ajaila: wrong command...'.color(Colors::RED)
      end
    end

    File.open("#{dir}#{instance_name.downcase}.#{instance_type}.#{ext}", 'w') {|f| f.write(content) } if instance_type != "api"
    puts "\tGenerated #{instance_type} #{instance_name} successfully!".color(Colors::GREEN)
    
  end

end
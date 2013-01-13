KNOWN_INSTANCES = ["miner","selector","presenter","table","api"]
KNOWN_CLASSES = ["Array", "Float", "Hash", "Integer", "NilClass", "Object", "String", "Time", "Binary", "Boolean", "Date", "ObjectId", "Set"]
TEMPLATES = File.expand_path( "../generator_templates", __FILE__)
SUPPORTED_INPUTS = ["csv"]

def check_inputs(args)
  raise TypeError, warning("Nothing to generate...") if args == []
  raise TypeError, warning("Only miners, slectors, presenters supported\n(ex. miner SomeMiner, selector SomeSelector,\n presenter SomePresenter, table SomeTable)") if KNOWN_INSTANCES.include?(args[0]) == false
  raise TypeError, warning("Your #{args[0]} needs a name!") if args[1] == nil
  raise TypeError, warning("Wrong format of the #{args[0]} name (use only A-Z and a-z symbols)") if args[1][/^[A-Z]+$/i] == nil
end

def additional_params(args)
  k, keys = 0, []
  args.each do |arg|
    k += 1
    next if k <= 2
    keys << arg
  end
  raise TypeError, warning("\"#{args[1]}\" #{args[0]} needs additional parameters to be specified") if keys == []
  return keys
end

def target_dir(args)
  return "datasets/" if args[0] == "selector"
  return "sandbox/miners/" if args[0] == "miner"
  return "sandbox/presenters/" if args[0] == "presenter"
  return "sandbox/tables/" if args[0] == "table"
end

def parse_columns(columns)
  pairs = []
  columns.each do |key_string|
    params = key_string.split(':')
    raise TypeError, warning("Wrong format of table parameters (name:String/Integer/Date/etc)") if KNOWN_CLASSES.include?(params[1].capitalize) == false
    pairs << [params[0].downcase, params[1].capitalize]
  end
  return pairs
end

def get_tables(params)
  tables = []
  params.each do |param|
  	p = param.split(":")
  	next if p.first != "table"
    tables << p[1] if p[0] == "table"
  end
  raise TypeError, warning("No tables included. Add: \"table:SomeTable\"") if tables == []
  return tables
end

def get_files(params)
  files = []
  params.each do |param|
  	p = param.split(":")
  	next if p.first != "file"
  	raise TypeError, warning("Sorry, but extension of #{p[1]} is not supported") if SUPPORTED_INPUTS.include?(p[1].split(".")[1].downcase) == false
    files << p[1] if p[0] == "file"
  end
  raise TypeError, warning("No file included. Add: \"file:file_name.csv\"") if files == []
  return files
end

def get_file(params)
  files = get_files(params)
  raise TypeError, warning("Only one file can be included") if files.length > 1
  return files[0]
end

def get_table(params)
  tables = get_tables(params)
  raise TypeError, warning("Only one table can be included") if tables.length > 1
  return tables[0]
end

def render(template, *params)
  Tilt.new(TEMPLATES + "/" + template + ".liquid").render(nil, *params)
end

def get_columns(table)
  columns = []
  File.open(ROOT+"/sandbox/tables/#{table.downcase}.table.rb", "r") do |infile|
    while (line = infile.gets)
      key = line[/key\s:(\S+),/,1]
      columns << key if key != nil
    end
  end
  raise TypeError, warning("Could not open \"#{table}\". There is something wrong with it.") if columns == []
  return columns
end
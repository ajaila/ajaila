KNOWN_INSTANCES = ["miner","selector","presenter","table","api"]
KNOWN_CLASSES = ["Array", "Float", "Hash", "Integer", "NilClass", "Object", "String", "Time", "Binary", "Boolean", "Date", "ObjectId", "Set"]
TEMPLATES = File.expand_path( "../generator_templates", __FILE__)

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
  raise TypeError, warning("\"#{args[1]}\" #{args[0]} needs\n additional parameters to be specified") if keys == []
  return keys
end

def target_dir(args)
  dir = "datasets/" if args[0] == "selector"
  dir = "sandbox/miners/" if args[0] == "miner"
  dir = "sandbox/presenters/" if args[0] == "presenter"
  dir = "sandbox/tables/" if args[0] == "table"
end

def parse_columns(columns)
  pairs = []
  columns.each do |key_string|
    params = key_string.split(':')
    raise TypeError, warning("Wrong format of table parameters\n(name:String/Integer/Date/etc)") if KNOWN_CLASSES.include?(params[1].capitalize) == false
    pairs << [params[0].downcase, params[1].capitalize]
  end
  return pairs
end

def render(template, *params)
  puts *params
  Tilt.new(TEMPLATES + "/" + template + ".liquid").render(nil, *params)
end
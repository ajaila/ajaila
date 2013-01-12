command :run do |c|
  c.action do |global_options,options,args|
    type = args[0]
    name = args[1]
    dir = ""
    dir = "sandbox/miners/" if type == "miner"
    dir = "datasets/" if type == "selector"
    raise TypeError, 'Ajaila: unknown instance...'.color(Colors::YELLOW) if dir == "" if type != "s"
    raise TypeError, 'Ajaila: no title for instance...'.color(Colors::YELLOW) if name == "" if type != "s"
    require "./#{dir}#{name.downcase}.#{type.downcase}" if type != "s"
    require "./service" if type == "s"
  end
end

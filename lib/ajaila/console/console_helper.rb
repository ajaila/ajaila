$:.unshift File.expand_path("../", __FILE__)
require "messager"

KNOWN_INSTANCES = ["miner","selector","presenter","table","api"]
KNOWN_CLASSES = ["Array", "Float", "Hash", "Integer", "NilClass", "Object", "String", "Time", "Binary", "Boolean", "Date", "ObjectId", "Set"]
TEMPLATES = File.expand_path( "../generator_templates", __FILE__)
SUPPORTED_INPUTS = ["csv"]

module Ajaila
  module ConsoleHelper
    self.extend Ajaila::ConsoleHelper

  ##
  # Checks parameters of the "ajaila g ____" command
  def check_inputs_g(args)
    raise TypeError, Ajaila::Messager.warning("Nothing to generate...") if args == []
    raise TypeError, Ajaila::Messager.warning("Only miners, selectors, presenters supported\n(ex. miner SomeMiner, selector SomeSelector,\n presenter SomePresenter, table SomeTable)") if KNOWN_INSTANCES.include?(args[0]) == false
    raise TypeError, Ajaila::Messager.warning("Your #{args[0]} needs a name!") if args[1] == nil
    raise TypeError, Ajaila::Messager.warning("Wrong format of the #{args[0]} name (use only A-Z and a-z symbols)") if args[1][/^[A-Z]+$/i] == nil
    return 0
  end

  ##
  # ajaila g something name _________
  def additional_params(args)
    k, keys = 0, []
    args.each do |arg|
      k += 1
      next if k <= 2
      keys << arg
    end
    if keys == []
      raise TypeError, Ajaila::Messager.warning("\"#{args[1]}\" #{args[0]} should have table and file (ex. ajaila g selector Wow file:in.csv table:Output). Don't forget to put file inside datasets directory and generate table before that.") if args[0] == "selector"
      raise TypeError, Ajaila::Messager.warning("\"#{args[1]}\" #{args[0]} should have tables for input and output (ex. ajaila g miner Foo table:FooTable table:Yamy)") if args[0] == "miner"
      raise TypeError, Ajaila::Messager.warning("\"#{args[1]}\" #{args[0]} needs additional parameters to be specified") if args[0] == "presenter"
      raise TypeError, Ajaila::Messager.warning("\"#{args[1]}\" #{args[0]} should have columns (ex. ajaila g table MyTable name:String age:Integer birth:Time)") if args[0] == "table"
    end
    return keys
  end

  ##
  # returns target dir
  def target_dir(instance)
    return "datasets/" if instance == "selector"
    return "sandbox/miners/" if instance == "miner"
    return "sandbox/presenters/" if instance == "presenter"
    return "sandbox/tables/" if instance == "table"
  end

  ##
  # name:String age:integer => [["name", "String"],["age", "Integer"]]
  def parse_columns(columns)
    pairs = []
    columns.each do |key_string|
      params = key_string.split(':')
      raise TypeError, Ajaila::Messager.warning("Wrong format of table parameters (name:String/Integer/Date/etc)") if KNOWN_CLASSES.include?(params[1].capitalize) == false
      pairs << [params[0].downcase, params[1].capitalize]
    end
    return pairs
  end

  ##
  # gets tables out of additional params
  def get_tables(params)
    tables = []
    params.each do |param|
    	p = param.split(":")
    	next if p.first != "table"
      tables << p[1] if p[0] == "table"
    end
    raise TypeError, Ajaila::Messager.warning("No tables included. Add: \"table:SomeTable\"") if tables == []
    return tables
  end

  ##
  # get files: file:foo.csv => ["foo.csv"]
  def get_files(params)
    files = []
    params.each do |param|
    	p = param.split(":")
    	next if p.first != "file"
    	raise TypeError, Ajaila::Messager.warning("Sorry, but extension of #{p[1]} is not supported") if SUPPORTED_INPUTS.include?(p[1].split(".")[1].downcase) == false
      files << p[1] if p[0] == "file"
    end
    raise TypeError, Ajaila::Messager.warning("No file included. Add: \"file:file_name.csv\"") if files == []
    return files
  end

  def get_file(params)
    files = get_files(params)
    raise TypeError, Ajaila::Messager.warning("Only one file can be included") if files.length > 1
    return files[0]
  end

  def get_table(params)
    tables = get_tables(params)
    raise TypeError, Ajaila::Messager.warning("Only one table can be included") if tables.length > 1
    return tables[0]
  end

  def render(template, *params)
    Tilt.new(TEMPLATES + "/" + template + ".liquid").render(nil, *params)
  end

  def get_columns(table)
    columns = []
    table = name_to_file(table)
    File.open(ROOT+"/sandbox/tables/#{table}.table.rb", "r") do |infile|
      while (line = infile.gets)
        key = line[/key\s:(\S+),/,1]
        columns << key if key != nil
      end
    end
    raise TypeError, Ajaila::Messager.warning("Could not open \"#{table}\". There is something wrong with it.") if columns == []
    return columns
  end

  ##
  # FileName => file_name, File => file
  def name_to_file(name)
    array = name.scan(/[A-Z][a-z]*/)
    raise TypeError, Ajaila::Messager.warning("The name of variable should start with capital letter: \"table:MyTable\"") if array == []
    return array.map(&:downcase).join("_")
  end

  ##
  # file_name => FileName, file => File
  def file_to_name(file)
    return file.split("_").map(&:capitalize).join
  end

  end
end
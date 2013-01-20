require File.join(File.dirname(__FILE__), "/../spec_helper")

describe Ajaila do
  it "should check inputs" do
  	# ajaila g miner Foo
  	args = ["miner", "Foo"]
  	Ajaila::ConsoleHelper.check_inputs_g(args).should == 0

  	# ajaila g selector Foo  	
  	args = ["selector", "Foo"]
  	Ajaila::ConsoleHelper.check_inputs_g(args).should == 0

  	# ajaila g table Foo
  	args = ["table", "Foo"]
  	Ajaila::ConsoleHelper.check_inputs_g(args).should == 0

  	# ajaila g presenter Foo
  	args = ["presenter", "Foo"]
  	Ajaila::ConsoleHelper.check_inputs_g(args).should == 0

  	# ajaila g shit Foo
  	# args = ["shit", "Foo"]
  	# Ajaila::ConsoleHelper.check_inputs_g(args).should raise_error

  	# ajaila g miner
  	# args = ["miner"]
    # Ajaila::ConsoleHelper.check_inputs_g(args).should raise_error
  end

  it "should check additional parameters" do
    # args = ["miner", "Foo"]
    # Ajaila::ConsoleHelper.additional_params(args).should raise_error

    args = ["miner", "Foo", "lalala", "pampam"]
    Ajaila::ConsoleHelper.additional_params(args).should == ["lalala", "pampam"]
  end

  it "should return target dir" do
    instance = "miner"
    Ajaila::ConsoleHelper.target_dir(instance).should == "sandbox/miners/"
    instance = "selector"
    Ajaila::ConsoleHelper.target_dir(instance).should == "datasets/"
    instance = "presenter"
    Ajaila::ConsoleHelper.target_dir(instance).should == "sandbox/presenters/"
    instance = "table"
    Ajaila::ConsoleHelper.target_dir(instance).should == "sandbox/tables/"
  end

  it "should parse columns" do
  	columns = ["name:String","age:integer"]
    Ajaila::ConsoleHelper.parse_columns(columns).should == [["name", "String"],["age", "Integer"]]
    # columns = []
    # Ajaila::ConsoleHelper.parse_columns(columns).should raise_error
    # columns = ["animal:Monkey"]
    # Ajaila::ConsoleHelper.parse_columns(columns).should raise_error
  end

  it "should get tables" do
  	params = ["table:Foo","file:Nooo","table:Lol"]
    Ajaila::ConsoleHelper.get_tables(params).should == ["Foo","Lol"]
    Ajaila::ConsoleHelper.get_tables(params).include?("Nooo").should_not == true
    # params = []
    # Ajaila::ConsoleHelper.get_tables(params).should raise_error
  end

  it "should get files" do
  	params = ["table:Foo","file:foo.csv","table:Lol", "file:boo.csv"]
    Ajaila::ConsoleHelper.get_files(params).should == ["foo.csv","boo.csv"]
    # params = ["table:Foo","file:foo.csv","table:Lol", "file:boo.csd"]
    # Ajaila::ConsoleHelper.get_files(params).should raise_error
  end

  it "should convert name to file" do
    a = "File"
    b = "FileName"
    c = "FileNameFoo"
    Ajaila::ConsoleHelper.name_to_file(a).should == "file"
    Ajaila::ConsoleHelper.name_to_file(b).should == "file_name"
    Ajaila::ConsoleHelper.name_to_file(c).should == "file_name_foo"
  end

end

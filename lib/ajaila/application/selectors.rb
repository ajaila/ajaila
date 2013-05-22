class Selectors < App
  @selectors = []
  SELECTOR_METHODS = [:prepare, :import]

  def self.all
    @selectors
  end

  def from_file(file)
    "#{ROOT}/datasets/raw/#{file}"
  end

  def direct_import_from_csv(dataset, opts = {:to => nil, :delimiter => nil, :header => nil})
    puts Ajaila::Messager.info("Make sure that columns order in the table is similar to the one in the file.")
    delimiter = opts[:delimiter] || ","
    header = "HEADER" if opts[:header] == true
    table = opts[:to].table_name
    raise TypeError, Ajaila::Messager.error("Dataset is not specified...") if dataset.class != String
    ActiveRecord::Base.connection.execute("COPY #{table} FROM '#{dataset}' DELIMITER \'#{delimiter}\' CSV #{header}")
  end
  
  private  

  def self.inherited(selector)
    @selectors << selector
    add_execution(selector)
  end

  def self.add_execution(selector)
    selector.define_singleton_method(:execute) do
      check_requirements(selector)
      selector_instance = selector.new
      SELECTOR_METHODS.each { |operation| selector_instance.send(operation) }
    end
  end

  def self.check_requirements(selector)
    SELECTOR_METHODS.each do |method|
      raise "Oops... There is no #{method} for #{selector}..." if selector.instance_methods.include?(method) == false
    end
  end

end
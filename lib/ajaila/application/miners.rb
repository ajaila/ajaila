class Miners < App
  @miners = []
  MINER_METHODS = [:input, :process, :output]

  def self.all
    @miners
  end
  
  private

  def self.inherited(miner)
    @miners << miner
    add_execution(miner)
  end    

  def self.add_execution(miner)
    miner.define_singleton_method(:execute) do
      check_requirements(miner)
      miner_instance = miner.new
      MINER_METHODS.each { |operation| miner_instance.send(operation) }
    end
  end

  def self.check_requirements(miner)
    MINER_METHODS.each do |method|
      raise "Oops. There is no #{method} for #{miner}..." if miner.instance_methods.include?(method) == false
    end
  end

end

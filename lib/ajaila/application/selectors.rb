class App
  class Selectors
    @selectors = []
    SELECTOR_METHODS = [:import]

    def self.inherited(selector)
      @selectors << selector
      add_execution(selector)
    end
    
    def self.add_execution(selector)
      selector.class.send(:define_method, :execute) do
        check_requirements(selector)
        selector_instance = selector.new
        SELECTOR_METHODS.each { |operation| selector_instance.send(operation) }
      end
    end

    def self.check_requirements(selector)
      SELECTOR_METHODS.each do |method|
        raise "Oops. There is no #{method} for #{selector}..." if selector.instance_methods.include?(method) == false
      end
    end
  end
end
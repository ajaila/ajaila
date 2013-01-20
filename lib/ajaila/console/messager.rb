$:.unshift File.expand_path("../", __FILE__)
require "styling"

module Ajaila
  module Messager
  	self.extend Ajaila::Messager

    def build_block(text)
      output = "Ajaila: " + text
      return output
    end
    
    def warning(text)
      build_block(text).color(Colors::WARNING)
    end
    
    def error(text)
      build_block(text).color(Colors::ERROR)
    end
    
    
    def info(text)
      build_block(text).color(Colors::INFO)
    end
    
    def success(text)
      build_block(text).color(Colors::SUCCESS)
    end

  end
end
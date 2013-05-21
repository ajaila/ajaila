module Ajaila
  module RootDefiner
    self.extend Ajaila::RootDefiner
    
    ##
    # Returns true if the input path is the application root.
    def root?(path)
    
        root_objects = ["gemfile", "procfile", "readme"]
        current_objects = Dir[path + "/*"].map do |file|
          File.basename(file).downcase
        end
        dir = ""
        current_objects.each do |co|
           dir = (root_objects.include?(co) == true)? "ROOT" : "NOT ROOT"
           break if dir == "ROOT"
        end
        return true if dir == "ROOT"
        return false if dir == "NOT ROOT"
    
    end

    ##
    # Recursive method, which tries to find the application root.
    def find_root(path)
      path = File.expand_path('..', path) if root?(path) == false
      find_root(path) if root?(path) == false
      return path if root?(path) == true
    end

    def set_root
      begin
        Object.const_set("ROOT", find_root(Dir::pwd)) unless defined?( ROOT )
      rescue SystemStackError
        raise Ajaila::Messager.error("PLEASE, GO THE DIRECTORY OF YOUR APP")
      end
    end 

  end
end

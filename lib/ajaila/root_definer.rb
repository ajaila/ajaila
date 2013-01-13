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
  puts path
  return path if root?(path) == true
end

begin
  ROOT = find_root(Dir::pwd)
rescue SystemStackError
    error = %Q{
#############################################################################
#                                                                           #
#                   PLEASE, GO THE DIRECTORY OF YOUR APP                    #
#                             Type: cd YourApp                              #
#                                                                           #
#############################################################################
                }
    raise error.color(Colors::WARNING)
end

puts ROOT
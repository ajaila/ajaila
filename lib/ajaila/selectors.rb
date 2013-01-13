require "ajaila/root_definer"
$:.unshift File.expand_path("../config", [ROOT+"/*"][0])
$:.unshift File.expand_path("../sandbox/helpers", [ROOT+"/*"][0])

require "csv"
require "db"
require "application.helper"

def import(file)
  input = file.split(".").first.upcase
  path_with_file = ROOT+"/datasets/raw/"+file
  Object.const_set(input, path_with_file)  
end

# import("in.csv")

# CSV.foreach(IN) do |row|
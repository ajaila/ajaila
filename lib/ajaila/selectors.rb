require "ajaila/root_definer"
Ajaila::RootDefiner.set_root
$:.unshift File.expand_path("../config", [ROOT+"/*"][0])
$:.unshift File.expand_path("../sandbox/helpers", [ROOT+"/*"][0])

require "csv"
require "db"
require "application.helper"

def import(file)
  ROOT+"/datasets/raw/"+file
end
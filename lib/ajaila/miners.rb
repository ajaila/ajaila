require "ajaila/root_definer"
set_root
$:.unshift File.expand_path("../config", [ROOT+"/*"][0])
$:.unshift File.expand_path("../sandbox/helpers", [ROOT+"/*"][0])

require "db"
require "application.helper"

$:.unshift File.expand_path("../", __FILE__)
require "root_definer"
Ajaila::RootDefiner.set_root # rescue nil

require "application/app"

require 'active_record'
require 'data_miner'
require 'squeel'
require 'logger'
require 'pg'
require 'yaml'

$:.unshift ROOT
Dir.glob(ROOT + "/lib/*.rb").each do |extension|
  require "lib/#{File.basename(extension)}"
end

DB_CONFIG = YAML::load(File.open(ROOT + "/config/database.yml"))
ActiveRecord::Base.establish_connection(DB_CONFIG["development"])
ActiveRecord::Base.logger = Logger.new(STDERR)

Dir.glob(ROOT + "/sandbox/tables/*.table.rb").each do |table|
  require "sandbox/tables/#{File.basename(table)}"
end

Dir.glob(ROOT + "/sandbox/miners/*.miner.rb").each do |miner|
  require "sandbox/miners/#{File.basename(miner)}"
end

Dir.glob(ROOT + "/datasets/*.selector.rb").each do |selector|
  require "datasets/#{File.basename(selector)}"
end
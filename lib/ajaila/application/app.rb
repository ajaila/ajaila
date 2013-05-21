$:.unshift File.expand_path("../", __FILE__)

class App
  def reset(model)
    ActiveRecord::Migration.drop_table(model.table_name) rescue nil
    model.auto_upgrade!
  end

  def update(model)
    model.auto_upgrade!
  end
end

require "selectors"
require "miners"

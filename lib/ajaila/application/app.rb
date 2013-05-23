$:.unshift File.expand_path("../", __FILE__)

class App
  def reset(model)
    ActiveRecord::Migration.drop_table(model.table_name) rescue nil
    model.auto_upgrade!
  end

  def update(model)
    model.auto_upgrade!
  end

  def export_to_csv(array, title, path = "#{ROOT}/datasets/raw/temp")
  	file_name = "#{title}_#{Time.now.day}_#{Time.now.month}_#{Time.now.year}.csv"
  	file = "#{path}/#{file_name}"
    content = CSV.generate { |csv| array.each { |row| csv << row } }
    File.open(file, 'w'){ |f| f.write(content) }
  	puts Ajaila::Messager.success("The CSV file (#{file_name}) is saved at: #{path}!")
  end

end

require "selectors"
require "miners"
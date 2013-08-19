require 'csv'

class Ajaila::CsvReport < Ajaila::Report
  FIELDS_MAPPING = []

  # @overload
  # @param [String] path
  def export(path = 'tmp')
    path = File.join(path, filename)
    File.open(path, 'w'){ |f| f.write(generate) }
    Ajaila::Logger.hint("The CSV report has been saved in #{path}")
  end

  # @todo(MM) specs (only 1: just check returning value)
  # @return [String]
  def filename
    result = self.class.name.gsub(/[^0-9A-Za-z.\-]/, '_')
    # @todo(MM) use time format tools instead
    "#{result}_#{Time.now.day}_#{Time.now.month}_#{Time.now.year}.csv"
  end

  # @overload
  # Generates report from the data fetched in datasource
  # @return [String]
  def generate
    CSV.generate { |csv| rows.each { |row| csv << row } }
  end

  # @return [ActiveRecord::Relation]
  def row_records
    raise NotImplementedError
  end

  # @todo(MM) specs
  # @return [Array<Array>]
  def rows
    [].tap do |result|
      result << self.class.header

      row_records.find_each do |record|
        result << represent(record)
      end
    end
  end

  # Builds CSV row
  # @param [record] record AR object
  # @return [Array]
  def represent(record)
    self.class.fields.map { |field| send(field, record) }
  end

  # @todo(MM) specs
  def self.header
    self::FIELDS_MAPPING.map { |_, title| title }
  end

  # @todo(MM) specs
  def self.fields
    self::FIELDS_MAPPING.map { |field, _| field }
  end
end

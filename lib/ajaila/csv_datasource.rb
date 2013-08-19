class Ajaila::CsvDatasource < Ajaila::Datasource

  attr_reader :file_path, :model

  # @param [String] file_path Where to find csv file (relative to project directory)
  # @param [Class] model An AR model to copy data into
  def initialize(file_path, model)
    @file_path = File.join(Dir.pwd, file_path)
    @model = model
  end

  # @return [Hash]
  def data
    [].tap do |result|
      CSV.foreach(file_path, headers: true, header_converters: :symbol, converters: :all) do |row|
        result << {}.tap do |csv_row|
          row.headers.each_with_index do |key, i|
            csv_row[key] = row.fields[i]
          end
        end
      end
    end
  end

  # Supports Postgres only. Needs to be moved to ActiveRecord extensions.
  # @param [String] dataset Where to find csv file (relative to project directory)
  # @param [Hash] opts Parameters of the import. 
  def direct_import_from_csv(dataset, opts = {:to => nil, :delimiter => nil, :header => nil})
    delimiter = opts[:delimiter] || ","
    header = "HEADER" if opts[:header] == true
    table = opts[:to].table_name
    raise TypeError if dataset.class != String
    ActiveRecord::Base.connection.execute("COPY #{table} FROM '#{dataset}' DELIMITER \'#{delimiter}\' CSV #{header}")
  end

end

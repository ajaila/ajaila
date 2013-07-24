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

  # Needs to be deprecated.
  # @overload
  def import
    model.reset!
    direct_import_from_csv
  end

  protected

  # @param [String] delimiter CSV splitting character: , ; | etc
  # @param [true, false] use_header
  # def direct_import_from_csv(delimiter = ',', use_header = true)
  #   ActiveRecord::Base.connection.
  #                      execute(%Q{COPY #{model.table_name} FROM '#{file_path}'
  #                                 DELIMITER \'#{delimiter}\' CSV #{"HEADER" if use_header}})
  # end

  def direct_import_from_csv(dataset, opts = {:to => nil, :delimiter => nil, :header => nil})
    delimiter = opts[:delimiter] || ","
    header = "HEADER" if opts[:header] == true
    table = opts[:to].table_name
    raise TypeError if dataset.class != String
    ActiveRecord::Base.connection.execute("COPY #{table} FROM '#{dataset}' DELIMITER \'#{delimiter}\' CSV #{header}")
  end

end

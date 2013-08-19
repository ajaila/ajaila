module Ajaila
  class Report

    # Writes report data to on filesystem
    # @param [String] path Where to save
    # @return [String]
    def export(path)
      raise NotImplementedError
    end

    # Generates report from the data fetched in datasource
    # @return [String]
    def generate
      raise NotImplementedError
    end
  end
end
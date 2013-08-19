class Ajaila::Job

  # Performs job.
  # @example steps
  #   1) Datasource.new.import
  #   2) Report.new.export
  def perform
    raise NotImplementedError
  end
end
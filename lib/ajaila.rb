require 'active_record_inline_schema'
require 'active_record'
require 'squeel'

require 'ajaila/extensions/active_record'
require 'ajaila/datasource'
require 'ajaila/csv_datasource'
require 'ajaila/report'
require 'ajaila/csv_report'
require 'ajaila/job'
require 'ajaila/logger'
require 'ajaila/application'

module Ajaila
  VERSION = "0.0.1"

  # @return [Ajaila::Application]
  def self.app
    @app
  end

  # @todo: remove?
  # @param [Ajaila::Application] app
  def self.app=(app)
    @app = app
  end
end

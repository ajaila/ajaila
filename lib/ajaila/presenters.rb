require "ajaila/root_definer"


Ajaila::RootDefiner.set_root
$:.unshift File.expand_path("../config", [ROOT+"/*"][0])
$:.unshift File.expand_path("../sandbox/helpers", [ROOT+"/*"][0])

require "db"
require "application.helper"
require 'rubyvis'

module Ajaila
  module Presenters
    self.extend Ajaila::Presenters
    def create_dashboard
      set :views, [ "#{ROOT}/sandbox/presenters", File.expand_path("../dashboard/", __FILE__) ]
      helpers do
        def find_template(views, name, engine, &block)
          Array(views).each { |v| super(v, name, engine, &block) }
        end
      end
    end
  end
end



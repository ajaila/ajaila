require "ajaila/root_definer"


Ajaila::RootDefiner.set_root
$:.unshift File.expand_path("../config", [ROOT+"/*"][0])
$:.unshift File.expand_path("../sandbox/helpers", [ROOT+"/*"][0])

require "db"
require "environment"
require "application.helper"
require 'rubyvis'

DIR = File.expand_path("../dashboard/", __FILE__)

module Ajaila
  module Presenters
    self.extend Ajaila::Presenters
    def create_dashboard
      set :port, 9500
      set :views, [ "#{ROOT}/sandbox/presenters", DIR ]
      helpers do
        def find_template(views, name, engine, &block)
          Array(views).each { |v| super(v, name, engine, &block) }
        end
      end
      set :public_folder, File.dirname(__FILE__) + '/dashboard/public'
      build_routes
    end

    def presenters
      Dir.glob("#{ROOT}/sandbox/presenters/*.erb").map do |presenter|
        p = presenter.split("/").last.split(".").first
      end
    end

    def build_routes
      presenters.each do |p|
        get "/#{p}" do
          erb :"#{p}.presenter"
        end
      end
      get '/' do
        erb :index
      end
    end

  end
end



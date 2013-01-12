# generating new application
command :new do |c|
  c.action do |global_options,options,args|
    app_name = args.first
    raise TypeError, 'Ajaila: you should enter the name for your app!'.color(Colors::RED) if app_name == nil
    puts "Ajaila: generating new application \"#{app_name}\"".color(Colors::GREEN)
    app_root = Dir::pwd + "/" + app_name
    begin
      Dir::mkdir(app_root)
      puts "\tcreated application root"
     rescue
      raise TypeError, "Ajaila: try another name, \"#{app_name}\" folder already exists!".color(Colors::RED)
    end

    # creating directories
    Dir::mkdir("#{app_root}/assets")
    puts "\tprepared Assets"
    Dir::mkdir("#{app_root}/config")
    puts "\tprepared Config"
    Dir::mkdir("#{app_root}/datasets")
    puts "\tprepared Datasets directory"
    Dir::mkdir("#{app_root}/datasets/raw")
    puts "\tprepared Raw folder in the Datasets directory"
    Dir::mkdir("#{app_root}/sandbox")
    puts "\tprepared Sandbox directory"
    Dir::mkdir("#{app_root}/sandbox/miners")
    puts "\tprepared Miners folder in the Sandbox directory"
    Dir::mkdir("#{app_root}/sandbox/presenters")
    puts "\tprepared Presenters folder in the Sandbox directory"
    Dir::mkdir("#{app_root}/sandbox/tables")
    puts "\tprepared Tables folder in the Sandbox directory"

    # creating files
    gemfile_content = "source \"http://rubygems.org\"\n\ngem \"ajaila\""
    File.open("#{app_root}/Gemfile", 'w') {|f| f.write(gemfile_content) }
    puts "\tprepared Gemfile"

           
    service_content = []
    service_content << %Q{require "rubygems"\nrequire "sinatra"\nrequire "erb"\nrequire 'sinatra/assetpack'\nrequire \"mongo_mapper\"\n }
    Dir.glob('sandbox/tables/*.rb').each do |table|
      service_content << "require \'./sandbox/tables/#{table.split("/").last}'\n"
    end 
service_content << %Q{configure do
  MongoMapper.database = "ajaila_db"
end
  
set :views, settings.root + '/sandbox/presenters'

Dir.glob("sandbox/tables/*.rb").each do |table|
  puts "Loading tables..."
  require "./\#\{table\}"
end

helpers do
  def partial template
    erb template, :layout => false
  end
end

# assets do  
#   serve '/css', from: '/assets/css'
#   serve '/js', from: '/assets/js'
#   css :main, ['/css/*.css']
#   js :main, ['/js/jquery.js','/js/jquery.min.js','/js/bootstrap.js','/js/bootstrap.min.js','/js/custom.js']
#   js :affix, ['/js/bootstrap-affix.js']
#   js :alert, ['/js/bootstrap-alert.js']
#   js :button, ['/js/bootstrap-button.js']
#   js :carousel, ['/js/bootstrap-carousel.js']
#   js :collapse, ['/js/bootstrap-collapse.js']
#   js :dropdown, ['/js/bootstrap-dropdown.js']
#   js :modal, ['/js/bootstrap-modal.js']
#   js :popover, ['/js/bootstrap-popover.js']
#   js :scrollspy, ['/js/bootstrap-scrollspy.js']
#   js :tab, ['/js/bootstrap-tab.js']
#   js :tooltip, ['/js/bootstrap-tooltip.js']
#   js :transition, ['/js/bootstrap-transition.js']
#   js :typeahead, ['/js/bootstrap-typeahead.js']
#   js :highcharts, ['/js/highcharts.js']
# end

set :public_folder, 'assets'

# use Rack::Auth::Basic, "Restricted Area" do |username, password|
#   [username, password] == ['admin', 'admin']
# end



get '/' do
  "<h1>Yo!</h1>"
end
  }
    service = service_content.join
    File.open("#{app_root}/service.rb", 'w') {|f| f.write(service) }
    puts "\tprepared Service"

  end
end
# generating new application
command :new do |c|
  c.action do |global_options,options,args|
    app_name = args.first
    raise TypeError, error("Ajaila: you should enter the name for your app!") if app_name == nil
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
    Dir::mkdir("#{app_root}/sandbox/helpers")
    puts "\tprepared Tables folder in the Sandbox directory"

    # creating files
    gemfile_content = render("core/gemfile")
    File.open(app_root+"/Gemfile", 'w') {|f| f.write(gemfile_content)}
    puts "\tprepared Gemfile"
          
    service_content = render("core/service")
    File.open(app_root+"/service.rb", 'w') {|f| f.write(service_content)}
    puts "\tprepared Service"

    service_content = render("core/procfile")
    File.open(app_root+"/Procfile", 'w') {|f| f.write(service_content)}
    puts "\tprepared Service"

    db_content = render("core/db", :project => app_name.downcase)
    File.open(app_root+"/config/db.rb", 'w') {|f| f.write(db_content)}
    puts "\tprepared database config"

    File.open(app_root+"/sandbox/helpers/application.helper.rb", 'w') {|f| f.write("# Application Helper")}
    puts "\tprepared application helper"

  end
end
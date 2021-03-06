namespace :db do
  desc "Creates database"
  task :create, :name do |_, args|
    env = ENV['AJAILA_ENV'] || 'development'
    puts "Loading #{env.inspect}"
    Ajaila::Application.new(env).create_database!(args[:name])
  end

  desc "Drops database"
  task :drop, :name do |_, args|
    env = ENV['AJAILA_ENV'] || 'development'
    puts "Loading #{env.inspect}"
    Ajaila::Application.new(env).drop_database!(args[:name])
  end

  desc "Runs migrations"
  task :migrate, [:version] => :environment do |_, args|
    Ajaila.app.migrate_database(args.version)
  end
  
  namespace :test do
    desc "Creates test database"
    task :create, :name do |_, args|
      env = 'test'
      puts "Loading #{env.inspect}"
      Ajaila::Application.new(env).create_database!(args[:name])
    end

    desc "Drops test database"
    task :drop, :name do |_, args|
      env = 'test'
      puts "Loading #{env.inspect}"
      Ajaila::Application.new(env).drop_database!(args[:name])
    end    

    desc "Runs test migrations"
    task :migrate do
      env = 'test'
      puts "Loading #{env.inspect}"
      Ajaila::Application.new(env).init!
      ActiveRecord::Migrator.migrate("app/migrations/")
    end
  end
end

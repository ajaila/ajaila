namespace :db do
  desc "Creates database"
  task :create do
    env = ENV['AJAILA_ENV'] || 'development'
    puts "Loading #{env.inspect}"
    Ajaila::Application.new(env).create_database!
  end

  desc "Drops database"
  task :drop do
    env = ENV['AJAILA_ENV'] || 'development'
    puts "Loading #{env.inspect}"
    Ajaila::Application.new(env).drop_database!
  end

  desc "Runs migrations"
  task :migrate, [:version] => :environment do |_, args|
    Ajaila.app.migrate_database(args.version)
  end
end

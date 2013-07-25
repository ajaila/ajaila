namespace :db do
  desc "Creates database"
  task :create do |_, args|
    env = args[:env] || ENV['AJAILA_ENV'] || 'development'
    Ajaila::Application.new(env).create_database
  end

  desc "Drops database"
  task drop: :environment do
    Ajaila.app.drop_database
  end

  desc "Runs migrations"
  task :migrate, [:version] => :environment do |_, args|
    Ajaila.app.migrate_database(args.version)
  end
end

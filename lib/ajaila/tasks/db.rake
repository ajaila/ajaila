namespace :db do
  desc "Creates database"
  task create: :environment do |_, args|
    Ajaila.app.create_database
  end

  desc "Drops database"
  task drop: :environment do |_, args|
    Ajaila.app.drop_database
  end

  desc "Runs migrations"
  task :migrate, [:version] => :environment do |_, args|
    Ajaila.app.migrate_database(args.version)
  end
end

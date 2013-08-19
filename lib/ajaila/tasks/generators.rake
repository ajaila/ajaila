require 'ajaila/generators/migration_generator'

namespace :g do
  desc "Generates migration"
  task :migration, [:name] => :environment do |_, args|
    Ajaila::MigrationGenerator.new(args[:name]).generate
  end
end
namespace :db do
  desc "Creates database"
  task :create, :env do |_, args|
    env = args[:env] || ENV['AJAILA_ENV'] || 'development'
    Ajaila::Application.new(env).create_database
  end

  desc "Drops database"
  task :drop, :env do |_, args|
    env = args[:env] || ENV['AJAILA_ENV'] || 'development'
    Ajaila::Application.new(env).drop_database
  end
end

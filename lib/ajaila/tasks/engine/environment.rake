task :environment do
  Ajaila::Application.new(ENV['AJAILA_ENV'] || 'development').init!
end

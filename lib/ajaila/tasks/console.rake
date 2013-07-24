desc "Runs irb console and initializes the application"
task :console, :env do |_, args|
  require 'irb'

  unless env = ENV['AJAILA_ENV']
    env = args[:env] || 'development'
  end

  system "mkdir -p #{Dir.pwd}/db/#{env}"

  Ajaila::Application.new(env) do |app|
    app.init!
    app.hint("Use `Ajaila.app` variable to deal with application API")

    if app.env == 'development'
      require "awesome_print"
      AwesomePrint.irb!
    end
  end

  ARGV.clear
  IRB.start
end

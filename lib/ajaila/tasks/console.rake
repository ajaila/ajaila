desc "Runs irb console and initializes the application"
task :console, :env do |_, args|
  require 'irb'

  env = args[:env] || 'development'
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

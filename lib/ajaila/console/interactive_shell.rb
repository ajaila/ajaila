$:.unshift File.expand_path("../", __FILE__)
command :console do |c|
  c.action do |global_options,options,args|
    require "bombshell"
    require "ajaila/application"
    class App
      class Shell < Bombshell::Environment
        include Bombshell::Shell
        prompt_with "#{ ROOT.split('/').last } "
      end
    end
    Bombshell.launch(App::Shell)
  end
end
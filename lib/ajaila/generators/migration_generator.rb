require 'erb'

module Ajaila
  class MigrationGenerator

    def initialize(name)
      @name = name.underscore
      @timestamp = Time.now.to_i
      @path = "app/migrations/#{@timestamp}_#@name.rb"
    end

    def generate
      migration_file = File.open(@path, "w+")
      migration_file << ERB.new(template).result(Context.new(@name).template_binding)
      migration_file.close

      Ajaila.app.hint "Generated migration: #@path"
    end

    def templates_path
      File.expand_path(File.join(File.dirname(__FILE__), '../templates'))
    end

    def template
      @template ||= File.read(File.join(templates_path, "migration.rb.erb"))
    end

    class Context
      attr_accessor :name

      def initialize(name)
        @name = "#{name.camelize}AjailaMigration"
        validate!
      end

      def template_binding
        binding
      end

      def load_migrations
        Dir["./app/migrations/**/*.rb"].each(&method(:load))
      rescue
        raise "An error was occurred"
      end

      def validate!
        load_migrations
        Module.const_get(@name)
        raise "Migration with the same name already exists"
      rescue NameError
        true
      end
    end
  end
end
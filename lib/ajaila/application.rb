module Ajaila
  class Application
    CONFIG_PATH = "config/analytics.yml"

    attr_reader :env
    delegate :hint, :note, to: :logger

    # @param [String] env Environment from configuration file
    def initialize(env = nil)
      @env = env || ENV['AJAILA_ENV'] || 'development'
      load_path('config/initializers')
      Ajaila.app = self
      yield self if block_given?
    end

    # Entry point for the app
    # @return [Application]
    def init!
      @logger = @config = @database_config = nil

      load_application_config
      load_database_config
      note "Loading #{env} environment (#{Ajaila::VERSION})"
      load_classes
      note "Establishing database connection"
      establish_database_connection
      note "Running migrations"
      run_migrations
      note "Application has been initialized"
      self
    end
    alias_method :reload!, :init!

    # @return [Hash<String>]
    def config
      @config || load_application_config
    end

    def create_database!
      establish_postgres_connection
      ActiveRecord::Base.connection.create_database(database_config['database'])
      hint "The database #{database_config['database']} has been successfully created"
    end

    def create_database
      create_database!
    rescue
      hint "The database #{database_config['database']} already exist"
    end

    def drop_database!
      establish_postgres_connection
      ActiveRecord::Base.connection.drop_database(database_config['database'])
      hint "The database #{database_config['database']} has been successfully dropped"
    end

    def drop_database
      drop_database!
    rescue
      hint "The database #{database_config['database']} does not exist"
    end

    # @return [Hash<String>]
    def database_config
      @database_config || load_database_config
    end

    # @return [Logger]
    def logger
      @logger ||= Ajaila::Logger.new(log_level)
    end

    # @return [String] Database name
    def database
      adapter  = database_config['adapter']
      database = database_config['database']
      adapter == 'sqlite3' ? "db/#{env}/#{database}.db" : database
    end

    def self.init!
      yield Ajaila::Application.new.init!
    end

    private

    def establish_database_connection
      ActiveRecord::Base.establish_connection(database_config)

      if database_config['enable_logging']
        ActiveRecord::Base.logger = Logger.new(STDOUT)
      end
    end

    # Used to create/drop db
    def establish_postgres_connection
      ActiveRecord::Base.establish_connection(database_config.merge('database' => 'postgres',
                                                                    'schema_search_path' => 'public'))
    end

    # Autoloads all app-specific classes
    def load_classes
      config['autoload_paths'].each do |path|
        load_path(File.join(path, 'concerns'))
        load_path(path)
      end
    end

    # @return [Hash]
    def load_application_config
      @config = YAML.load_file(CONFIG_PATH)[env]
    end

    # @return [Hash]
    def load_database_config
      @database_config = YAML.load_file('config/database.yml')[env]
    end

    # @param [String] path Relative to project root
    def load_path(path)
      Dir["#{path}/**/*.rb"].each(&method(:load))
    end

    # @return [IO, nil]
    def log_level
      config['enable_logging'] ? STDOUT : nil
    end

    def run_migrations
      ActiveRecord::Base.subclasses.each do |model|
        model.auto_upgrade!
      end
    end
  end
end

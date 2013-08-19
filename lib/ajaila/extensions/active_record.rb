module Ajaila
  module ActiveRecordExtension
    extend ActiveSupport::Concern

    module ClassMethods

      # Makes your model use different databases
      # @param [String, Symbol] db_name
      # @param [String] env
      def use_database(db_name, env = nil)
        env ||= Ajaila.app.env
        env = env.to_s
        db_name = db_name.to_s

        self.abstract_class = true
        establish_connection(Ajaila.app.database_config[db_name][env])
      end

      # Drops and restores table from schema
      def reset!
        ActiveRecord::Migration.drop_table(table_name) rescue nil
        auto_upgrade!
      end

      # Same as ::pluck, but extracts only uniq values, rejecting NULLs
      # @param [Symbol] field Field to pluck
      # @todo Replace #uniq with #group
      # @todo(MM) specs
      #
      # @return [Array]
      def pluck_uniq(field)
        pluck(field).uniq.compact
      end

      def auto_upgrade!
        true
      end
    end
  end
end
ActiveRecord::Base.send :include, Ajaila::ActiveRecordExtension

module Ajaila
  module ActiveRecordExtension
    extend ActiveSupport::Concern

    module ClassMethods

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

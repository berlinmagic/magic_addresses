require 'rails/generators/migration'

module MagicAddresses
  module Generators
    class UpdateGenerator < ::Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path('../templates', __FILE__)
      desc "add magic_addresses migrations"

      def self.next_migration_number(path)
        unless @prev_migration_nr
          @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
        else
          @prev_migration_nr += 1
        end
        @prev_migration_nr.to_s
      end

      def copy_migrations
        migration_template( "update_address_migration.rb", "db/migrate/update_magic_addresses.rb" )
      end

    end
  end
end
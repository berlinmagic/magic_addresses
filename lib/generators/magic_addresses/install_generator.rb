require 'rails/generators/migration'

module MagicAddresses
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path('../templates', __FILE__)
      desc "add the migrations"

      def self.next_migration_number(path)
        unless @prev_migration_nr
          @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
        else
          @prev_migration_nr += 1
        end
        @prev_migration_nr.to_s
      end

      def copy_migrations
        migration_template( "magic_addresses_migration.rb", "db/migrate/add_magic_addresses.rb" )
      end
      
      # => def create_seeds_folder
      # =>   directory( "db/seeds" )
      # => end
      
      def copy_country_seeds
        copy_file( "country_seeds.rb", "db/seed_countries.rb" )
      end
      
    end
  end
end
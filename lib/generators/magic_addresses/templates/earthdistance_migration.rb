class AddEarthdistance < ActiveRecord::Migration
  def self.up
    
    # comented out to avoid PG::InsufficientPrivilege-ERROR
    # add with cap postgresql:add_extensions
    # => execute "CREATE EXTENSION IF NOT EXISTS cube"
    # => execute "CREATE EXTENSION IF NOT EXISTS earthdistance"
    
    if Rails.env.development? || Rails.env.test?
      enable_extension "cube"
      enable_extension "earthdistance"
    end
    
    ## ActiveRecord indexes .. doesnt include earthdistance, because its build directly in postgres!
    # => address_indexes = ActiveRecord::Base.connection.indexes(:mgca_addresses).map{ |x| x.name }
    # => index_exists?(:mgca_addresses, :earthdistance, name: "mgca_addresses_earthdistance_ix")
    
    ## Postgres-Indexes .. thanks to: http://www.alberton.info/postgresql_meta_info.html#p13
    address_indexes = execute( "SELECT c.relname AS index_name FROM pg_class AS a JOIN pg_index AS b ON (a.oid = b.indrelid) JOIN pg_class AS c ON (c.oid = b.indexrelid) WHERE a.relname = 'mgca_addresses';").map{ |that| that["index_name"] }
    
    unless address_indexes.include?("mgca_addresses_earthdistance_ix")
      add_earthdistance_index :mgca_addresses, lat: 'latitude', lng: 'longitude'
    end
    
  end

  def self.down
    # => execute "DROP EXTENSION IF EXISTS earthdistance"
    # => execute "DROP EXTENSION IF EXISTS cube"
    # comented out in staging and production to avoid PG::InsufficientPrivilege-ERROR .. add with cap postgresql:remove_extensions
    if Rails.env.development? || Rails.env.test?
      disable_extension "earthdistance"
      disable_extension "cube"
    end
    
    ## Postgres-Indexes
    address_indexes = execute( "SELECT c.relname AS index_name FROM pg_class AS a JOIN pg_index AS b ON (a.oid = b.indrelid) JOIN pg_class AS c ON (c.oid = b.indexrelid) WHERE a.relname = 'mgca_addresses';").map{ |that| that["index_name"] }
    
    if address_indexes.include?("mgca_addresses_earthdistance_ix")
      remove_earthdistance_index :mgca_addresses
    end
    
    
  end
end

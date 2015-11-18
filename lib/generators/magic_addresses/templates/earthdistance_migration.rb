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
    
    unless index_exists?(:mgca_addresses, [:latitude,:longitude], name: "mgca_addresses_earthdistance_ix")
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
    
    remove_index :mgca_addresses, [:latitude,:longitude], name: "mgca_addresses_earthdistance_ix"
    
  end
end

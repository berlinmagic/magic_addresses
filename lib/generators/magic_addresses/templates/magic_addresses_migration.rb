# encoding: utf-8
class AddMagicAddresses < ActiveRecord::Migration
  def up
    
    # if using with postgresql
    # => # add hstore extensions
    # => enable_extension "hstore"
    # => # add extensions for distance calculation
    # => enable_extension "cube"
    # => enable_extension "earthdistance"
    
    
    #
    ## Addresses
    create_table :mgca_addresses do |t|
      
      t.string        :name                     # => name (if needed)
      
      # if not empty fetch and translate that address
      if MagicAddresses.configuration.hstore
        t.hstore        :fetch_address            # => hstore method
      else
        t.text          :fetch_address            # => default serialize field
      end
      
      # => t.string        :street_number
      # => t.string        :street_additional
      # => t.integer       :zipcode
      # => 
      # => t.string        :visibility
      t.boolean       :default
      # => 
      t.float         :longitude
      t.float         :latitude
      # => 
      # => t.references    :subdistrict
      # => t.references    :district
      t.references    :city
      t.references    :state
      t.references    :country
      
      t.references    :owner,      polymorphic: true
      
      t.timestamps    null: false
    end
    
    # => add_index :mgca_addresses, :subdistrict_id
    # => add_index :mgca_addresses, :district_id
    add_index :mgca_addresses, :city_id
    add_index :mgca_addresses, :state_id
    add_index :mgca_addresses, :country_id
    add_index :mgca_addresses, [:owner_type, :owner_id]
    
    # when use postgres earthdistance
    if MagicAddresses.configuration.earthdistance
      add_earthdistance_index :mgca_addresses, lat: 'latitude', lng: 'longitude'
    end
    
    MagicAddresses::Address.create_translation_table! :street_name => :string
    
    
    #############################################################################################################
    ##### Country
    #####
    create_table :mgca_countries do |t|
      t.string      :name_default
      # t.string    :name
      t.string      :iso_code,       limit: 2
      t.string      :dial_code
      t.string      :fsm_state,      default: "new"
      t.timestamps
    end
    
    MagicAddresses::Country.create_translation_table! :name => :string
    
    # seed some countries in some languages
    load "#{ ::Rails.root }/db/seed_countries.rb"
    
    
    #############################################################################################################
    ##### State
    #####
    create_table :mgca_states do |t|
      t.string      :name_default
      t.string      :short_name
      # t.string      :name
      t.string      :fsm_state,      default: "new"
      t.references  :country
      t.timestamps
    end
    
    add_index :mgca_states, :country_id
    
    MagicAddresses::State.create_translation_table! :name => :string
    
    
    #############################################################################################################
    ##### City
    #####
    create_table :mgca_cities do |t|
      t.string      :name_default
      t.string      :short_name
      # t.string      :name
      t.string      :fsm_state,      default: "new"
      t.references  :state
      t.references  :country
      t.timestamps
    end
    
    add_index :mgca_cities, :state_id
    add_index :mgca_cities, :country_id
    
    MagicAddresses::City.create_translation_table! :name => :string
    
  end
  def down
    
    ## Addresses
    # => remove_index  :mgca_addresses, :subdistrict_id
    # => remove_index  :mgca_addresses, :district_id
    remove_index  :mgca_addresses, :city_id
    remove_index  :mgca_addresses, :state_id
    remove_index  :mgca_addresses, :country_id
    remove_index  :mgca_addresses, [:owner_type, :owner_id]
    drop_table    :mgca_addresses
    MagicAddresses::Address.drop_translation_table!
    
    
    ## Countries
    drop_table    :mgca_countries
    MagicAddresses::Country.drop_translation_table!
    
    
    ## States
    remove_index  :mgca_states, :country_id
    drop_table    :mgca_states
    MagicAddresses::State.drop_translation_table!
    
    
    ## Cities
    remove_index  :mgca_cities, :state_id
    remove_index  :mgca_cities, :country_id
    drop_table    :mgca_cities
    MagicAddresses::City.drop_translation_table!
    
    
    # => # disable extensions for distance calculation
    # => disable_extension "earthdistance"
    # => disable_extension "cube"
    # => # disable hstore extension
    # => disable_extension "hstore"
    
  end
end

# encoding: utf-8
class AddMagicAddresses < ActiveRecord::Migration
  def up
    
    # if using with postgresql
    # => # add extensions for distance calculation
    # => enable_extension "cube"
    # => enable_extension "earthdistance"
    
    
    #
    ## Addresses
    create_table :mgca_addresses do |t|
      
      t.string        :name                     # => name (if needed)
      
      t.text          :fetch_address            # => default serialize field
      
      # t.string        :street
      t.string        :street_default
      t.string        :street_number
      t.string        :street_additional
      t.integer       :zipcode
      
      t.string        :status,                  default: "new"
      
      t.float         :longitude
      t.float         :latitude
      
      t.references    :subdistrict
      t.references    :district
      t.references    :city
      t.references    :state
      t.references    :country
      
      t.timestamps    null: false
    end
    
    add_index :mgca_addresses, :subdistrict_id
    add_index :mgca_addresses, :district_id
    add_index :mgca_addresses, :city_id
    add_index :mgca_addresses, :state_id
    add_index :mgca_addresses, :country_id
    
    # when use postgres earthdistance
    if MagicAddresses.configuration.earthdistance
      add_earthdistance_index :mgca_addresses, lat: 'latitude', lng: 'longitude'
    end
    
    MagicAddresses::Address.create_translation_table! :street_name => :string
    
    
    #############################################################################################################
    ##### Addressibles
    #####
    create_table :mgca_addressibles do |t|
      t.boolean       :default      # is default address ?
      t.string        :name         # address name (home | office | ..)
      t.references    :owner,       polymorphic: true
      t.references    :address
      t.timestamps    null: false
    end
    
    add_index :mgca_addressibles, [:owner_type, :owner_id]
    add_index :mgca_addressibles, :address_id
    
    
    #############################################################################################################
    ##### Country
    #####
    create_table :mgca_countries do |t|
      t.string      :default_name
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
      t.string      :default_name
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
      t.string      :default_name
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
    
    
    #############################################################################################################
    ##### District
    #####
    create_table :mgca_districts do |t|
      t.string      :default_name
      t.string      :short_name
      # t.string      :name
      t.string      :fsm_state,      default: "new"
      t.references  :city
      t.timestamps
    end
    
    add_index :mgca_districts, :city_id
    
    MagicAddresses::District.create_translation_table! :name => :string
    
    
    #############################################################################################################
    ##### Subdistrict
    #####
    create_table :mgca_subdistricts do |t|
      t.string      :default_name
      t.string      :short_name
      # t.string    :name
      t.string      :fsm_state,      default: "new"
      t.references  :district
      t.references  :city
      t.timestamps
    end
    
    add_index :mgca_subdistricts, :district_id
    add_index :mgca_subdistricts, :city_id
    
    MagicAddresses::Subdistrict.create_translation_table! :name => :string
    
    
  end
  def down
    
    # when use postgres earthdistance
    if MagicAddresses.configuration.earthdistance
      remove_index :mgca_addresses, [:latitude,:longitude], name: "mgca_addresses_earthdistance_ix"
    end
    
    ## Addresses
    remove_index  :mgca_addresses, :subdistrict_id
    remove_index  :mgca_addresses, :district_id
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
    
    
    ## Districts
    remove_index  :mgca_districts, :city_id
    drop_table    :mgca_districts
    MagicAddresses::District.drop_translation_table!
    
    
    ## Subdistricts
    remove_index  :mgca_subdistricts, :district_id
    remove_index  :mgca_subdistricts, :city_id
    drop_table    :mgca_subdistricts
    MagicAddresses::Subdistrict.drop_translation_table!
    
    
    # => # disable extensions for distance calculation
    # => disable_extension "earthdistance"
    # => disable_extension "cube"
    
  end
end

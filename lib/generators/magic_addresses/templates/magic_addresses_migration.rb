class AddMagicAddresses < ActiveRecord::Migration
  def up
    
    create_table :location_addresses do |t|
      t.string        :name                     # => name (if needed)
      t.string        :fetch_address            # => if not nil fetch and translate that address
      
      t.string        :street_number
      t.string        :street_additional
      t.integer       :zipcode
      
      t.string        :visibility
      t.boolean       :default
      
      t.float         :longitude
      t.float         :latitude
      
      t.references    :subdistrict
      t.references    :district
      t.references    :city
      t.references    :state
      t.references    :country
      
      t.references    :owner,      polymorphic: true
      t.timestamps
    end
    
    add_index :location_addresses, :subdistrict_id
    add_index :location_addresses, :district_id
    add_index :location_addresses, :city_id
    add_index :location_addresses, :state_id
    add_index :location_addresses, :country_id
    
    add_index :location_addresses, [:owner_type, :owner_id]
    
    Location::Address.create_translation_table! :street => :string
    
    #
    # Country
    #
    create_table :location_countries do |t|
      t.string      :name_default
      # t.string    :name
      t.string      :iso_code,       limit: 2
      t.string      :dial_code
      t.string      :fsm_state,      default: "new"
      t.timestamps
    end
    
    Location::Country.create_translation_table! :name => :string
    
    load "#{Rails.root}/db/seed/countries.rb"
    
    #
    # State
    #
    create_table :location_states do |t|
      t.string      :name_default
      t.string      :short_name
      # t.string      :name
      t.string      :fsm_state,      default: "new"
      t.references  :country
      t.timestamps
    end
    
    add_index :location_states, :country_id
    
    Location::State.create_translation_table! :name => :string
    
    #
    # City
    #
    create_table :location_cities do |t|
      t.string      :name_default
      t.string      :short_name
      # t.string      :name
      t.string      :fsm_state,      default: "new"
      t.references  :state
      t.references  :country
      t.timestamps
    end
    
    add_index :location_cities, :state_id
    add_index :location_cities, :country_id
    
    Location::City.create_translation_table! :name => :string
    
    #
    # District
    #
    create_table :location_districts do |t|
      t.string      :name_default
      t.string      :short_name
      # t.string      :name
      t.string      :fsm_state,      default: "new"
      t.references  :city
      t.timestamps
    end
    
    add_index :location_districts, :city_id
    
    Location::District.create_translation_table! :name => :string
    
    #
    # Subdistrict
    #
    create_table :location_subdistricts do |t|
      t.string      :name_default
      t.string      :short_name
      # t.string    :name
      t.string      :fsm_state,      default: "new"
      t.references  :district
      t.references  :city
      t.timestamps
    end
    
    add_index :location_subdistricts, :district_id
    add_index :location_subdistricts, :city_id
    
    Location::Subdistrict.create_translation_table! :name => :string
    
  end
  def down
    
    remove_index :location_addresses, :subdistrict_id
    remove_index :location_addresses, :district_id
    remove_index :location_addresses, :city_id
    remove_index :location_addresses, :state_id
    remove_index :location_addresses, :country_id
    remove_index :location_addresses, [:owner_type, :owner_id]
    drop_table :location_addresses
    Location::Address.drop_translation_table!
    
    drop_table :location_countries
    Location::Country.drop_translation_table!
    
    remove_index :location_states, :country_id
    drop_table :location_states
    Location::State.drop_translation_table!
    
    remove_index :location_cities, :state_id
    remove_index :location_cities, :country_id
    drop_table :location_cities
    Location::City.drop_translation_table!
    
    remove_index :location_districts, :city_id
    drop_table :location_districts
    Location::District.drop_translation_table!
    
    remove_index  :location_subdistricts, :district_id
    remove_index  :location_subdistricts, :city_id
    drop_table    :location_subdistricts
    Location::Subdistrict.drop_translation_table!
    
  end
end

# encoding: utf-8
class AddMagicAddresses < ActiveRecord::Migration
  def up
    
    #
    ## Addresses
    create_table :mgca_addresses do |t|
      
      # => t.string        :name                     # => name (if needed)
      # => t.string        :fetch_address            # => if not nil fetch and translate that address
      # => 
      # => t.string        :street_number
      # => t.string        :street_additional
      # => t.integer       :zipcode
      # => 
      # => t.string        :visibility
      # => t.boolean       :default
      # => 
      t.float         :longitude
      t.float         :latitude
      # => 
      # => t.references    :subdistrict
      # => t.references    :district
      # => t.references    :city
      # => t.references    :state
      # => t.references    :country
      
      t.references    :owner,      polymorphic: true
      
      t.timestamps    null: false
    end
    
    # => add_index :mgca_addresses, :subdistrict_id
    # => add_index :mgca_addresses, :district_id
    # => add_index :mgca_addresses, :city_id
    # => add_index :mgca_addresses, :state_id
    # => add_index :mgca_addresses, :country_id
    add_index :mgca_addresses, [:owner_type, :owner_id]
    
    
    ::MagicAddresses::Address.create_translation_table! :street => :string
    # => create_table :mgca_addresses_translations do |t|
    # =>   t.references    :mgca_address,    null: false
    # =>   t.string        :locale,          null: false
    # =>   t.string        :street
    # =>   t.timestamps    null: false
    # => end
    # => add_index :mgca_addresses_translations, :mgca_address_id
    # => add_index :mgca_addresses_translations, :locale
    
    
  end
  def down
    
    #
    ## Addresses
    # => remove_index  :mgca_addresses, :subdistrict_id
    # => remove_index  :mgca_addresses, :district_id
    # => remove_index  :mgca_addresses, :city_id
    # => remove_index  :mgca_addresses, :state_id
    # => remove_index  :mgca_addresses, :country_id
    remove_index  :mgca_addresses, [:owner_type, :owner_id]
    drop_table    :mgca_addresses
    MagicAddresses::Address.drop_translation_table!
    
    
    
  end
end

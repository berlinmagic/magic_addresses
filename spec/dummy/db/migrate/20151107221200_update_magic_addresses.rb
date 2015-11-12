# encoding: utf-8
class UpdateMagicAddresses < ActiveRecord::Migration
  def change
    
    remove_index  :mgca_addresses,    [:owner_type, :owner_id]
    
    remove_column :mgca_addresses,    :owner,      polymorphic: true
    remove_column :mgca_addresses,    :default,    :boolean
    
    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
    
    create_table :mgca_addressibles do |t|
      t.boolean       :default
      t.references    :owner,      polymorphic: true
      t.references    :address
      t.timestamps    null: false
    end
    
    add_index :mgca_addressibles, [:owner_type, :owner_id]
    add_index :mgca_addressibles, :address_id
    
  end
end

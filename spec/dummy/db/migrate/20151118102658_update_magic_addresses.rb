# encoding: utf-8
class UpdateMagicAddresses < ActiveRecord::Migration
  def change
    
    create_table :mgca_addressibles do |t|
      t.boolean       :default      # is default address ?
      t.string        :name         # address name (home | office | ..)
      t.references    :owner,       polymorphic: true
      t.references    :address
      t.timestamps    null: false
    end
    
    add_index :mgca_addressibles, [:owner_type, :owner_id]
    add_index :mgca_addressibles, :address_id
    
    add_column :mgca_addresses, :status, :string, default: "new"
    
    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
    
    MagicAddresses::Address.all.each do |that|
      if that.owner_type.present? && that.owner_id.present? && "#{that.owner_type}".constantize.find(that.owner_id.to_i)
        MagicAddresses::Addressible.create!( address_id: that.id, owner_type: that.owner_type, owner_id: that.owner_id, default: that.default )
      end
      sames = MagicAddresses::Address.where(latitude: that.latitude, longitude: that.longitude, zipcode: that.postal_code, street_number: that.street_number )
      sames.each do |this|
        unless this == that
          MagicAddresses::Addressible.create!( address_id: that.id, owner_type: this.owner_type, owner_id: this.owner_id, default: this.default )
          this.destroy
        end
      end if sames.count > 1
    end
    
    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
    
    remove_index  :mgca_addresses,    [:owner_type, :owner_id]
    
    remove_column :mgca_addresses,    :owner_type,  :string
    remove_column :mgca_addresses,    :owner_id,    :integer
    remove_column :mgca_addresses,    :default,     :boolean
    
    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
    
    
  end
end

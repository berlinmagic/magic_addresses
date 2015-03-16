# encoding: utf-8
class MagicAddresses::AddressSerializer < ActiveModel::Serializer

  ## defaults
  attributes :id, :created_at, :updated_at

  ## Address - Attributes
  attributes :name, :default, :street, :street_additional, :number, :postalcode, :city, :district, :subdistrict, :state, :country

  ## Location
  attributes :latitude, :longitude
  
  ## Owner
  attributes :owner_type, :owner_id, :owner
  
  
  def owner
    { id: object.owner_id, type: object.owner_type }
  end

end

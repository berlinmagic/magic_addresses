# encoding: utf-8
class MagicAddresses::AddressSerializer < ActiveModel::Serializer

  ## defaults
  attributes :id, :created_at, :updated_at

  ## Address - Attributes
  attributes :name, :street, :street_additional, :number, :postalcode, :city, :district, :subdistrict, :state, :country

  ## Location
  attributes :latitude, :longitude
  
  ## Owner
  attributes :owners
  
  
  def owners
    object.owners
  end

end

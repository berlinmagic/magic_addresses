# encoding: utf-8
class MagicAddresses::City < ActiveRecord::Base

  # =====> A S S O Z I A T I O N S <========================================================= #
  has_many :addresses,    class_name: "MagicAddresses::Address",      foreign_key: :city_id
  
  belongs_to :country,    class_name: "MagicAddresses::Country",      foreign_key: :country_id
  belongs_to :state,      class_name: "MagicAddresses::State",        foreign_key: :state_id
  
  has_many :districts,    class_name: "MagicAddresses::District",     foreign_key: :city_id
  has_many :subdistricts, class_name: "MagicAddresses::Subdistrict",  foreign_key: :city_id
  
  
  # =====> A T T R I B U T E S <============================================================= #
  mgca_translate :name
  
  
  
end

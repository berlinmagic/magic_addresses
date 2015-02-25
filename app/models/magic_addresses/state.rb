# encoding: utf-8
class MagicAddresses::State < ActiveRecord::Base

  # =====> A S S O Z I A T I O N S <========================================================= #
  has_many :addresses,    class_name: "MagicAddresses::Address",  foreign_key: :state_id
  
  belongs_to :country,    class_name: "MagicAddresses::Country",  foreign_key: :country_id
  
  has_many :cities,       class_name: "MagicAddresses::City",     foreign_key: :state_id
  has_many :districts,    through: :cities,                       source: :districts
  has_many :subdistricts, through: :districts,                    source: :subdistricts
  
  
  # =====> A T T R I B U T E S <============================================================= #
  mgca_translate :name
  
  
  
end

# encoding: utf-8
class MagicAddresses::Country < ActiveRecord::Base

  # =====> A S S O Z I A T I O N S <========================================================= #
  has_many :addresses,    class_name: "MagicAddresses::Address",  foreign_key: :country_id
  
  has_many :states,       class_name: "MagicAddresses::State",    foreign_key: :country_id
  has_many :cities,       through: :states,                       source: :cities
  has_many :districts,    through: :cities,                       source: :districts
  has_many :subdistricts, through: :districts,                    source: :subdistricts
  
  
  # =====> A T T R I B U T E S <============================================================= #
  mgca_translate :name
  
  
  
end

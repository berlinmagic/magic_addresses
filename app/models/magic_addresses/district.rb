# encoding: utf-8
class MagicAddresses::District < ActiveRecord::Base

  # =====> A S S O Z I A T I O N S <========================================================= #
  has_many :addresses,    class_name: "MagicAddresses::Address",  foreign_key: :district_id
  
  belongs_to :city,       class_name: "MagicAddresses::City",     foreign_key: :city_id
  
  
  # =====> A T T R I B U T E S <============================================================= #
  mgca_translate :name
  
  
  
end

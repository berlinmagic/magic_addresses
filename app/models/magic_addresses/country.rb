# encoding: utf-8
class MagicAddresses::Country < ActiveRecord::Base

  # =====> A S S O Z I A T I O N S <========================================================= #
  has_many :addresses,    class_name: "MagicAddresses::Address",  foreign_key: :country_id
  
  
  # =====> A T T R I B U T E S <============================================================= #
  mgca_translate :name
  
  
  
end

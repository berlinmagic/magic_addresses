# encoding: utf-8
class MagicAddresses::Address < ActiveRecord::Base
  
  # =====> R E W R I T E S <================================================================= #
  # self.table_name = "mgca_addresses"
  
  
  # =====> C O N S T A N T S <=============================================================== #
  
  # =====> A S S O Z I A T I O N S <========================================================= #
  belongs_to :owner,    polymorphic: true
  
  # globalize translated attributes: street
  #   Usage:
  #     address.street                                      # => street in I18n.locale
  #     address.read_attribute(:street, locale: :de)        # => street in german (:de), no fallback
  #
  # translates :street, fallbacks_for_empty_translations: true #, table_name: "mgca_addresses"
  mgca_translate :street
  
  
  # =====> A T T R I B U T E S <============================================================= #
  # accepts_nested_attributes_for :translations
  
  
  # =====> V A L I D A T I O N <============================================================= #
  validates :owner, :presence => true
  
  
  # =====> C A L L B A C K S <=============================================================== #
  
  # =====> S C O P E S <===================================================================== #
  
  # =====> C L A S S - M E T H O D S <======================================================= #
  
  # =====> I N S T A N C E - M E T H O D S <================================================= #
  
  # =====>  P  R  I  V  A  T  E  !  <======================================================== # # # # # # # #
# private
  
  
end

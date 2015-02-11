# encoding: utf-8
class Location::District < ActiveRecord::Base
  
  # =====> R E W R I T E S <================================================================= #
  include GlobalizedName
  
  # =====> C O N S T A N T S <=============================================================== #
  
  # =====> A S S O Z I A T I O N S <========================================================= #
  belongs_to :city,       class_name: "Location::City",         foreign_key: :city_id
  
  has_many :addresses,    class_name: "Location::Address",      foreign_key: :district_id
  has_many :subdistricts, class_name: "Location::Subdistrict",  foreign_key: :subdistrict_id
  
  
  # =====> A T T R I B U T E S <============================================================= #
  
  
  # =====> V A L I D A T I O N <============================================================= #
  
  # =====> C A L L B A C K S <=============================================================== #
  
  # =====> S C O P E S <===================================================================== #
  # => default_scope { includes(:translations).with_translations(I18n.locale).order( 'location_district_translations.name ASC' ) }
  
  
  # =====> C L A S S - M E T H O D S <======================================================= #
  
  
  # =====> I N S T A N C E - M E T H O D S <================================================= #
  
  
  # =====>  P  R  I  V  A  T  E  !  <======================================================== # # # # # # # #
# private
  
  
end

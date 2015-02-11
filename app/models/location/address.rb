# encoding: utf-8
class Location::Address < ActiveRecord::Base
  
  # =====> R E W R I T E S <================================================================= #
  include AddressBuilder
  
  
  # =====> C O N S T A N T S <=============================================================== #
  MODEL_PARAMS = [      :street_name, :street_number, :street_additional, :zipcode, :city_name, :district_name, :subdistrict_name,
                        :state_name, :country_name, :country_code, :address, :latitude, :longitude, :visibility,  :id, :check, :_destroy        ]
  
  
  # =====> A S S O Z I A T I O N S <========================================================= #
  translates :street, fallbacks_for_empty_translations: true
  accepts_nested_attributes_for :translations
  
  belongs_to :owner,    polymorphic: true
  belongs_to :context,  polymorphic: true
  
  belongs_to :subdistrict,  class_name: "Location::Subdistrict",  foreign_key: :subdistrict_id
  belongs_to :district,     class_name: "Location::District",     foreign_key: :district_id
  belongs_to :city,         class_name: "Location::City",         foreign_key: :city_id
  belongs_to :state,        class_name: "Location::State",        foreign_key: :state_id
  belongs_to :country,      class_name: "Location::Country",      foreign_key: :country_id
  
  
  belongs_to :patient, -> { where(location_addresses: {owner_type: 'Patient'}) }, foreign_key: 'owner_id'
  
  
  # =====> A T T R I B U T E S <============================================================= #
  attr_accessor :address, :street_name, :subdistrict_name, :district_name, :city_name, :state_name, :state_short_name, :country_name, :country_code
  
  acts_as_geolocated lat: 'latitude', lng: 'longitude'
  
  
  # =====> V A L I D A T I O N <============================================================= #
  validates_presence_of :city, :country, unless: :is_patient_address
  validates_presence_of :city_name, :street_name, :street_number, :zipcode, if: :is_patient_address
  
  
  # =====> C A L L B A C K S <=============================================================== #
  
  # =====> S C O P E S <===================================================================== #
  
  # =====> C L A S S - M E T H O D S <======================================================= #
  def self.search(search)
    if search
      with_translations.where('street LIKE ?', "%#{search}%")
    else
      with_translations
    end
  end
  
  
  # =====> I N S T A N C E - M E T H O D S <================================================= #
  def with_translations(*locales)
    locales = translated_locales if locales.empty?
    includes(:translations).with_locales(locales).with_required_attributes
  end
  
  def presentation( type = "full" )
    adr = []
    adr << street if street.present?
    adr << street_number if street_number.present? && street.present? && type != "secure"
    adr = ["#{adr.join(" ")},"] if adr.count > 0
    adr << zipcode if zipcode.present?
    adr << city.name if city.present?
    if adr.count == 0
      I18n.t("addresses.no_address_given")
    else
      adr.join(" ")
    end
  end
  
  def street!
    self.street ? self.street : self.street_default
  end
  
  def country!
    self.country ? self.country.name : nil
  end
  
  def state!
    self.state ? self.state.name : nil
  end
  
  def city!
    self.city ? self.city.name : nil
  end
  
  def district!
    self.district ? self.district.name : nil
  end
  
  def subdistrict!
    self.subdistrict ? self.subdistrict.name : nil
  end
  
  
  # =====>  P  R  I  V  A  T  E  !  <======================================================== # # # # # # # #
private
  def is_patient_address
    Rails.logger.info "------"
    Rails.logger.info "#{self.owner && self.owner.class.name.to_s == "Patient"}  ..  #{self.owner.class.name if self.owner}"
    Rails.logger.info "#{self.owner_type && self.owner_type == "Patient"}  ..  #{self.owner_type if self.owner_type}"
    Rails.logger.info "------"
    # self.owner && self.owner.class.name.to_s == "Patient"
    self.owner_type && self.owner_type == "Patient"
  end
  
end

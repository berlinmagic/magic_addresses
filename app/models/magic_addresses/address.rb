# encoding: utf-8
class MagicAddresses::Address < ActiveRecord::Base
  
  # =====> R E W R I T E S <================================================================= #
  # self.table_name = "mgca_addresses"
  
  
  # =====> C O N S T A N T S <=============================================================== #
  
  # =====> A S S O Z I A T I O N S <========================================================= #
  belongs_to :owner,              polymorphic: true
  
  belongs_to :magic_country,      class_name: "MagicAddresses::Country",    foreign_key: :country_id
  belongs_to :magic_state,        class_name: "MagicAddresses::State",      foreign_key: :state_id
  belongs_to :magic_city,         class_name: "MagicAddresses::City",       foreign_key: :city_id
  belongs_to :magic_district,     class_name: "MagicAddresses::District",   foreign_key: :district_id
  
  # globalize translated attributes: street
  #   Usage:
  #     address.street_name                                      # => street in I18n.locale
  #     address.read_attribute(:street_name, locale: :de)        # => street in german (:de), no fallback
  #
  # translates :street_name, fallbacks_for_empty_translations: true #, table_name: "mgca_addresses"
  mgca_translate :street_name
  
  acts_as_geolocated lat: 'latitude', lng: 'longitude' if MagicAddresses.configuration.earthdistance
  
  
  # =====> A T T R I B U T E S <============================================================= #
  if MagicAddresses.configuration.hstore
    # setup hstore
    store_accessor  :fetch_address # , :fetch_street, :fetch_number, :fetch_city, :fetch_zipcode, :fetch_country
  else
    serialize       :fetch_address, Hash
  end
  
  %w[fetch_street fetch_number fetch_city fetch_zipcode fetch_country].each do |key|
    # attr_accessor key
    define_method(key) do
      fetch_address && fetch_address[key]
    end
    define_method("#{key}=") do |value|
      self.fetch_address = (fetch_address || {}).merge(key => value)
    end
  end
  
  # attr_accessor :street
  def street
    fetch_address && fetch_address["fetch_street"] || street_name
  end
  def street=(value)
    self.street_name = value
    self.fetch_address = (fetch_address || {}).merge("fetch_street" => value)
  end
  
  
  
  %w[country state city district].each do |key|
    # attr_accessor key
    define_method(key) do
      fetch_address && fetch_address["fetch_#{key}"] || self.send("magic_#{key}") && self.send("magic_#{key}").name
    end
    define_method("#{key}=") do |value|
      # self["fetch_#{key}"] = value
      self.fetch_address = (fetch_address || {}).merge("fetch_#{key}" => value)
    end
  end
  
  
  
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

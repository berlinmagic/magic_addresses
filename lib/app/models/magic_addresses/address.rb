# encoding: utf-8
class MagicAddresses::Address < ActiveRecord::Base
  
  # =====> R E W R I T E S <================================================================= #
  # self.table_name = "mgca_addresses"
  
  
  # =====> C O N S T A N T S <=============================================================== #
  PARAMS = [ :id, :street, :street_additional, :number, :postalcode, :city, :country, :owner, :_destroy ]
  
  
  # =====> A S S O Z I A T I O N S <========================================================= #
  belongs_to :owner,              polymorphic: true
  
  belongs_to :magic_country,      class_name: "MagicAddresses::Country",      foreign_key: :country_id
  belongs_to :magic_state,        class_name: "MagicAddresses::State",        foreign_key: :state_id
  belongs_to :magic_city,         class_name: "MagicAddresses::City",         foreign_key: :city_id
  belongs_to :magic_district,     class_name: "MagicAddresses::District",     foreign_key: :district_id
  belongs_to :magic_subdistrict,  class_name: "MagicAddresses::Subdistrict",  foreign_key: :subdistrict_id
  
  # globalize translated attributes: street
  #   Usage:
  #     address.street_name                                      # => street in I18n.locale
  #     address.read_attribute(:street_name, locale: :de)        # => street in german (:de), no fallback
  #
  # translates :street_name, fallbacks_for_empty_translations: true #, table_name: "mgca_addresses"
  mgca_translate :street_name
  
  acts_as_geolocated lat: 'latitude', lng: 'longitude' if MagicAddresses.configuration.earthdistance
  
  
  # =====> A T T R I B U T E S <============================================================= #
  serialize       :fetch_address, Hash
  
  %w[fetch_street fetch_number fetch_city fetch_zipcode fetch_country].each do |key|
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
  # attr_accessor :number (:street_number)
  def number
    fetch_address && fetch_address["fetch_number"] || street_number
  end
  def number=(value)
    self.fetch_address = (fetch_address || {}).merge("fetch_number" => value)
  end
  # attr_accessor :postalcode (:zipcode)
  def postalcode
    fetch_address && fetch_address["fetch_zipcode"] || zipcode
  end
  def postalcode=(value)
    self.fetch_address = (fetch_address || {}).merge("fetch_zipcode" => value)
  end
  
  %w[country state city district subdistrict].each do |key|
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
  # => validates :owner, :presence => true
  
  
  # =====> C A L L B A C K S <=============================================================== #
  after_save :build_address_associations_if_needed
  
  # =====> S C O P E S <===================================================================== #
  
  # =====> C L A S S - M E T H O D S <======================================================= #
  
  # =====> I N S T A N C E - M E T H O D S <================================================= #
  
  def presentation( type = "inline" )
    adr = []
    adr << "#{street} #{number}".strip if street.present?
    adr << "#{postalcode} #{city}" if zipcode.present? || city.present?
    adr << "(#{country})" if country.present?
    if adr.count == 0
      I18n.t("addresses.no_address_given")
    else
      if type == "full"
        adr.join("<br />")
      else
        adr.join(", ")
      end
    end
  end
  
  # =====>  P  R  I  V  A  T  E  !  <======================================================== # # # # # # # #
private
  
  def build_address_associations_if_needed
    if self.new_record? || self.fetch_street.present? || self.fetch_city.present? || self.fetch_zipcode.present? || self.fetch_number.present?
      build_address_associations
    else
      true
    end
  end
  
  def build_address_associations
    dev_log "triggered   A D D R E S S - B U I L D E R ! - - #{self.street} #{self.number} #{self.city} #{self.zipcode}"
    
    addr = []
    if self.fetch_city.present? || self.fetch_zipcode.present?
      # MagicAddresses::GeoCoder
      addr << "#{self.fetch_street} #{self.fetch_number}".strip if self.fetch_street
      addr << "#{self.fetch_zipcode} #{self.fetch_city}".strip if self.fetch_city || self.fetch_zipcode
      addr << "#{self.fetch_country || MagicAddresses.configuration.default_country}".strip
    end
    
    self.fetch_address = {}
    
    geo_data = {}
    if addr.any?
      # => gd = Geocoder.search( self.fetch_address, params: { language: "en" })
      gd = MagicAddresses::GeoCoder.search( addr.join(", "), default_locale )
      geo_data[default_locale] =  gd.first if gd.first
      MagicAddresses.configuration.active_locales.each do |lcl|
        unless lcl.to_s == default_locale
          sleep 0.3
          gd = MagicAddresses::GeoCoder.search( addr.join(", "), lcl.to_s )
          geo_data[lcl.to_s] =  gd.first if gd.first
        end
      end
    end
    if geo_data.any?
      dev_log "   geo_data  is present !!!"
      # set default values
      self.street_default = geo_data[default_locale].street if geo_data[default_locale] && geo_data[default_locale].street
      self.zipcode = geo_data[default_locale].postal_code if geo_data[default_locale] && geo_data[default_locale].postal_code
      self.street_number = geo_data[default_locale].street_number if geo_data[default_locale] && geo_data[default_locale].street_number
      # set geo-position
      self.latitude = geo_data[default_locale].latitude if geo_data[default_locale] && geo_data[default_locale].latitude
      self.longitude = geo_data[default_locale].longitude if geo_data[default_locale] && geo_data[default_locale].longitude
    end
    complete_translated_attributes( geo_data )
    
    self.fetch_address = {}
    self.save
  end
  
  
  def complete_translated_attributes( geo_data = {} )
    if geo_data.any?
      # build street parameters
      street_params = []
      geo_data.each do |key, stuff|
        street_params << { locale: key.to_s, street_name: stuff.street } if stuff.street # && ((stuff.street != geo_data[default_locale].street) || (default_locale == key.to_s))
      end
      # set street parameters if present
      if street_params.any?
        dev_log "empty street translations"
        # reset translations (avoid empty translation in default language)
        # => self.translations = []
        self.translations.delete_all
        # set street parameters
        self.translations_attributes = street_params
        dev_log "set new street translations"
      end
      
      self.street_default = geo_data[default_locale].street if geo_data[default_locale] && geo_data[default_locale].street
      
      # build country
      if geo_data[default_locale].country_code.present?
        connet_address_association( :country, geo_data )
      end
      # build state
      if geo_data[default_locale].state_code.present? && self.magic_country
        connet_address_association( :state, geo_data )
      end
      # build city
      if geo_data[default_locale].city.present? && self.magic_country
        connet_address_association( :city, geo_data )
      end
      # build district
      if geo_data[default_locale].district.present? && self.magic_city
        connet_address_association( :district, geo_data )
      end
      # build subdistrict
      if geo_data[default_locale].subdistrict.present? && self.magic_city && self.magic_district
        connet_address_association( :subdistrict, geo_data )
      end
      
    end
  end
  
  ## Build Associations
  
  def connet_address_association( that, geo_data )
    dev_log ">>> #{that.to_s.upcase}: #{ geo_data[default_locale].send(that) }"
    that_params = { default_name: geo_data[default_locale].send(that).to_s }
    that_params[ that == :country ? :iso_code : :short_name ] = geo_data[default_locale].send( "#{that}_code".to_sym ).to_s
    that_params.merge!({ country_id: self.magic_country.id })     if [:city, :state].include?(that) && self.magic_country
    that_params.merge!({ state_id: self.magic_state.id })         if that == :city && self.magic_state
    that_params.merge!({ city_id: self.magic_city.id })           if [:district, :subdistrict].include?(that) && self.magic_city
    that_params.merge!({ district_id: self.magic_district.id })   if that == :subdistrict && self.magic_district
    
    this = "magic_#{that}".to_sym
    
    self.attributes = { this => "MagicAddresses::#{that.to_s.classify}".constantize.unscoped.where( that_params ).first_or_create }# unless self.send(that)
    
    dev_log "#{that} .. #{this}"
    
    self.send(this).translations = []
    self.send(this).translations_attributes = lng_params( that, geo_data )
    self.send(this).save
  end
  
  ## Build Association Params
  
  def lng_params( that, geo_data )
    lng_params = []
    geo_data.each do |key, stuff|
      dev_log "#{that.to_s.titleize}-Params (#{key}) ... #{stuff.send(that)}"
      lng_params << { locale: key.to_s, name: stuff.send(that) } if stuff.send(that) # && ((stuff.send(that) != geo_data[default_locale].send(that)) || (key.to_s == default_locale))
    end
    lng_params
  end
  
  def dev_log( stuff = " " )
    if !Rails.env.production?
      Rails.logger.info "###"
      Rails.logger.info "###   #{stuff}"
      Rails.logger.info "###"
    end
  end
  
  def default_locale
    MagicAddresses.configuration.default_locale.to_s
  end
  
end

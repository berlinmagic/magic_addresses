# encoding: utf-8
module AddressBuilder
  extend ActiveSupport::Concern
  

  included do
    before_validation :build_address_associations_if_needed
  end

  module ClassMethods
    # => ...
  end
  
  
  def street_is_changed?
    self.street_name.present? && self.street.blank? || self.street && (self.street.to_s.downcase != self.street_name.to_s.downcase.strip)
  end
  
  def city_is_changed?
    self.city_name.present? && !self.city || self.city && self.city.name && (self.city.name.to_s.downcase != self.city_name.to_s.downcase.strip)
  end
  
  def country_is_changed?
    self.country_name.present? && !self.country || self.country && self.country.name && (self.country.name.to_s.downcase != self.country_name.to_s.downcase.strip)
  end
  
  def country_code_is_changed?
    self.country_code.present? && !self.country || self.country && self.country.iso_code && (self.country.iso_code.to_s.downcase != self.country_code.to_s.downcase.strip)
  end
  
  # =====> I N S T A N C E - M E T H O D S <================================================= #
private

  
  def build_address_associations_if_needed
    dev_log "address ... #{self.owner.class.name.to_s if self.owner} .. #{self.owner_type}"
    # build_address_associations() if self.new_record? || self.street_number_changed? || self.zipcode_changed? || city_is_changed? || country_is_changed?
    if self.new_record? || self.street_number_changed? || self.zipcode_changed? || street_is_changed? || city_is_changed? || country_is_changed?
      dev_log
      dev_log "build_address_associations needed !!!"
      dev_log
      build_address_associations
    else
      dev_log
      dev_log "build_address_associations is not needed .. .. .."
      dev_log
    end
  end
  
  
  def build_address_associations
    dev_log "triggered   A D D R E S S - B U I L D E R ! - - #{self.street_name} #{self.street_number} #{self.city_name} #{self.zipcode}"
    
    if self.address.present?
      self.fetch_address = self.address
    elsif (city_is_changed? || (self.zipcode.present? && self.zipcode_changed?)) && (self.country_name.present? || self.country_code.present?)
      self.fetch_address = "#{self.street_name} #{self.street_number} #{self.city_name} #{self.zipcode} #{self.country_name} #{self.country_code}".strip
    elsif (city_is_changed? || (self.zipcode.present? && self.zipcode_changed?)) || street_is_changed? || (self.street_number.present? && self.street_number_changed?)
      street = self.street if self.street.present?
      street = self.street_name if self.street_name.present?
      self.fetch_address = "#{street} #{self.street_number} #{self.city_name} #{self.zipcode} #{self.country_name || 'Germany'}".strip
    end
    geo_data = {}
    if self.fetch_address.present?
      # => gd = Geocoder.search( self.fetch_address, params: { language: "en" })
      gd = GeoCoder.search( self.fetch_address, "de" )
      geo_data["de"] =  gd.first if gd.first
      sleep 0.2
      gd = GeoCoder.search( self.fetch_address, "en" )
      geo_data["en"] = gd.first if gd.first
    end
    if geo_data.any?
      dev_log "   geo_data  is present !!!"
      # set default values
      self.street_default = geo_data["en"].street if geo_data["en"] && geo_data["en"].street
      self.zipcode = geo_data["de"].postal_code if geo_data["de"] && geo_data["de"].postal_code
      self.street_number = geo_data["de"].street_number if geo_data["de"] && geo_data["de"].street_number
      # set geo-position
      self.latitude = geo_data["en"].latitude if geo_data["en"] && geo_data["en"].latitude
      self.longitude = geo_data["en"].longitude if geo_data["en"] && geo_data["en"].longitude
    end
    complete_translated_attributes( geo_data )
  end
  
  def complete_translated_attributes( geo_data = {} )
    if geo_data.any?
      # build street parameters
      street_params = []
      geo_data.each do |key, stuff|
        street_params << { locale: key.to_s, street: stuff.street } if stuff.street && ((stuff.street != geo_data["en"].street) || ["en","de"].include?(key.to_s))
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
      
      self.street_default = geo_data["en"].street if geo_data["en"] && geo_data["en"].street
      
      # build country
      if geo_data["de"].country_code.present?
        connet_address_association( :country, geo_data )
      end
      # build state
      if geo_data["de"].state_code.present? && self.country
        connet_address_association( :state, geo_data )
      end
      # build city
      if geo_data["de"].city.present? && self.country
        connet_address_association( :city, geo_data )
      end
      # build district
      if geo_data["de"].district.present? && self.city
        connet_address_association( :district, geo_data )
      end
      # build subdistrict
      if geo_data["de"].subdistrict.present? && self.city && self.district
        connet_address_association( :subdistrict, geo_data )
      end
      
    end
  end
  
  ## Build Associations
  
  def connet_address_association( that, geo_data )
    dev_log ">>> #{that.to_s.upcase}: #{ geo_data["en"].send(that) }"
    that_params = { name_default: geo_data["en"].send(that).to_s }
    that_params[ that == :country ? :iso_code : :short_name ] = geo_data["en"].send( "#{that}_code".to_sym ).to_s
    that_params.merge!({ country_id: self.country.id })     if [:city, :state].include?(that) && self.country
    that_params.merge!({ state_id: self.state.id })         if that == :city && self.state
    that_params.merge!({ city_id: self.city.id })           if [:district, :subdistrict].include?(that) && self.city
    that_params.merge!({ district_id: self.district.id })     if that == :subdistrict && self.district
    
    self.attributes = { that => "Location::#{that.to_s.classify}".constantize.unscoped.where( that_params ).first_or_create }# unless self.send(that)
    
    dev_log "#{that}"
    
    self.send(that).translations = []
    self.send(that).translations_attributes = lng_params( that, geo_data )
    self.send(that).save
  end
  
  ## Build Association Params
  
  def lng_params( that, geo_data )
    lng_params = []
    geo_data.each do |key, stuff|
      dev_log "#{that.to_s.titleize}-Params (#{key}) ... #{stuff.send(that)}"
      lng_params << { locale: key.to_s, name: stuff.send(that) } if stuff.send(that) && ((stuff.send(that) != geo_data["en"].send(that)) || (key.to_s == "en"))
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


end
# encoding: utf-8
class MagicAddresses::Address < ActiveRecord::Base
  
  # =====> R E W R I T E S <================================================================= #
  # self.table_name = "mgca_addresses"
  
  
  # =====> C O N S T A N T S <=============================================================== #
  PARAMS = [ :id, :street, :street_additional, :number, :postalcode, :city, :country, :country_code, :owner, :_destroy ]
  
  
  # =====> A S S O Z I A T I O N S <========================================================= #
  has_many :addressibles,         class_name: "MagicAddresses::Addressible",  foreign_key: :address_id
  
  
  ## add associations (set in configuration)
  MagicAddresses.configuration.address_owners.each do |key,type|
    has_many key.to_sym, through: :addressibles, source: :owner, source_type: type
  end
  
  
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
  mgca_translate :street_name
  
  acts_as_geolocated lat: 'latitude', lng: 'longitude' if MagicAddresses.configuration.earthdistance
  
  
  # =====> A T T R I B U T E S <============================================================= #
  # accepts_nested_attributes_for :translations
  
  serialize       :fetch_address, Hash
  
  
  # fetch getter and setter
  %w[fetch_street fetch_number fetch_city fetch_zipcode fetch_country fetch_country_code].each do |key|
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
  # attr_accessor :number (:street_number)
  def number
    fetch_address && fetch_address["fetch_number"] || street_number
  end
  # attr_accessor :postalcode (:zipcode)
  def postalcode
    fetch_address && fetch_address["fetch_zipcode"] || zipcode
  end
  # attr_accessor :country_code
  def country_code
    fetch_address && fetch_address["fetch_country_code"] || self.send("magic_country") && self.send("magic_country").iso_code
  end
  # more getter
  %w[country state city district subdistrict].each do |key|
    # attr_accessor key
    define_method(key) do
      fetch_address && fetch_address["fetch_#{key}"] || self.send("magic_#{key}") && self.send("magic_#{key}").name
    end
  end
  # settter methods
  %w[country state city district subdistrict street number postalcode country_code].each do |key|
    define_method("#{key}=") do |value|
      self.street_name = value  if key == "street"
      self.fetch_address = (fetch_address || {}).merge("fetch_#{ key == 'postalcode' ? 'zipcode' : key }" => value)
    end
  end



  # =====> C A L L B A C K S <=============================================================== #
  ## now in addressible or doesnt work nested ..
  # => after_save :build_address_associations_if_needed
  # => after_create :build_address_associations_if_needed


  # =====> S C O P E S <===================================================================== #


  # =====> C L A S S - M E T H O D S <======================================================= #
  def self.get_one( owner, params )
    # => that = self.new( city: params[:city], postalcode: params[:postalcode], street: params[:street], number:  params[:number], country: params[:country] )
    # => that.owner = owner
    # => that.save
    # => that.trigger_build_address_associations
    # puts "> get_one( #{ owner.class },  #{params}  )"
    if params[:id].present? && self.find( params[:id].to_i )
      current = self.find( params[:id].to_i )
      # if params[:postalcode].present? || params[:postalcode].present? || params[:postalcode].present? || params[:postalcode].present?
      checker = []
      [:street, :number, :postalcode, :city, :country].each do |prm|
        if params[prm].present? && ( "#{ params[prm] }" != "#{ current.send("#{prm}") }" )
          checker << true
          puts "#{prm}:  #{ params[prm] }  !=  #{ current.send("#{prm}") }"
        end
      end
      if checker.include?( true )
        that = self.new( city: params[:city], postalcode: params[:postalcode], street: params[:street], number:  params[:number], country: params[:country] )
        that.trigger_build_address_associations
      else
        current
      end
    else
      if params[:postalcode].present? && params[:city].present?
        that = self.new( city: params[:city], postalcode: params[:postalcode], street: params[:street], number:  params[:number], country: params[:country] )
        that.trigger_build_address_associations
      else
        nil
      end
    end
  end
  
  
  # =====> I N S T A N C E - M E T H O D S <================================================= #
  
  def update_fetch_address( atts = {} )
    self.fetch_address = (self.fetch_address || {}).merge( atts )
  end
  
  
  def presentation( style = "full", type = "inline" )
    adr = []
    adr << "#{street} #{number}".strip if street.present?
    adr << "#{postalcode} #{city}" if zipcode.present? || city.present?
    adr << country if country.present? if style == "full"
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
  
  def owners
    addressibles.map { |that| ::MagicAddresses::OwnerProxy.new( that ) }
  end
  
  def owner=(this)
    self.addressibles.where( owner_type: this.class.to_s, owner_id: this.id ).first_or_create!
  end
  
  def touch_owners
    addressibles.map { |that| that.owner.touch }
  end
  
  def trigger_build_address_associations
    build_address_associations()
  end
  
  def trigger_complete_translated_attributes
    complete_translated_attributes()
  end
  
  
  # =====>  P  R  I  V  A  T  E  !  <======================================================== # # # # # # # #
private
  
  def build_address_associations_if_needed
    #if self.new_record? || self.fetch_street.present? || self.fetch_city.present? || self.fetch_zipcode.present? || self.fetch_number.present?
    if self.new_record? || !["fetched", "translated"].include?( self.status )
      build_address_associations
    else
      true
    end
  end
  
  
  def build_fetch_address_addr
    if self.fetch_city.present? || self.fetch_zipcode.present?
      self.fetch_address["addr"] = []
      # MagicAddresses::GeoCoder
      self.fetch_address["addr"] << "#{self.fetch_street} #{self.fetch_number}".strip if self.fetch_street
      self.fetch_address["addr"] << "#{self.fetch_zipcode} #{self.fetch_city}".strip if self.fetch_city || self.fetch_zipcode
      if MagicAddresses.configuration.query_defaults
        self.fetch_address["addr"] << "#{self.fetch_country || self.fetch_country_code || MagicAddresses.configuration.default_country}".strip
      else
        self.fetch_address["addr"] << "#{self.fetch_country || self.fetch_country_code}".strip if self.fetch_country || self.fetch_country
      end
    end
  end
  
  
  def build_fetch_address_geo_data
    if self.fetch_address["addr"] && self.fetch_address["addr"].any?
      self.fetch_address["geo_data"] = {}
      gd = MagicAddresses::GeoCoder.search(self.fetch_address["addr"].join(", "), default_locale)
      self.fetch_address["geo_data"][default_locale] =  gd.first if gd.first
      self.fetch_address["fetched"] = true
      self.status = "fetched"
    end
  end
  
  def set_address_defaults( geo_data )
    if geo_data
      self.street_default = geo_data.street         if geo_data.street
      self.zipcode        = geo_data.postal_code    if geo_data.postal_code
      self.street_number  = geo_data.street_number  if geo_data.street_number
      # set geo-position
      self.latitude       = geo_data.latitude       if geo_data.latitude
      self.longitude      = geo_data.longitude      if geo_data.longitude
    end
  end
  
  
  def build_address_associations
    dev_log "- - - - - - - - - - - - - - - - -"
    dev_log " A D D R E S S - B U I L D E R !  ->  #{self.street} #{self.number} #{self.city} #{self.postalcode}"
    
    build_fetch_address_addr( )
    
    build_fetch_address_geo_data( )
    
    if self.fetch_address["geo_data"] && self.fetch_address["geo_data"].any?
      geo_data = self.fetch_address["geo_data"][default_locale]
      if self.id && self.id.present?
        loockups = MagicAddresses::Address.where.not( id: self.id )
      else
        loockups = MagicAddresses::Address.unscoped
      end
      sames = loockups.where(
                                latitude: geo_data.latitude, longitude: geo_data.longitude, 
                                zipcode: geo_data.postal_code, street_default: geo_data.street, street_number: geo_data.street_number 
                             )
      if sames.any?
        dev_log "! found similar address .. will use that !"
        that = sames.first
        self.addressibles.map{ |x| x.update_column(:address_id, that.id) }
        self.destroy
        dev_log
        ## inform address owners
        that.touch_owners
        ## return address
        that
      else
        
        if self.status == "translated"
          dev_log "! allready set-up ... change!"
          dev_log
        else
          # set default values
          set_address_defaults( geo_data )
          # translate other languages
          if MagicAddresses.configuration.job_backend == :sidekiq
            ::MagicAddresses::AddressWorker.perform_async( self.id )
          else
            complete_translated_attributes()
          end
          self.save
          dev_log
          ## inform address owners
          self.touch_owners
          ## return address
          self
        end
        
      end
      
    end
    
    
  end
  
  
  def complete_translated_attributes
    
    MagicAddresses.configuration.active_locales.each do |lcl|
      unless lcl.to_s == default_locale
        sleep 0.3
        gd = MagicAddresses::GeoCoder.search( self.fetch_address["addr"].join(", "), lcl.to_s )
        self.fetch_address["geo_data"][lcl.to_s] =  gd.first if gd.first
      end
    end
    
    geo_data = self.fetch_address["geo_data"]
    
    if geo_data.any?
      # build street parameters
      dev_log ">>> Street"
      street_params = []
      geo_data.each do |key, stuff|
        dev_log "    #{key}:  #{ stuff.street }"
        if MagicAddresses.configuration.uniq_translations
          # => only save locale if different from default-locale:
          street_params << { locale: key.to_s, street_name: stuff.street } if stuff.street && ((stuff.street != geo_data[default_locale].street) || (default_locale == key.to_s))
        else
          street_params << { locale: key.to_s, street_name: stuff.street } if stuff.street
        end
      end
      # set street parameters if present
      if street_params.any?
        # reset translations (avoid empty translation in default language)
        # => self.translations = []
        self.translations.delete_all
        # set street parameters
        self.translations_attributes = street_params
        dev_log "    set translations: #{ street_params.map{ |k| k[:locale] }.join(", ") }"
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
      
      self.fetch_address  = {}
      self.status         = "translated"
      self.save
      
    end
  end
  
  ## Build Associations
  
  def connet_address_association( that, geo_data )
    this = "magic_#{that}".to_sym
    dev_log "#{that.to_s.upcase} (#{this}):   #{ geo_data[default_locale].send(that) }"
    that_params = { default_name: geo_data[default_locale].send(that).to_s }
    that_params[ that == :country ? :iso_code : :short_name ] = geo_data[default_locale].send( "#{that}_code".to_sym ).to_s
    that_params.merge!({ country_id: self.magic_country.id })     if [:city, :state].include?(that) && self.magic_country
    that_params.merge!({ state_id: self.magic_state.id })         if that == :city && self.magic_state
    that_params.merge!({ city_id: self.magic_city.id })           if [:district, :subdistrict].include?(that) && self.magic_city
    that_params.merge!({ district_id: self.magic_district.id })   if that == :subdistrict && self.magic_district
    
    self.attributes = { this => "MagicAddresses::#{that.to_s.classify}".constantize.unscoped.where( that_params ).first_or_create! }# unless self.send(that)
    
    # self.send(this).translations = []
    self.send(this).translations.delete_all
    self.send(this).translations_attributes = lng_params( that, geo_data )
    self.send(this).save
  end
  
  ## Build Association Params
  
  def lng_params( that, geo_data )
    lng_params = []
    geo_data.each do |key, stuff|
      dev_log "    #{key}:   #{stuff.send(that)}"
      
      if MagicAddresses.configuration.uniq_translations
        # => only save locale if different from default-locale:
        lng_params << { locale: key.to_s, name: stuff.send(that) } if stuff.send(that) && ((stuff.send(that) != geo_data[default_locale].send(that)) || (key.to_s == default_locale))
      else
        lng_params << { locale: key.to_s, name: stuff.send(that) } if stuff.send(that)
      end
    end
    lng_params
  end
  
  def update_fetch_address( atts = {} )
    self.fetch_address = (self.fetch_address || {}).merge( atts )
  end
  
  def dev_log( stuff = " " )
    if Rails.env.test?
      puts "#: #{stuff}"
    elsif !Rails.env.production?
      Rails.logger.info "###   #{stuff}"
    end
  end
  
  def default_locale
    MagicAddresses.configuration.default_locale.to_s
  end
  
end

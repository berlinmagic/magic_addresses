# encoding: utf-8
class AddressWorker
  include Sidekiq::Worker

  def perform( address_id = nil )
    if address_id && address = ::Location::Address.find( address_id )
      
      if address.fetch_address.present?
        puts "###"
        puts "### AddressWorker:[#{address_id}]:   #{address.fetch_address}"
        puts "###"
        address.build_association_translations
      end
      
      # => if address.fetch_address.present?
      # =>   
      # =>   puts "AddressWorker::   '#{address.fetch_address}'"
      # =>   geo_data = {}
      # =>   ::Wizard::Locale.where(locale_state: ["active","live"]).each do |lc|
      # =>     puts "AddressWorker::   - #{lc.name} (#{ lc.iso_code })"
      # =>     sleep 1.5
      # =>     gd = Geocoder.search( address.fetch_address, params: { language: lc.iso_code })
      # =>     geo_data[lc.iso_code] =  gd.first if gd.first
      # =>   end
      # =>   
      # =>   puts "AddressWorker::   Build Associations"
      # =>   address.build_association_translations( geo_data )
      # =>   
      # =>   address.address = nil
      # =>   address.fetch_address = nil
      # =>   address.save
      # =>   
      # =>   puts "AddressWorker::   Remove empty translations"
      # =>   # => self.translations.where("street is NULL").map { |t| t.delete }
      # =>   address.translations.where( street: [ "", nil ] ).delete_all
      # =>   address.country.translations.where( name: [ "", nil ] ).delete_all    if address.country
      # =>   address.state.translations.where( name: [ "", nil ] ).delete_all      if address.state
      # =>   address.city.translations.where( name: [ "", nil ] ).delete_all       if address.city
      # =>   address.subcity.translations.where( name: [ "", nil ] ).delete_all    if address.subcity
      # =>   address.subsubcity.translations.where( name: [ "", nil ] ).delete_all if address.subsubcity
      # =>   
      # => end
    end
  end

end
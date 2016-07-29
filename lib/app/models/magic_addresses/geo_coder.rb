# encoding: utf-8
class MagicAddresses::GeoCoder
  
  def self.search( q = "", language = "de" )
    if q.present?
      log "GeoCode (#{language}):   #{q}"
      attempts = 0
      begin
        search_via_google
        results = Geocoder.search( q, language: language )
        log " - google:   [#{results.count}]"
        return results
      rescue Exception => e
        log "! Google-Error:   #{e} !"
        sleep 0.3
        attempts += 1
      end while attempts < 3
      unless results
        search_via_nominatim
        results = Geocoder.search( q, language: language )
        log " - nominatim:   [#{results.count}]"
      end
    else
      results = []
    end
    return results
  end
  
  
  def self.search_via_google
    Geocoder.configure( :lookup => :google )
  end
  
  def self.search_via_nominatim
    Geocoder.configure( :lookup => :nominatim )
  end
  
  def self.log( stuff = " " )
    if Rails.env.test?
      puts "#: #{stuff}"
    elsif !Rails.env.production?
      Rails.logger.info "###   #{stuff}"
    end
  end
  
end
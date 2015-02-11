# encoding: utf-8
class GeoCoder
  
  def self.search( q = "", language = "de" )
    if q.present?
      log "GeoCode (#{language}):   #{q}"
      attempts = 0
      begin
        search_via_google
        results = Geocoder.search( q, language: language )
        log "google Geocoded:   #{results.to_yaml}"
        return results
      rescue Exception => e
        log "Google -- #{e}"
        sleep 0.3
        attempts += 1
      end while attempts < 3
      unless results
        search_via_nominatim
        results = Geocoder.search( q, language: language )
        log "nominatim Geocoded:   #{results.to_yaml}"
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
  
  def self.log( stuff = "+ geo + geo + geo + geo + geo + geo + " )
    if Rails.env.development?
      Rails.logger.info "+ geo + geo + geo + geo + geo + geo + "
      Rails.logger.info stuff
      Rails.logger.info "+ geo + geo + geo + geo + geo + geo + "
    end
  end
  
end
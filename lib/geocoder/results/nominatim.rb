module Geocoder::Result
  Nominatim.class_eval do
    
    
    ## Additional Stuff
    
    def city
      %w[city town village hamlet].each do |key|
        return @data['address'][key] if @data['address'].key?(key)
      end
      @data['display_name'].split(',').count > 3 ? @data['display_name'].split(',')[-3].strip : nil
      # return nil
    end
    
    def street
      %w[road pedestrian highway].each do |key|
        return @data['address'][key] if @data['address'].key?(key)
      end
      return nil
    end
    
    def street_number
      @data['address']['house_number']
    end
    
    def country_code
      @data['address']['country_code'].present? ? @data['address']['country_code'].to_s.upcase : nil
    end
    
    def subcity
      @data['address']['city_district'].present? ? @data['address']['city_district'] : nil
    end
    
    def subsubcity
      @data['address']['suburb'].present? ? @data['address']['suburb'] : nil
    end
    
    def city_code
      %w[city town village hamlet].each do |key|
        return @data['address'][key] if @data['address'].key?(key)
      end
      @data['display_name'].split(',').count > 3 ? @data['display_name'].split(',')[-3].strip : nil
    end
    
    def subcity_code
      @data['address']['city_district'].present? ? @data['address']['city_district'] : nil
    end
    
    def subsubcity_code
      @data['address']['suburb'].present? ? @data['address']['suburb'] : nil
    end
    
    
  end
end
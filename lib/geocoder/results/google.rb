module Geocoder::Result
  Google.class_eval do
    
    
    ## Additional Stuff
    
    def street
      if route = address_components_of_type(:route).first
        route['long_name']
      end
    end
    
    def district
      fields = [:sublocality_level_1, :sublocality]
      fields.each do |f|
        if entity = address_components_of_type(f).first
          return entity['long_name']
        end
      end
      return nil # no appropriate components found
    end
  
    def subdistrict
      if subdistrict = address_components_of_type(:sublocality_level_2).first
        return subdistrict['long_name']
      end
      return nil # no appropriate components found
    end
    
    
    ## Additional Short-Names
    
    def city_code
      fields = [:locality, :sublocality,
        :administrative_area_level_3,
        :administrative_area_level_2]
      fields.each do |f|
        if entity = address_components_of_type(f).first
          return entity['short_name']
        end
      end
      return nil # no appropriate components found
    end
    
    def district_code
      fields = [:sublocality_level_1, :sublocality]
      fields.each do |f|
        if entity = address_components_of_type(f).first
          return entity['short_name']
        end
      end
      return nil # no appropriate components found
    end
    
    def subdistrict_code
      if subdistrict = address_components_of_type(:sublocality_level_2).first
        return subdistrict['short_name']
      end
      return nil # no appropriate components found
    end
    
  end
end
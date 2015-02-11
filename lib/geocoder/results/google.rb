module Geocoder::Result
  Google.class_eval do
    
    
    ## Additional Stuff
    
    def street
      if route = address_components_of_type(:route).first
        route['long_name']
      end
    end
    
    def subcity
      fields = [:sublocality_level_1, :sublocality]
      fields.each do |f|
        if entity = address_components_of_type(f).first
          return entity['long_name']
        end
      end
      return nil # no appropriate components found
    end
  
    def subsubcity
      if subsubcity = address_components_of_type(:sublocality_level_2).first
        return subsubcity['long_name']
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
    
    def subcity_code
      fields = [:sublocality_level_1, :sublocality]
      fields.each do |f|
        if entity = address_components_of_type(f).first
          return entity['short_name']
        end
      end
      return nil # no appropriate components found
    end
    
    def subsubcity_code
      if subsubcity = address_components_of_type(:sublocality_level_2).first
        return subsubcity['short_name']
      end
      return nil # no appropriate components found
    end
    
  end
end
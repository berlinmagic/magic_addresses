# encoding: utf-8
module MagicAddresses
  module Translator
  
    def self.included(base)
      base.send :extend, ClassMethods
    end
  
    ##   C L A S S - M E T H O D S   # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
    module ClassMethods
    
      def mgca_translate( field = :name )
        send :include, InstanceMethods
        
        translates field, fallbacks_for_empty_translations: true
        accepts_nested_attributes_for :translations, reject_if: proc { |attributes| attributes[field.to_s].blank? }
      end
    
    
    end #> ClassMethods
    
    
    ##   I N S T A N C E - M E T H O D S   # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
    module InstanceMethods
      
      def with_translations(*locales)
        locales = translated_locales if locales.empty?
        includes(:translations).with_locales(locales).with_required_attributes
      end
      
      # need to be loaded so stupid, otherwise it is accessible for all model (tested with rspec)
      def self.included(base)
        base.send :extend, MoreClassMethods
      end
      
    end #> InstanceMethods
    
    ##   M O R E - M E T H O D S   # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
    module MoreClassMethods
      
      def search(search)
        field = self.respond_to?(:street_name) ? :street_name : :name
        if search
          with_translations.where("#{field} LIKE ?", "%#{search}%")
        else
          with_translations
        end
      end
      
    end #> MoreClassMethods
    
  end
end

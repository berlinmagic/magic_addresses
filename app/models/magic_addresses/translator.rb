# encoding: utf-8
module MagicAddresses
  module Translator
  
    def self.included(base)
      base.send :extend, ClassMethods
    end
  
    ##   C L A S S - M E T H O D S   # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
    module ClassMethods
    
      def mgca_translate( field = :name )
        # send :extend, ClassMethods
        send :include, InstanceMethods
        
        translates field, fallbacks_for_empty_translations: true
        accepts_nested_attributes_for :translations, reject_if: proc { |attributes| attributes[field.to_s].blank? }
        
        # add search class method
        # => self.class.send(:define_method, :search) do |search|
        # =>   if self.respond_to?(:translations)
        # =>     if search
        # =>       logger.info "#{field} = #{search}"
        # =>       with_translations.where("#{field} LIKE ?", "%#{search}%")
        # =>     else
        # =>       with_translations
        # =>     end
        # =>   else
        # =>     nil
        # =>   end
        # => end
        
      end
    
    
    end #> ClassMethods
    
    
    ##   I N S T A N C E - M E T H O D S   # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
    module InstanceMethods
      
      def with_translations(*locales)
        locales = translated_locales if locales.empty?
        includes(:translations).with_locales(locales).with_required_attributes
      end
      
      def self.included(base)
        base.send :extend, MoreMethods
      end
      
    end #> InstanceMethods
    
    ##   M O R E - M E T H O D S   # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
    module MoreMethods
      
      def search(search)
        field = self.respond_to?(:street) ? :street : :name
        if search
          with_translations.where("#{field} LIKE ?", "%#{search}%")
        else
          with_translations
        end
      end
      
    end #> InstanceMethods
    
  end
end

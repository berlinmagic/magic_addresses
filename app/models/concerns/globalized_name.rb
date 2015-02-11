module GlobalizedName
  extend ActiveSupport::Concern


  included do
    
    translates :name, fallbacks_for_empty_translations: true
    
    accepts_nested_attributes_for :translations, reject_if: proc { |attributes| attributes['name'].blank? }
    
  end


  module ClassMethods
    
    def search(search)
      if search
        with_translations.where('name LIKE ?', "%#{search}%")
      else
        with_translations
      end
    end
    
  end

  # =====> I N S T A N C E - M E T H O D S <================================================= #

  def with_translations(*locales)
    locales = translated_locales if locales.empty?
    includes(:translations).with_locales(locales).with_required_attributes
  end


end
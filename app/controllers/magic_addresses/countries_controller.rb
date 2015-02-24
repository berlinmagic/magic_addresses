# encoding: utf-8
class MagicAddresses::CountriesController < MagicAddresses::BaseController
  
  def index
    @countries = ::MagicAddresses::Country.includes(:translations).with_translations(I18n.locale).order( 'mgca_country_translations.name ASC' )
  end
  
  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def instance_params
      params.require(:country).permit(:name, :default_name, :iso_code, :translations_attributes => [:id, :name, :locale])
    end

end

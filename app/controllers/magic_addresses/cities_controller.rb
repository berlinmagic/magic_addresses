# encoding: utf-8
class MagicAddresses::CitiesController < MagicAddresses::BaseController
  
  def index
    # @cities = ::MagicAddresses::City.includes(:translations).with_translations(I18n.locale).order( 'mgca_city_translations.name ASC' )
    # @cities = ::MagicAddresses::City.includes(:translations).order("mgca_city_translations.name ASC")
    @cities = ::MagicAddresses::City.includes(:translations).order(short_name: :asc)
  end
  
  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def instance_params
      params.require(:city).permit(:name, :default_name, :short_name, :translations_attributes => [:id, :name, :locale])
    end

end

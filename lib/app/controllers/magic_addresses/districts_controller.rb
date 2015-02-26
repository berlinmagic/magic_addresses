# encoding: utf-8
class MagicAddresses::DistrictsController < MagicAddresses::BaseController
  
  def index
    # @districts = ::MagicAddresses::District.includes(:translations).with_translations(I18n.locale).order( 'mgca_district_translations.name ASC' )
    # @districts = ::MagicAddresses::District.includes(:translations).order("mgca_district_translations.name ASC")
    @districts = ::MagicAddresses::District.includes(:translations).order(short_name: :asc)
  end
  
  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def instance_params
      params.require(:district).permit(:name, :default_name, :short_name, :translations_attributes => [:id, :name, :locale])
    end

end

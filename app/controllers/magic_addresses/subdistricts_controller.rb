# encoding: utf-8
class MagicAddresses::SubdistrictsController < MagicAddresses::BaseController
  
  def index
    # @subsubcities = ::MagicAddresses::Subdistrict.includes(:translations).with_translations(I18n.locale).order( 'mgca_subdistrict_translations.name ASC' )
    # @subsubcities = ::MagicAddresses::Subdistrict.includes(:translations).order("mgca_subdistrict_translations.name ASC")
    @subdistricts = ::MagicAddresses::Subdistrict.includes(:translations).order(short_name: :asc)
  end
  
  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def instance_params
      params.require(:subdistrict).permit(:name, :default_name, :short_name, :translations_attributes => [:id, :name, :locale])
    end

end

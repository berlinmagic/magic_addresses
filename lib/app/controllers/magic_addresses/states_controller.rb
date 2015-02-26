# encoding: utf-8
class MagicAddresses::StatesController < MagicAddresses::BaseController
  
  def index
    order_locales = [ I18n.locale ]
    order_locales << :en unless I18n.locale == :en
    @states = ::MagicAddresses::State.includes(:translations).with_translations(order_locales).order( 'mgca_state_translations.name ASC' )
    # @states = ::MagicAddresses::State.includes(:translations).with_translations(I18n.locale).order( 'mgca_state_translations.name ASC' )
    # @states = ::MagicAddresses::State.includes(:translations).order("mgca_state_translations.name ASC")
    @states = ::MagicAddresses::State.includes(:translations).order(short_name: :asc)
  end
  
  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def instance_params
      params.require(:state).permit(:name, :default_name, :short_name, :translations_attributes => [:id, :name, :locale])
    end

end

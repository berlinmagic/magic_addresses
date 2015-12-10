# encoding: utf-8
class MagicAddresses::AddressesController < MagicAddresses::BaseController
  
  def index
    @addresses = ::MagicAddresses::Address.includes( :translations, :magic_country, :magic_state, :magic_city, :magic_district, :magic_subdistrict ).order(created_at: :desc)
  end
  
end

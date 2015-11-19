# encoding: utf-8
class MagicAddresses::AddressWorker
  include Sidekiq::Worker

  def perform( address_id = nil )
    if address_id && address = ::MagicAddresses::Address.find( address_id )
      
      if address.fetch_address.present?
        puts "###"
        puts "### AddressWorker:[#{address_id}]:   #{address.fetch_address}"
        puts "###"
        address.trigger_complete_translated_attributes
      end
      
    end
  end

end
# encoding: utf-8
class MagicAddresses::AddressWorker
  include Sidekiq::Worker

  def perform( address_id = nil, counter = 1 )
    if address_id && address = ::MagicAddresses::Address.find( address_id.to_i )
      
      if address.fetch_address.present?
        puts "###"
        puts "### AddressWorker:[#{address_id}]:   #{address.fetch_address}"
        puts "###"
        address.trigger_complete_translated_attributes
      end
      
    else
      
      counter = counter.to_i
      puts "###"
      puts "### AddressWorker  =>  NO Address with ID: #{id} ...try ##{counter}"
      puts "###"
      if counter <= 3
        counter += 1
        ::MagicAddresses::AddressWorker.perform_in( 1.minute, id, counter )
      end
      
    end
  end

end
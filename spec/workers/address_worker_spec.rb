# => require 'spec_helper'
# => 
# => describe AddressWorker, sidekiq: :fake do
# =>   # => let(:address) { create :address }
# => 
# =>   it 'should call the ShiftplanMailer published_shiftplan_mail mailer' do
# =>     
# =>     # => Location::Address.should_receive(:build_association_translations).exactly(1).times.and_return( true )
# =>     # => 
# =>     # => AddressWorker.perform_async(address.id)
# =>     
# =>     expect {
# =>       AddressWorker.perform_async(1)
# =>     }.to change(AddressWorker.jobs, :size).by(1)
# =>     
# =>   end
# => 
# => end

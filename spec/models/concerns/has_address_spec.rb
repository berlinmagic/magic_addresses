# => require 'spec_helper'
# => 
# => describe HasAddress do
# =>   class TestPerson < ActiveRecord::Base
# =>     self.table_name = "users"
# =>     has_nested_address
# =>   end
# => 
# =>   class TestUser < ActiveRecord::Base
# =>     self.table_name = "users"
# =>   end
# => 
# =>   describe "has_one_address => inherit methods" do
# => 
# =>     let(:micha){
# =>       TestPerson.create!(name: "Schmidt", first_name: "Micha", email: "micha@example.com")
# =>     }
# => 
# =>     let(:ingo){
# =>       TestUser.create!(name: "Mueller", first_name: "Ingo", email: "ingo@example.com")
# =>     }
# => 
# =>     it "add address attributes" do
# =>       expect( micha.respond_to?(:address) ).to be true
# =>       expect( micha.address.new_record? ).to be true
# =>       micha.street = "Teststreet"
# =>       micha.city = "Testown"
# =>       micha.save
# =>       expect( micha.address.new_record? ).to be false
# =>       expect( micha.street ).to eql "Teststreet"
# =>       expect( micha.address.street ).to eql "Teststreet"
# =>       expect( micha.city ).to eql "Testown"
# =>     end
# => 
# =>     it "add address attributes only if asked for" do
# =>       expect( micha.respond_to?(:address) ).to be true
# =>       expect( ingo.respond_to?(:address) ).to be false
# =>     end
# => 
# =>   end
# => 
# =>   # Stack level too deep ???
# =>   describe "saves address attributes" do
# =>     class TestTheUser < ActiveRecord::Base
# =>       self.table_name = "users"
# =>       has_nested_address
# =>     end
# => 
# =>     # class TestTheCompany < ActiveRecord::Base
# =>     #   self.table_name = "companies"
# =>     #   has_one_address
# =>     # end
# => 
# =>      let(:user){ TestTheUser.create!(name: "Mueller", first_name: "Ingo", email: "ingo@example.com") }
# =>      # let(:company){ TestTheCompany.create!( name: "Mueller Inc." ) }
# => 
# =>      it "save as own attributes" do
# =>        user.street = "Fakestr."
# =>        user.number = "14"
# =>        user.zip = "12345"
# =>        user.city = "Berlin"
# =>        expect( user.valid? ).to eq true
# =>        user.save
# =>        expect( user.street ).to eq "Fakestr."
# =>        expect( user.address.street ).to eq "Fakestr."
# =>        expect( user.number ).to eq "14"
# =>        expect( user.address.number ).to eq "14"
# =>        expect( user.zip ).to eq "12345"
# =>        expect( user.address.zip ).to eq "12345"
# =>        expect( user.city).to eq "Berlin"
# =>        expect( user.address.city ).to eq "Berlin"
# =>      end
# => 
# =>      it "save as child attributes" do
# =>        expect( user.valid? ).to eq true
# =>        addr = FactoryGirl.attributes_for(:address)
# => 
# =>        user.address_attributes = addr
# =>        expect( user.valid? ).to eq true
# => 
# =>        expect( user.street ).to eq addr[:street]
# =>        expect( user.address.street ).to eq addr[:street]
# =>        expect( user.number ).to eq addr[:number]
# =>        expect( user.address.number ).to eq addr[:number]
# =>        expect( user.zip ).to eq addr[:zip]
# =>        expect( user.address.zip ).to eq addr[:zip]
# =>        expect( user.city ).to eq addr[:city]
# =>        expect( user.address.city ).to eq addr[:city]
# =>      end
# =>   end
# => 
# => end

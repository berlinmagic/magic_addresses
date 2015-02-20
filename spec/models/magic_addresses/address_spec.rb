require 'rails_helper'


describe MagicAddresses::Address do
  
  describe 'should have usual attributes' do
    
    # usual
    it { should respond_to :name }
    
    # location
    it { should respond_to :latitude }
    it { should respond_to :longitude }
    
    # globalize
    it { should respond_to :street }
    it { should respond_to :read_attribute }
    it { should accept_nested_attributes_for :translations }
    
    # polymorph owner
    it { should respond_to :owner }
    it { should respond_to :owner_type }
    it { should respond_to :owner_id }
    
    # fetch params
    it { should respond_to :fetch_address }
    it { should respond_to :fetch_street }
    it { should respond_to :fetch_number }
    it { should respond_to :fetch_city }
    it { should respond_to :fetch_zipcode }
    it { should respond_to :fetch_country }
    
    
  end
  
  describe 'validations' do 
    it { should validate_presence_of :owner }
  end
  
  
  
  describe "use fetch address to save" do

    let(:user){ User.create!(name: "Test User") }
    let(:address){ MagicAddresses::Address.create!(name: "Test", owner: user) }


    it "save attributes first in fetch_address" do
      I18n.locale = :en
      expect( address.fetch_address ).to eq( {} )
      address.street = "Heinz-Kapelle-Street"
      expect( address.fetch_address ).to eq( { "fetch_street" => "Heinz-Kapelle-Street" } )
      expect( address.street ).to eq "Heinz-Kapelle-Street"
      expect( address.fetch_street ).to eq "Heinz-Kapelle-Street"
      expect( address.street_name ).to eq "Heinz-Kapelle-Street"
      address.save
      expect( address.street ).to eq "Heinz-Kapelle-Street"
      expect( address.fetch_street ).to eq( "Heinz-Kapelle-Street" )
      expect( address.street_name ).to eq "Heinz-Kapelle-Street"
      I18n.locale = :de
      address.street = "Heinz-Kapelle-Straße"
      expect( address.fetch_address ).to eq( { "fetch_street" => "Heinz-Kapelle-Straße" } )
      expect( address.street ).to eq "Heinz-Kapelle-Straße"
      expect( address.fetch_street ).to eq "Heinz-Kapelle-Straße"
      expect( address.street_name ).to eq "Heinz-Kapelle-Straße"
      address.save
      expect( address.street ).to eq "Heinz-Kapelle-Straße"
      expect( address.fetch_street ).to eq( "Heinz-Kapelle-Straße" )
      expect( address.street_name ).to eq "Heinz-Kapelle-Straße"
      I18n.locale = :en
      expect( address.street_name ).to eq "Heinz-Kapelle-Street"
      I18n.locale = :de
      expect( address.street_name ).to eq "Heinz-Kapelle-Straße"
    end

  end
  
end
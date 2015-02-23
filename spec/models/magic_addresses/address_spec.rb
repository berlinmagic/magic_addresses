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
    
    
    # external attributes
    it { should respond_to :magic_country }
    it { should belong_to  :magic_country }
    it { should respond_to :country }
    it { should respond_to :country_id }
    
    it { should respond_to :magic_state }
    it { should belong_to  :magic_state }
    it { should respond_to :state }
    it { should respond_to :state_id }
    
    it { should respond_to :magic_city }
    it { should belong_to  :magic_city }
    it { should respond_to :city }
    it { should respond_to :city_id }
    
    
    it { should respond_to :magic_district }
    it { should belong_to  :magic_district }
    it { should respond_to :district }
    it { should respond_to :district_id }
    
    
  end
  
  describe 'validations' do 
    it { should validate_presence_of :owner }
  end
  
  
  
  describe "use fetch address to save street" do

    let(:user){ User.create!(name: "Test User") }
    let(:address){ MagicAddresses::Address.create!(name: "Test", owner: user) }


    it "save attributes first in fetch_address" do
      I18n.locale = :en
      expect( address.fetch_address ).to eq( {} )
      expect( address.fetch_street ).to eq nil
      expect( address.street ).to eq nil
      
      address.street = "Heinz-Kapelle-Street"
      expect( address.fetch_address ).to eq( { "fetch_street" => "Heinz-Kapelle-Street" } )
      expect( address.street ).to eq "Heinz-Kapelle-Street"
      expect( address.fetch_street ).to eq "Heinz-Kapelle-Street"
      expect( address.street_name ).to eq "Heinz-Kapelle-Street"
      address.save
      expect( address.street ).to eq "Heinz-Kapelle-Street"
      expect( address.fetch_street ).to eq( nil )
      expect( address.street_name ).to eq "Heinz-Kapelle-Street"
      I18n.locale = :de
      address.street = "Heinz-Kapelle-Straße"
      expect( address.fetch_address ).to eq( { "fetch_street" => "Heinz-Kapelle-Straße" } )
      expect( address.street ).to eq "Heinz-Kapelle-Straße"
      expect( address.fetch_street ).to eq "Heinz-Kapelle-Straße"
      expect( address.street_name ).to eq "Heinz-Kapelle-Straße"
      address.save
      expect( address.street ).to eq "Heinz-Kapelle-Straße"
      expect( address.fetch_street ).to eq( nil )
      expect( address.street_name ).to eq "Heinz-Kapelle-Straße"
      I18n.locale = :en
      expect( address.street_name ).to eq "Heinz-Kapelle-Street"
      I18n.locale = :de
      expect( address.street_name ).to eq "Heinz-Kapelle-Straße"
    end

  end
  
  describe "use fetch address to save foreign attributes" do
    let(:user){ User.create!(name: "Some User") }
    let(:address){ MagicAddresses::Address.create!(name: "Another", owner: user) }
    
    it "save country attributes first in fetch_address" do
      I18n.locale = :en
      expect( address.fetch_address ).to eq( {} )
      address.country = "Germany"
      expect( address.fetch_address ).to eq( { "fetch_country" => "Germany" } )
      expect( address.country ).to eq "Germany"
      expect( address.fetch_country ).to eq "Germany"
    end
    
    it "save city attributes first in fetch_address" do
      I18n.locale = :en
      expect( address.fetch_address ).to eq( {} )
      address.city = "Berlin"
      expect( address.fetch_address ).to eq( { "fetch_city" => "Berlin" } )
      expect( address.city ).to eq "Berlin"
      expect( address.fetch_city ).to eq "Berlin"
    end
    
    
  end
  
  
  describe "fetches correct address after save" do
    
    let(:user){ User.create!(name: "Some User") }
    let(:address){ MagicAddresses::Address.create!(name: "Another", owner: user) }
    
    it "save country attributes first in fetch_address" do
      I18n.locale = :en
      expect( address.fetch_address ).to eq( {} )
      address.street = "Heinz-Kapelle-Str."
      address.number = "6"
      address.postalcode = 10407
      address.city = "Berlin"
      address.country = "Germany"
      
      # there should be no associations if no address yet 
      expect( MagicAddresses::Country.all.count ).to eq( 0 )
      expect( MagicAddresses::State.all.count ).to eq( 0 )
      expect( MagicAddresses::City.all.count ).to eq( 0 )
      expect( MagicAddresses::District.all.count ).to eq( 0 )
      expect( MagicAddresses::Subdistrict.all.count ).to eq( 0 )
      
      # fetch_address should be set
      expect( address.fetch_address ).to eq( { "fetch_street" => "Heinz-Kapelle-Str.", "fetch_number" => "6", "fetch_zipcode" => 10407, "fetch_city" => "Berlin", "fetch_country" => "Germany" } )
      
      address.save
      
      # fetch_address should be emty again
      expect( address.fetch_address ).to eq( {} )
      
      # address should have needed associations now
      expect( MagicAddresses::Country.all.count ).to eq( 1 )
      expect( MagicAddresses::State.all.count ).to eq( 1 )
      expect( MagicAddresses::City.all.count ).to eq( 1 )
      expect( MagicAddresses::District.all.count ).to eq( 1 )
      expect( MagicAddresses::Subdistrict.all.count ).to eq( 1 )
      
      # address attributes should be set
      expect( address.number ).to eq( "6" )
      expect( address.street_number ).to eq( "6" )
      expect( address.postalcode ).to eq( 10407 )
      expect( address.zipcode ).to eq( 10407 )
      
      expect( address.street ).to eq( "Heinz-Kapelle-Straße" )
      expect( address.street_name ).to eq( "Heinz-Kapelle-Straße" )
      
      # all virtual atts and associations should be equal
      expect( address.country ).to eq( "Germany" )
      expect( address.magic_country.name ).to eq( "Germany" )
      expect( address.state ).to eq( "Berlin" )
      expect( address.magic_state.name ).to eq( "Berlin" )
      expect( address.city ).to eq( "Berlin" )
      expect( address.magic_city.name ).to eq( "Berlin" )
      expect( address.district ).to eq( "Bezirk Pankow" )
      expect( address.magic_district.name ).to eq( "Bezirk Pankow" )
      expect( address.subdistrict ).to eq( "Prenzlauer Berg" )
      expect( address.magic_subdistrict.name ).to eq( "Prenzlauer Berg" )
      
      # There should be no empty or useless translations 
      # en: "Germany" .. de: "Deutschland"
      expect( MagicAddresses::Country.first.translations.all.count ).to eq( 2 )
      expect( MagicAddresses::Country.first.translations.where(name: [nil, ""]).count ).to eq( 0 )
      # both "Berlin"
      expect( MagicAddresses::State.first.translations.all.count ).to eq( 1 )
      expect( MagicAddresses::State.first.translations.where(name: [nil, ""]).count ).to eq( 0 )
      # both "Berlin"
      expect( MagicAddresses::City.first.translations.all.count ).to eq( 1 )
      expect( MagicAddresses::City.first.translations.where(name: [nil, ""]).count ).to eq( 0 )
      # both "Bezirk Pankow"
      expect( MagicAddresses::District.first.translations.all.count ).to eq( 1 )
      expect( MagicAddresses::District.first.translations.where(name: [nil, ""]).count ).to eq( 0 )
      # both "Prenzlauer Berg"
      expect( MagicAddresses::Subdistrict.first.translations.all.count ).to eq( 1 )
      expect( MagicAddresses::Subdistrict.first.translations.where(name: [nil, ""]).count ).to eq( 0 )
      # both "Heinz-Kapelle-Straße"
      expect( address.translations.all.count ).to eq( 1 )
      expect( address.translations.where(street_name: [nil, ""]).count ).to eq( 0 )
      
    end
    
  end
  
  
  
  
end
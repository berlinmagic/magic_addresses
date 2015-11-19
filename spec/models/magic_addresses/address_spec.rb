require 'rails_helper'


describe MagicAddresses::Address do
  
  describe 'should have usual attributes' do
    
    # usual
    it { should respond_to :name }
    
    it { should respond_to :status }
    
    # location
    it { should respond_to :latitude }
    it { should respond_to :longitude }
    
    # globalize
    it { should respond_to :street }
    it { should respond_to :read_attribute }
    it { should accept_nested_attributes_for :translations }
    
    # polymorph owner
    # => it { should respond_to :owner }
    # => it { should respond_to :owner_type }
    # => it { should respond_to :owner_id }
    it { should respond_to :addressibles }
    
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
  
  # => describe 'validations' do 
  # =>   it { should validate_presence_of :owner }
  # => end
  
  
  
  describe "use fetch address to save street" do

    let(:user){ User.new(name: "Test User") }
    # let(:address){ MagicAddresses::Address.create!(name: "Test", owner: user) }
    let(:address){ user.build_address(name: "Test") }


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
      # address.save
      user.save
      expect( address.street ).to eq "Heinz-Kapelle-Street"
      #expect( address.fetch_street ).to eq( nil )
      expect( address.street_name ).to eq "Heinz-Kapelle-Street"
      I18n.locale = :de
      address.street = "Heinz-Kapelle-Straße"
      expect( address.fetch_address ).to eq( { "fetch_street" => "Heinz-Kapelle-Straße" } )
      expect( address.street ).to eq "Heinz-Kapelle-Straße"
      expect( address.fetch_street ).to eq "Heinz-Kapelle-Straße"
      expect( address.street_name ).to eq "Heinz-Kapelle-Straße"
      address.save
      expect( address.street ).to eq "Heinz-Kapelle-Straße"
      #expect( address.fetch_street ).to eq( nil )
      expect( address.street_name ).to eq "Heinz-Kapelle-Straße"
      I18n.locale = :en
      expect( address.street_name ).to eq "Heinz-Kapelle-Street"
      I18n.locale = :de
      expect( address.street_name ).to eq "Heinz-Kapelle-Straße"
    end

  end
  
  describe "use fetch address to save foreign attributes" do
    let(:user){ User.create!(name: "Some User") }
    # let(:address){ MagicAddresses::Address.create!(name: "Another", owner: user) }
    let(:address){ user.build_address(name: "Another") }
    
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
    
    let(:user){ User.create!(name: "Some User", address_attributes: { street: "Heinz-Kapelle-Str.", number: "6", postalcode: 10407, city: "Berlin", country:"Germany"}) }
    # let(:address){ MagicAddresses::Address.create!(name: "Another", owner: user) }
    let(:address){ 
      user.address
    }
    
    it "save country attributes first in fetch_address" do
      I18n.locale = :en
      #  expect( address.fetch_address ).to eq( {} )
      #  address.street = "Heinz-Kapelle-Str."
      #  address.number = "6"
      #  address.postalcode = 10407
      #  address.city = "Berlin"
      #  address.country = "Germany"
      #  
      #  # there should be no associations if no address yet 
      #  expect( MagicAddresses::Country.all.count ).to eq( 0 )
      #  expect( MagicAddresses::State.all.count ).to eq( 0 )
      #  expect( MagicAddresses::City.all.count ).to eq( 0 )
      #  expect( MagicAddresses::District.all.count ).to eq( 0 )
      #  expect( MagicAddresses::Subdistrict.all.count ).to eq( 0 )
      #  
      #  # fetch_address should be set
      #expect( address.fetch_address ).to eq( { "fetch_street" => "Heinz-Kapelle-Str.", "fetch_number" => "6", "fetch_zipcode" => 10407, "fetch_city" => "Berlin", "fetch_country" => "Germany" } )
      #expect( user.address.fetch_address ).to eq( { "fetch_street" => "Heinz-Kapelle-Str.", "fetch_number" => "6", "fetch_zipcode" => 10407, "fetch_city" => "Berlin", "fetch_country" => "Germany" } )
      #  
      #  # address.save
      #  user.save
      
      puts address.inspect
      
      
      # sleep 2
      
      user = User.first
      
      # fetch_address should be emty again
      # expect( address.fetch_address ).to eq( {} )
      
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
      
      puts "address: #{ address.translations.map{ |x| "#{x.locale} = #{x.street_name}"}.join(", ") }"
      puts "State: #{ MagicAddresses::State.first.translations.map{ |x| "#{x.locale} = #{x.name}"}.join(", ") }"
      puts "City: #{ MagicAddresses::City.first.translations.map{ |x| "#{x.locale} = #{x.name}"}.join(", ") }"
      puts "District: #{ MagicAddresses::District.first.translations.map{ |x| "#{x.locale} = #{x.name}"}.join(", ") }"
      puts "Subdistrict: #{ MagicAddresses::Subdistrict.first.translations.map{ |x| "#{x.locale} = #{x.name}"}.join(", ") }"
      
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
      
      # check has_one through connection
      expect( address.magic_subdistrict.country.name ).to eq( "Germany" )
      expect( address.magic_district.country.name ).to eq( "Germany" )
      
    end
    
  end
  
  
  
  # => describe 'attribute changes' do
  # =>   before(:each) do
  # =>     @address = MagicAddresses::Address.new( )
  # =>   end
  # =>   
  # =>   it 'saves address childs correct' do
  # =>     expect( MagicAddresses::Country.count ).to eq 0
  # =>     expect( MagicAddresses::State.count ).to eq 0
  # =>     expect( MagicAddresses::City.count ).to eq 0
  # =>     expect( MagicAddresses::District.count ).to eq 0
  # =>     expect( MagicAddresses::Subdistrict.count ).to eq 0
  # =>     
  # =>     # expect( I18n.available_locales.count ).to eq 2
  # =>     expect( I18n::available_locales.count ).to eq 2
  # =>     
  # =>     @address.street = "Heinz-Kapelle-Str."
  # =>     @address.number = 6
  # =>     @address.postalcode = 10407
  # =>     @address.city = "Berlin"
  # =>     
  # =>     # puts @address.translations_attributes.to_yaml
  # =>     
  # =>     
  # =>     @address.save
  # =>     
  # =>     expect( MagicAddresses::Country.count ).to eq 1
  # =>     expect( MagicAddresses::State.count ).to eq 1
  # =>     expect( MagicAddresses::City.count ).to eq 1
  # =>     expect( MagicAddresses::District.count ).to eq 1
  # =>     expect( MagicAddresses::Subdistrict.count ).to eq 1
  # =>     
  # =>     # trigger background task
  # =>     # @address.build_association_translations
  # =>     
  # =>     expect( @address.magic_city.read_attribute(:name, locale: :en)  ).to eq ("Berlin")
  # =>     
  # =>     expect( @address.magic_subdistrict.read_attribute(:name, locale: :en)  ).to eq ("Prenzlauer Berg")
  # =>     expect( @address.magic_district.read_attribute(:name, locale: :en)  ).to eq ("Bezirk Pankow")
  # =>     
  # =>     expect( @address.magic_country.read_attribute(:name, locale: :en)  ).to eq ("Germany")
  # =>     expect( @address.magic_country.read_attribute(:name, locale: :de)  ).to eq ("Deutschland")
  # =>     
  # =>     expect( @address.street_number ).to eq ("6")
  # =>     
  # =>     # expect( @address.translations.count ).to eq 3
  # =>     # new model only saves stuff when different than english!
  # =>     expect( @address.translations.count ).to eq 1
  # =>     
  # =>     # puts @address.translations.map{ |t| "'#{t.street}'"}
  # =>     
  # =>     Rails.application.config.i18n.fallbacks = true
  # =>     expect( @address.read_attribute(:street_name, locale: :en)  ).to eq ("Heinz-Kapelle-Straße")
  # =>     expect( @address.read_attribute(:street_name, locale: :de)  ).to eq ("Heinz-Kapelle-Straße")
  # =>     
  # =>   end
  # =>   
  # =>   it 'saves street languages correct' do
  # =>     I18n.locale = "de"
  # =>     @address.street = "Sesam Str."
  # =>     I18n.locale = "en"
  # =>     @address.street = "Sesamstreet"
  # =>     @address.save
  # =>     
  # =>     expect( @address.read_attribute(:street_name, locale: :en)  ).to eq ("Sesamstreet")
  # =>     expect( @address.read_attribute(:street_name, locale: :de)  ).to eq ("Sesam Str.")
  # =>   end
  # =>   
  # =>   # => it 'saves from values correct', sidekiq: :fake do
  # =>   # =>   @address.street = "Heinz-Kapelle-Str."
  # =>   # =>   @address.number = "6"
  # =>   # =>   @address.city = "Berlin"
  # =>   # =>   @address.postalcode = "10407"
  # =>   # =>   @address.country = "Deutschland"
  # =>   # =>   expect( MagicAddresses::AddressWorker.jobs.size ).to eq 0
  # =>   # =>   # => expect {
  # =>   # =>   # =>   @address.save
  # =>   # =>   # =>   sleep 1
  # =>   # =>   # => }.to change(MagicAddresses::AddressWorker.jobs, :size).by(1)
  # =>   # =>   expect( MagicAddresses::AddressWorker ).to receive(:perform_async).with( 1 )
  # =>   # =>   @address.save
  # =>   # =>   # expect( MagicAddresses::AddressWorker.jobs.size ).to eq 1
  # =>   # =>   # MagicAddresses::AddressWorker.should have_queued_job(1)
  # =>   # =>   # => expect(MagicAddresses::AddressWorker).to have_enqueued_job( @address.id )
  # =>   # =>   #expect(MagicAddresses::AddressWorker).to have_enqueued_job( @address.id, true )
  # =>   # =>   # MagicAddresses::AddressWorker.should_receive(:perform_async).with( @address.id )
  # =>   # =>   expect( @address.fetch_address ).to eq ("Heinz-Kapelle-Str. 6 Berlin 10407 Deutschland")
  # =>   # =>   # trigger background task
  # =>   # =>   @address.build_association_translations
  # =>   # =>   expect( @address.city.read_attribute(:name, locale: :en)  ).to eq ("Berlin")
  # =>   # =>   expect( @address.subdistrict.read_attribute(:name, locale: :en)  ).to eq ("Prenzlauer Berg")
  # =>   # =>   expect( @address.district.read_attribute(:name, locale: :en)  ).to eq ("Bezirk Pankow")
  # =>   # =>   expect( @address.country.read_attribute(:name, locale: :en)  ).to eq ("Germany")
  # =>   # =>   expect( @address.country.read_attribute(:name, locale: :de)  ).to eq ("Deutschland")
  # =>   # => end
  # =>   
  # =>   
  # =>   it 'saves right connections' do
  # =>     
  # =>     expect( MagicAddresses::Country.count ).to eq 0
  # =>     expect( MagicAddresses::State.count ).to eq 0
  # =>     expect( MagicAddresses::City.count ).to eq 0
  # =>     expect( MagicAddresses::District.count ).to eq 0
  # =>     expect( MagicAddresses::Subdistrict.count ).to eq 0
  # =>     
  # =>     @address.street = "Heinz-Kapelle-Str."
  # =>     @address.number = 6
  # =>     @address.postalcode = 10407
  # =>     @address.city = "Berlin"
  # =>     
  # =>     @address.save
  # =>     sleep 0.3
  # =>     # trigger background task
  # =>     # @address.build_association_translations
  # =>     
  # =>     @address2 = MagicAddresses::Address.new( )
  # =>     @address2.street = "Grünbergerstr."
  # =>     @address2.number = 60
  # =>     @address2.postalcode = 10245
  # =>     @address2.city = "Berlin"
  # =>     @address2.save
  # =>     sleep 0.3
  # =>     # trigger background task
  # =>     # @address2.build_association_translations
  # =>     
  # =>     @address3 = MagicAddresses::Address.new( )
  # =>     @address3.street = "Josef-orlopp-str."
  # =>     @address3.number = 54
  # =>     @address3.postalcode = 10365
  # =>     @address3.city = "Berlin"
  # =>     @address3.save
  # =>     sleep 0.3
  # =>     # trigger background task
  # =>     # @address3.build_association_translations
  # =>     
  # =>     sleep 1
  # =>     
  # =>     expect( MagicAddresses::Country.count ).to eq 1
  # =>     expect( MagicAddresses::State.count ).to eq 1
  # =>     expect( MagicAddresses::City.count ).to eq 1
  # =>     expect( MagicAddresses::District.count ).to eq 3
  # =>     expect( MagicAddresses::Subdistrict.count ).to eq 3
  # =>     
  # =>     
  # =>     expect( MagicAddresses::City.first.name ).to eq "Berlin"
  # =>     
  # =>     # only save translation when different to "en"
  # =>     # de: "Berlin"
  # =>     # en: "Berlin"
  # =>     # it: "Berlino"
  # =>     expect( MagicAddresses::City.first.translations.count ).to eq 1
  # =>     
  # =>     expect( @address.translations.count ).to eq 1
  # =>     expect( @address2.translations.count ).to eq 1
  # =>     expect( @address3.translations.count ).to eq 1
  # =>     I18n.locale = "de"
  # =>     expect(  @address.city ).to eq "Berlin"
  # =>     expect( @address2.city ).to eq "Berlin"
  # =>     expect( @address3.city ).to eq "Berlin"
  # =>     I18n.locale = "en"
  # =>     expect(  @address.city ).to eq "Berlin"
  # =>     expect( @address2.city ).to eq "Berlin"
  # =>     expect( @address3.city ).to eq "Berlin"
  # =>   end
  # =>   
  # =>   
  # => end
  
  
end
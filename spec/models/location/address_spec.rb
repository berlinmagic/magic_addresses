require 'spec_helper'

describe Location::Address do
  
  describe 'should have usual attributes' do
    it { should respond_to :name }
    
    it { should respond_to :street_default }
    
    it { should respond_to :street }
    
    it { should respond_to :translations }
    # it { should respond_to :translations_attributes }
    
    it { should respond_to :street_number }
    it { should respond_to :street_additional }
    it { should respond_to :zipcode }
    
    it { should respond_to :city }
    it { should respond_to :subcity }
    it { should respond_to :state }
    it { should respond_to :country }
    
    it { should respond_to :latitude }
    it { should respond_to :longitude }
    
    it { should respond_to :visibility }
    it { should respond_to :default }
    
    it { should respond_to :owner }
  end
  
  # => describe 'validations' do 
  # =>   it { should validate_presence_of :city }
  # => end

  describe 'attribute changes' do
    before(:each) do
      # Wizard::Locale.where(iso_code: "en").first.do_transition!( :activate )
      # Wizard::Locale.where(iso_code: "de").first.do_transition!( :activate )
      # I18n.available_locales.each do |lc|
      [:en, :de, :it].each do |lc|
        Wizard::Locale.create!(iso_code: lc.to_s, locale_state: "active")
      end
      @address = Location::Address.new( )
    end
    
    it 'saves address childs correct' do
      expect( Location::Country.count ).to eq 0
      expect( Location::State.count ).to eq 0
      expect( Location::City.count ).to eq 0
      expect( Location::Subcity.count ).to eq 0
      expect( Location::Subsubcity.count ).to eq 0
      
      # expect( I18n.available_locales.count ).to eq 2
      expect( ::Wizard::Locale.count ).to eq 3
      
      @address.address = "Heinz-Kapelle-Str. 6 10407 Berlin"
      
      # puts @address.translations_attributes.to_yaml
      
      expect( @address.street ).to be nil
      
      @address.save
      
      expect( Location::Country.count ).to eq 1
      expect( Location::State.count ).to eq 1
      expect( Location::City.count ).to eq 1
      expect( Location::Subcity.count ).to eq 1
      expect( Location::Subsubcity.count ).to eq 1
      
      # trigger background task
      @address.build_association_translations
      
      expect( @address.city.name(:en) ).to eq ("Berlin")
      expect( @address.city.name(:it) ).to eq ("Berlino")
      
      expect( @address.subsubcity.name(:en) ).to eq ("Prenzlauer Berg")
      expect( @address.subcity.name(:en) ).to eq ("Pankow")
      
      expect( @address.country.name(:en) ).to eq ("Germany")
      expect( @address.country.name(:de) ).to eq ("Deutschland")
      
      expect( @address.street_number ).to eq ("6")
      
      # expect( @address.translations.count ).to eq 3
      # new model only saves stuff when different than english!
      expect( @address.translations.count ).to eq 1
      
      # puts @address.translations.map{ |t| "'#{t.street}'"}
      
      Rails.application.config.i18n.fallbacks = true
      expect( @address.street(:en) ).to eq ("Heinz-Kapelle-Straße")
      expect( @address.street(:de) ).to eq ("Heinz-Kapelle-Straße")
      
    end
    
    it 'saves street languages correct' do
      I18n.locale = "de"
      @address.street = "Sesam Str."
      I18n.locale = "en"
      @address.street = "Sesamstreet"
      @address.save
      
      expect( @address.street(:en) ).to eq ("Sesamstreet")
      expect( @address.street(:de) ).to eq ("Sesam Str.")
    end
    
    it 'saves from values correct', sidekiq: :fake do
      @address.street_name = "Heinz-Kapelle-Str."
      @address.street_number = "6"
      @address.city_name = "Berlin"
      @address.zipcode = "10407"
      @address.country_name = "Deutschland"
      
      
      expect( AddressWorker.jobs.size ).to eq 0
      
      # => expect {
      # =>   @address.save
      # =>   sleep 1
      # => }.to change(AddressWorker.jobs, :size).by(1)
      
      expect( AddressWorker ).to receive(:perform_async).with( 1 )
      @address.save
      
      # expect( AddressWorker.jobs.size ).to eq 1
      
      # AddressWorker.should have_queued_job(1)
      
      # => expect(AddressWorker).to have_enqueued_job( @address.id )
      #expect(AddressWorker).to have_enqueued_job( @address.id, true )
      # AddressWorker.should_receive(:perform_async).with( @address.id )
      
      
      
      
      expect( @address.fetch_address ).to eq ("Heinz-Kapelle-Str. 6 Berlin 10407 Deutschland")
      
      # trigger background task
      @address.build_association_translations
      
      expect( @address.city.name(:en) ).to eq ("Berlin")
      expect( @address.city.name(:it) ).to eq ("Berlino")
      
      expect( @address.subsubcity.name(:en) ).to eq ("Prenzlauer Berg")
      expect( @address.subcity.name(:en) ).to eq ("Pankow")
      
      expect( @address.country.name(:en) ).to eq ("Germany")
      expect( @address.country.name(:de) ).to eq ("Deutschland")
      
    end
    
    
    it 'saves right connections' do
      
      expect( Location::Country.count ).to eq 0
      expect( Location::State.count ).to eq 0
      expect( Location::City.count ).to eq 0
      expect( Location::Subcity.count ).to eq 0
      expect( Location::Subsubcity.count ).to eq 0
      
      @address.address = "Heinz-Kapelle-Str. 6 10407 Berlin DE"
      @address.save
      sleep 1
      # trigger background task
      @address.build_association_translations
      
      @address2 = Location::Address.new( )
      @address2.address = "Grünbergerstr. 60 10245 berlin DE"
      @address2.save
      sleep 1
      # trigger background task
      @address2.build_association_translations
      
      @address3 = Location::Address.new( )
      @address3.address = "Josef-orlopp-str. 54 Berlin 10365 DE"
      @address3.save
      sleep 1
      # trigger background task
      @address3.build_association_translations
      
      expect( Location::Country.count ).to eq 1
      expect( Location::State.count ).to eq 1
      expect( Location::City.count ).to eq 1
      expect( Location::Subcity.count ).to eq 3
      expect( Location::Subsubcity.count ).to eq 3
      
      
      expect( Location::City.first.name ).to eq "Berlin"
      
      # only save translation when different to "en"
      # de: "Berlin"
      # en: "Berlin"
      # it: "Berlino"
      expect( Location::City.first.translations.count ).to eq 2
      
      expect( @address.translations.count ).to eq 1
      expect( @address2.translations.count ).to eq 1
      expect( @address3.translations.count ).to eq 1
      
      I18n.locale = "de"
      
      expect(  @address.city! ).to eq "Berlin"
      expect( @address2.city! ).to eq "Berlin"
      expect( @address3.city! ).to eq "Berlin"
      
      I18n.locale = "en"
      
      expect(  @address.city! ).to eq "Berlin"
      expect( @address2.city! ).to eq "Berlin"
      expect( @address3.city! ).to eq "Berlin"
      
      I18n.locale = "it"
      
      expect(  @address.city! ).to eq "Berlino"
      expect( @address2.city! ).to eq "Berlino"
      expect( @address3.city! ).to eq "Berlino"
      
      
    end
    
    
  end
  
end

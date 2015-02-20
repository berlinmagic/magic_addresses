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


    it "add address attributes only if asked for" do
      expect( address.fetch_address ).to be {}
      address.street = "Heinz-Kapelle-Str."
      expect( address.fetch_address ).equal? Hash.new({ :fetch_street => "Heinz-Kapelle-Str." })
      expect( address.street ).equal? "Heinz-Kapelle-Str."
      expect( address.fetch_street ).equal? "Heinz-Kapelle-Str."
      expect( address.street_name ).equal? "Heinz-Kapelle-Str."
    end

  end
  
end
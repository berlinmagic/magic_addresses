require 'rails_helper'

RSpec.describe Customer, type: :model do
  
  describe 'should have default attributes' do
    it { should respond_to :name }
  end
  
  describe 'should have MagicAddresses attributes' do
    
    it { should     respond_to :invoice_address }
    it { should     respond_to :delivery_address }
    
    it 'doesn`t change address for multiple customers' do
      @that = Customer.create!( name: "Acme", invoice_address_addressible_attributes: {invoice_address_attributes: {street: "Reinhardtstraße", number: "9", postalcode: "10117", city: "Berlin", country: "Germany"}} )
      # @that.address.trigger_build_address_associations
      # sleep 4
      @that = @that.reload
      expect( @that.invoice_address ).not_to eql( nil )
      expect( @that.invoice_address.street ).to eql( "Reinhardtstraße" )
      expect( @that.invoice_address.longitude ).not_to eql( nil )
      
      @this = Customer.create!( name: "Apple", invoice_address_addressible_attributes: {invoice_address_attributes: {street: "Reinhardtstraße", number: "9", postalcode: "10117", city: "Berlin", country: "Germany"}} )
      
      @this = @this.reload
      expect( @this.invoice_address ).not_to eql( nil )
      expect( @this.invoice_address.street ).to eql( "Reinhardtstraße" )
      expect( @this.invoice_address.longitude ).not_to eql( nil )
      
      puts "#####"
      
      @that.update( invoice_address_addressible_attributes: {invoice_address_attributes: {street: "Reinhardtstraße", number: "7", postalcode: "10117", city: "Berlin", country: "Germany"}} )
      
      @that = @that.reload
      @this = @this.reload
      
      expect( @that.invoice_address.id ).not_to eql( @this.invoice_address.id )
      expect( @that.invoice_address.number ).not_to eql( @this.invoice_address.number )
      expect( @that.invoice_address.number ).to eql( "7" )
      expect( @this.invoice_address.number ).to eql( "9" )
      
    end
    
    
    it 'has multiple named address' do
      @that = Customer.create!( name: "Acme", invoice_address_attributes: {street: "Reinhardtstraße", number: "9", postalcode: "10117", city: "Berlin", country: "Germany"}, delivery_address_attributes: {street: "Reinhardtstraße", number: "11", postalcode: "10117", city: "Berlin", country: "Germany"} )
      # @that.address.trigger_build_address_associations
      # sleep 4
      @that = @that.reload
      expect( @that.invoice_address ).not_to eql( nil )
      expect( @that.delivery_address ).not_to eql( nil )
      expect( @that.invoice_address.street ).to eql( "Reinhardtstraße" )
      expect( @that.delivery_address.street ).to eql( "Reinhardtstraße" )
      expect( @that.invoice_address.longitude ).not_to eql( nil )
      
      expect( @that.invoice_address.number ).to eql( "9" )
      expect( @that.delivery_address.number ).to eql( "11" )
      
    end
    
    # , focus: true
    
    it 'has multiple named addresses amnd default address' do
      @that = Customer.create!( name: "Acme", invoice_address_attributes: {street: "Reinhardtstr.", number: "9", postalcode: "10117", city: "Berlin", country: "Germany"}, delivery_address_attributes: {street: "Bornholmerstr.", number: "90", postalcode: "10439", city: "Berlin", country: "Germany"}, address_attributes: {street: "Grünbergerstr.", number: "60", postalcode: "10245", city: "Berlin", country: "Germany"} )
      # @that.address.trigger_build_address_associations
      # sleep 4
      # @that = @that.reload
      @that = Customer.first
      
      expect( @that.invoice_address ).not_to eql( nil )
      expect( @that.delivery_address ).not_to eql( nil )
      expect( @that.address ).not_to eql( nil )
      
      # puts "invoice_address:"
      # puts @that.invoice_address.inspect
      # puts @that.invoice_address.translations.inspect
      # puts MagicAddresses::Address.find(1).translations.inspect
      # puts "delivery_address:"
      # puts @that.delivery_address.inspect
      # puts "address:"
      # puts @that.address.inspect
      
      expect( @that.invoice_address.street ).to eql( "Reinhardtstraße" )
      expect( @that.delivery_address.street ).to eql( "Bornholmer Straße" )
      expect( @that.address.street ).to eql( "Grünberger Straße" )
      
      expect( @that.invoice_address.longitude ).not_to eql( nil )
      expect( @that.delivery_address.longitude ).not_to eql( nil )
      expect( @that.address.longitude ).not_to eql( nil )
      
      expect( @that.invoice_address.number ).to eql( "9" )
      expect( @that.delivery_address.number ).to eql( "90" )
      expect( @that.address.number ).to eql( "60" )
      
    end
    
  end
  
  
  
  
end

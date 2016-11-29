require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'should have default attributes' do
    it { should respond_to :name }
  end
  
  describe 'should not have MagicAddresses attributes' do
    
    it { should_not respond_to :addresses }
    it { should     respond_to :address }
    
  end
  
  it "not saves the same address twice" do
    
    addr = { street: "Heinz-Kapelle-Str.", number: "6", postalcode: "10407", city: "Berlin"}
    usr1 = { name: "tom", address_attributes: addr }
    usr2 = { name: "tim", address_attributes: addr }
    
    u1 = User.create!( usr1 )
    u2 = User.create!( usr2 )
    
    expect( User.all.count ).to eq 2
    expect( MagicAddresses::Address.all.count ).to eq 1
    
    u1 = User.find_by( name: "tom" )
    u2 = User.find_by( name: "tim" )
    
    expect( u1.address.id ).to eq MagicAddresses::Address.first.id
    expect( u2.address.id ).to eq MagicAddresses::Address.first.id
    
    expect( u1.address.id ).to eq u2.address.id
    
  end
  
  
  it "does not change address for other owners" do
    
    addr = { street: "Heinz-Kapelle-Str.", number: "6", postalcode: "10407", city: "Berlin"}
    usr1 = { name: "tom", address_attributes: addr }
    usr2 = { name: "tim", address_attributes: addr }
    
    u1 = User.create!( usr1 )
    u2 = User.create!( usr2 )
    
    # sleep 3
    
    expect( User.all.count ).to eq 2
    expect( MagicAddresses::Address.all.count ).to eq 1
    
    u1 = User.find_by( name: "tom" )
    u2 = User.find_by( name: "tim" )
    
    u2.update( address_attributes: addr.merge({ number: 8 }) )
    
    expect( MagicAddresses::Address.all.count ).to eq 2
    expect( MagicAddresses::Addressible.where(default: true).count ).to eq 2
    
    expect( u1.address.id ).to eq MagicAddresses::Address.first.id
    expect( u2.address.id ).to eq MagicAddresses::Address.last.id
    
    expect( u1.address.id ).not_to eq u2.address.id
    
  end
  
  
  it "does not change address for other owners" do
    
    addr = { street: "Heinz-Kapelle-Str.", number: "6", postalcode: "10407", city: "Berlin"}
    usr1 = { name: "tom", addressible_attributes: {address_attributes: addr} }
    usr2 = { name: "tim", addressible_attributes: {address_attributes: addr} }
    
    u1 = User.create!( usr1 )
    u2 = User.create!( usr2 )
    
    # sleep 3
    
    expect( User.all.count ).to eq 2
    expect( MagicAddresses::Address.all.count ).to eq 1
    
    u1 = User.find_by( name: "tom" )
    u2 = User.find_by( name: "tim" )
    
    u2.update( addressible_attributes: { address_attributes: addr.merge({ number: 8 }) } )
    
    expect( u1.address.id ).to eq MagicAddresses::Address.first.id
    expect( u2.address.id ).to eq MagicAddresses::Address.last.id
    
    expect( u1.address.id ).not_to eq u2.address.id
    
  end
  
  
  it "does not save address without changes" do
    addr = { street: "Heinz-Kapelle-Str.", number: "6", postalcode: "10407", city: "Berlin"}
    usr1 = { name: "tom", address_attributes: addr }
    usr2 = { name: "tim", addressible_attributes: {address_attributes: addr} }
    
    u1 = User.create!( usr1 )
    u2 = User.create!( usr2 )
    
    expect( User.all.count ).to eq 2
    expect( MagicAddresses::Address.all.count ).to eq 1
    
    u1 = User.find_by( name: "tom" )
    u2 = User.find_by( name: "tim" )
    
    u2.update( addressible_attributes: { id: u2.addressible.id, address_attributes: addr.merge({ id: u2.address.id, number: "4" }) } )
    
    expect( u1.address.id ).to eq MagicAddresses::Address.first.id
    expect( u2.address.id ).to eq MagicAddresses::Address.last.id
    
    expect( u1.address.id ).not_to eq u2.address.id
    
  end
  
  it "does not update address without changes" do
    addr = { street: "Heinz-Kapelle-Str.", number: "6", postalcode: "10407", city: "Berlin"}
    usr1 = { name: "tom", address_attributes: addr }
    usr2 = { name: "tim", addressible_attributes: {address_attributes: addr} }
    
    u1 = User.create!( usr1 )
    u2 = User.create!( usr2 )
    
    expect( User.all.count ).to eq 2
    expect( MagicAddresses::Address.all.count ).to eq 1
    
    u1 = User.find_by( name: "tom" )
    u2 = User.find_by( name: "tim" )
    
    u1.update( address_attributes: addr.merge({ id: u1.address.id }) )
    u2.update( addressible_attributes: { id: u2.addressible.id, address_attributes: addr.merge({ id: u2.address.id }) } )
    
    expect( MagicAddresses::Address.all.count ).to eq 1
    
    expect( u1.address.id ).to eq MagicAddresses::Address.first.id
    expect( u2.address.id ).to eq MagicAddresses::Address.first.id
    
  end
  
  describe "(magic) Address" do
    it { should respond_to :addressible }
    it { should respond_to :address }
    it 'creates address magic' do
      @that = User.create!( name: "Acme" )
      # @that = User.create!( name: "Acme", address_attributes: {street: "Reinhardtstraße", number: "9", postalcode: "10117", city: "Berlin", country: "Germany"} )
      # @that.build_address( {street: "Reinhardtstraße", number: "9", postalcode: "10117", city: "Berlin", country: "Germany"} )
      @that.address = MagicAddresses::Address.create( street: "Reinhardtstraße", number: "9", postalcode: "10117", city: "Berlin", country: "Germany" )
      @that.save
      @that.address.trigger_build_address_associations
      # sleep 2
      @that = User.last
      expect( @that.address ).not_to eql( nil )
      expect( @that.address.street ).to eql( "Reinhardtstraße" )
      expect( @that.address.longitude ).not_to eql( nil )
    end
    
    it 'doesn`t change address for multiple companies' do
      @that = User.create!( name: "Acme", addressible_attributes: {address_attributes: {street: "Reinhardtstraße", number: "9", postalcode: "10117", city: "Berlin", country: "Germany"}} )
      # @that.address.trigger_build_address_associations
      # sleep 4
      @that = @that.reload
      expect( @that.address ).not_to eql( nil )
      expect( @that.address.street ).to eql( "Reinhardtstraße" )
      expect( @that.address.longitude ).not_to eql( nil )
      
      @this = User.create!( name: "Apple", addressible_attributes: {address_attributes: {street: "Reinhardtstraße", number: "9", postalcode: "10117", city: "Berlin", country: "Germany"}} )
      
      @this = @this.reload
      # @this.address.trigger_build_address_associations
      # sleep 2
      @this = @this.reload
      expect( @this.address ).not_to eql( nil )
      expect( @this.address.street ).to eql( "Reinhardtstraße" )
      expect( @this.address.longitude ).not_to eql( nil )
      
      puts "#####"
      
      # => @that.address.street = "Reinhardtstraße"
      # => @that.address.number = "7"
      # => @that.address.postalcode = "10117"
      # => @that.address.city = "Berlin"
      # => @that.save
      
      @that.update( addressible_attributes: {address_attributes: {street: "Reinhardtstraße", number: "7", postalcode: "10117", city: "Berlin", country: "Germany"}} )
      
      @that = @that.reload
      @this = @this.reload
      
      expect( @that.address.id ).not_to eql( @this.address.id )
      expect( @that.address.number ).not_to eql( @this.address.number )
      expect( @that.address.number ).to eql( "7" )
      expect( @this.address.number ).to eql( "9" )
      
    end
      
  end
  
end

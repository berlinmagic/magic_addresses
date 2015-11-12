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
    
  end
  
end

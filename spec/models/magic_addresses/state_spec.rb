require 'rails_helper'


describe MagicAddresses::State do
  
  describe 'should have usual attributes' do
    
    # globalize
    it { should respond_to :name }
    it { should respond_to :read_attribute }
    it { should accept_nested_attributes_for :translations }
    
    # address
    it { should respond_to :addresses }
    it { should have_many  :addresses }
    
    
  end
  
  
end
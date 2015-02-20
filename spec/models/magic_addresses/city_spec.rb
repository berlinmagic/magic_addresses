require 'rails_helper'


describe MagicAddresses::City do
  
  describe 'should have usual attributes' do
    
    # globalize
    it { should respond_to :name }
    it { should respond_to :read_attribute }
    it { should accept_nested_attributes_for :translations }
    
    # address
    it { should respond_to :addresses }
    it { should have_many  :addresses }
    
    # more
    it { should respond_to :country }
    it { should belong_to  :country }
    it { should respond_to :state }
    it { should belong_to  :state }
    
  end
  
  
end
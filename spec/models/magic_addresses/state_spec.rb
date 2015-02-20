require 'rails_helper'


describe MagicAddresses::State do
  
  describe 'should have usual attributes' do
    
    # usual
    it { should respond_to :default_name }
    it { should respond_to :short_name }
    it { should respond_to :fsm_state }
    
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
    
  end
  
  
end
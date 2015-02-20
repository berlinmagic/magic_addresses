require 'rails_helper'


describe MagicAddresses::Country do
  
  describe 'should have usual attributes' do
    
    # usual
    it { should respond_to :default_name }
    it { should respond_to :iso_code }
    it { should respond_to :dial_code }
    it { should respond_to :fsm_state }
    
    # globalize
    it { should respond_to :name }
    it { should respond_to :read_attribute }
    it { should accept_nested_attributes_for :translations }
    
    # address
    it { should respond_to :addresses }
    it { should have_many  :addresses }
    
    
  end
  
  
end
require 'spec_helper'

describe Location::City do
  
  describe 'should have usual attributes' do
    
    it { should respond_to :name_default }
    it { should respond_to :name }
    
    it { should respond_to :fsm_state }
    
    it { should respond_to :state }
    it { should respond_to :country }
    
    it { should respond_to :addresses }
    
    it { should respond_to :translations }
    # it { should respond_to :translations_attributes }
    
  end
  
  # => describe 'validations' do 
  # =>   it { should validate_presence_of :city }
  # => end
  
end

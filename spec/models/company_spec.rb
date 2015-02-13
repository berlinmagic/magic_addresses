require 'rails_helper'

RSpec.describe Company, type: :model do
  
  describe 'should have default attributes' do
    it { should respond_to :name }
  end
  
  describe 'should have MagicAddresses attributes' do
    
    it { should respond_to :addresses }
    it { should accept_nested_attributes_for :addresses }
    
  end
  
end

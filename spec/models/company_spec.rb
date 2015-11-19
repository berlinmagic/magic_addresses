require 'rails_helper'

RSpec.describe Company, type: :model do
  
  describe 'should have default attributes' do
    it { should respond_to :name }
  end
  
  describe 'should not have MagicAddresses attributes' do
    
    it { should_not respond_to :address }
    it { should     respond_to :addresses }
    
  end
  
  
end

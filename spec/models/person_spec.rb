require 'rails_helper'

RSpec.describe Person, type: :model do
  
  describe 'should have default attributes' do
    it { should respond_to :name }
  end
  
  
  
end

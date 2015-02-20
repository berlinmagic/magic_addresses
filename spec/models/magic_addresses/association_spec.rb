require 'spec_helper'

describe MagicAddresses::Association do
  class TestPerson < ActiveRecord::Base
    self.table_name = "users"
    has_one_address
  end

  class TestUser < ActiveRecord::Base
    self.table_name = "users"
  end
  
  class TestDude < ActiveRecord::Base
    self.table_name = "users"
    has_addresses
  end

  describe "has some kind of address => inherit methods" do

    let(:micha){ TestPerson.create!(name: "Micha Schmidt") }
    let(:ingo){ TestUser.create!(name: "Ingo Mueller") }
    let(:dude){ TestDude.create!(name: "The Dude") }


    it "add address attributes only if asked for" do
      expect( micha.respond_to?(:address) ).to be true
      expect( ingo.respond_to?(:address) ).to be false
      expect( dude.respond_to?(:address) ).to be false
      
      expect( micha.respond_to?(:addresses) ).to be false
      expect( ingo.respond_to?(:addresses) ).to be false
      expect( dude.respond_to?(:addresses) ).to be true
    end

  end

end

require 'spec_helper'

describe MagicAddresses::Association do
  
  
  class TestPerson < ActiveRecord::Base
    self.table_name = "users"
    has_nested_address
  end

  class TestUser < ActiveRecord::Base
    self.table_name = "users"
    has_one_address
  end
  
  class TestDude < ActiveRecord::Base
    self.table_name = "users"
    has_addresses
  end
  
  class TestGuy < ActiveRecord::Base
    self.table_name = "users"
  end

  describe "has some kind of address => inherit methods" do

    let(:person){ TestPerson.create!( name: "Bud Spencer"   ) }
    let(:user){   TestUser.create!(   name: "Terence Hill"  ) }
    let(:dude){   TestDude.create!(   name: "The Dude"      ) }
    let(:guy){    TestGuy.create!(    name: "Some Guy"      ) }


    it "add address attributes only if asked for" do
      expect( person.respond_to?(:address) ).to be true
      expect( user.respond_to?(:address) ).to be true
      expect( dude.respond_to?(:address) ).to be false
      expect( guy.respond_to?(:address) ).to be false
      
      expect( person.respond_to?(:addresses) ).to be false
      expect( user.respond_to?(:addresses) ).to be false
      expect( dude.respond_to?(:addresses) ).to be true
      expect( guy.respond_to?(:addresses) ).to be false
    end

  end
  
  describe "has_one_address => inherit methods" do

    let(:micha){ TestPerson.create!(name: "Micha Schmidt") }

    let(:ingo){ TestGuy.create!(name: "Ingo Mueller") }

    # => it "add address attributes" do
    # =>   expect( micha.respond_to?(:address) ).to be true
    # =>   expect( micha.address.new_record? ).to be true
    # =>   micha.street = "BornholmerStr"
    # =>   micha.city = "Berlin"
    # =>   micha.save
    # =>   expect( micha.address.new_record? ).to be false
    # =>   expect( micha.street ).to eql "BornholmerStr"
    # =>   expect( micha.address.street ).to eql "BornholmerStr"
    # =>   expect( micha.city ).to eql "Berlin"
    # => end

    it "add address attributes only if asked for" do
      expect( micha.respond_to?(:address) ).to be true
      expect( ingo.respond_to?(:address) ).to be false
    end

  end

  # Stack level too deep ???
  # => describe "saves address attributes" do
  # =>   class TestTheUser < ActiveRecord::Base
  # =>     self.table_name = "users"
  # =>     has_nested_address
  # =>   end
  # => 
  # =>   # class TestTheCompany < ActiveRecord::Base
  # =>   #   self.table_name = "companies"
  # =>   #   has_one_address
  # =>   # end
  # => 
  # =>    let(:user){ TestTheUser.create!(name: "Ingo Mueller") }
  # =>    # let(:company){ TestTheCompany.create!( name: "Mueller Inc." ) }
  # => 
  # =>    it "save as own attributes" do
  # =>      user.street = "BornholmerStr."
  # =>      user.number = "84"
  # =>      user.postalcode = "10439"
  # =>      user.city = "Berlin"
  # =>      expect( user.valid? ).to eq true
  # =>      user.save
  # =>      expect( user.street ).to eq "BornholmerStr."
  # =>      expect( user.address.street ).to eq "BornholmerStr."
  # =>      expect( user.number ).to eq "84"
  # =>      expect( user.address.number ).to eq "84"
  # =>      expect( user.postalcode ).to eq "10439"
  # =>      expect( user.address.postalcode ).to eq "10439"
  # =>      expect( user.city).to eq "Berlin"
  # =>      expect( user.address.city ).to eq "Berlin"
  # =>    end
  # => 
  # =>    it "save as child attributes" do
  # =>      expect( user.valid? ).to eq true
  # =>      addr = { street: "Grünberger Str", number: 50, postalcode: 10245, city: "Berlin", country: "Germany" }
  # => 
  # =>      user.address_attributes = addr
  # =>      expect( user.valid? ).to eq true
  # => 
  # =>      expect( user.street ).to eq addr[:street]
  # =>      expect( user.address.street ).to eq addr[:street]
  # =>      expect( user.number ).to eq addr[:number]
  # =>      expect( user.address.number ).to eq addr[:number]
  # =>      expect( user.postalcode ).to eq addr[:postalcode]
  # =>      expect( user.address.postalcode ).to eq addr[:postalcode]
  # =>      expect( user.city ).to eq addr[:city]
  # =>      expect( user.address.city ).to eq addr[:city]
  # =>    end
  # => end

end

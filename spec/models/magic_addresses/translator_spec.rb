require 'spec_helper'

describe MagicAddresses::Translator do
  
  class TestAddress < ActiveRecord::Base
    self.table_name = "mgca_addresses"
    mgca_translate :street
  end

  class TestLocation < ActiveRecord::Base
    self.table_name = "mgca_addresses"
  end
  
  describe "Class::Methods" do
    
    it "add search helper" do
      expect( TestAddress.respond_to?(:search) ).to be true
      expect( TestAddress.search("xxx") ).equal? []
      expect( TestLocation.respond_to?(:search) ).to be false
      expect{ TestLocation.search("xxx") }.to raise_error(NoMethodError)
    end
    
  end


  describe "Instance::Methods" do

    let(:berlin){
      TestAddress.create!(name: "Berlin")
    }
    let(:potsdam){
      TestLocation.create!(name: "Potsdam")
    }

    it "add globalize attributes" do
      expect( berlin.respond_to?(:translations) ).to be true
      expect( berlin.respond_to?(:street) ).to be true
      
      expect( potsdam.respond_to?(:translations) ).to be false
      expect( potsdam.respond_to?(:street) ).to be false
    end
    
    it "add globalize attributes only if asked for" do
      expect( berlin.respond_to?(:translations) ).to be true
      expect( berlin.respond_to?(:street) ).to be true
      
      expect( potsdam.respond_to?(:translations) ).to be false
      expect( potsdam.respond_to?(:street) ).to be false
    end

  end


end

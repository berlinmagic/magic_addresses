# encoding: utf-8
class MagicAddresses::Addressible < ActiveRecord::Base
  
  belongs_to :owner,      polymorphic: true
  belongs_to :address,    class_name: "MagicAddresses::Address",    foreign_key: :address_id
  
end

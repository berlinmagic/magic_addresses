# encoding: utf-8
class MagicAddresses::Addressible < ActiveRecord::Base
  
  belongs_to :owner,      polymorphic: true
  belongs_to :address,    class_name: "MagicAddresses::Address",    foreign_key: :address_id
  
  after_create :log_some_stuff
  
private
  
  def log_some_stuff
    self.address ? self.address.trigger_build_address_associations : true
  end
  
end

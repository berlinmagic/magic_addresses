# encoding: utf-8
class MagicAddresses::OwnerProxy
  
  attr_accessor :this, :addressible_id, :owner_id, :owner_type, :name
  
  def initialize( addressible )
    self.this           = addressible.owner
    self.addressible_id = addressible.id
    self.owner_id       = addressible.owner_id
    self.owner_type     = addressible.owner_type
    self.name           = addressible.owner && addressible.owner.respond_to?(:name) ? addressible.owner.name : nil
  end
  
end

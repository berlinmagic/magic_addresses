# encoding: utf-8
class MagicAddresses::Addressible < ActiveRecord::Base
  
  # =====> C O N S T A N T S <=============================================================== #
  PARAMS = [ :id, :owner_type, :owner_id, :_destroy, :address_attributes => [ :id, :street, :street_additional, :number, :postalcode, :city, :country, :country_code, :owner, :_destroy ] ]
  
  
  # =====> A S S O Z I A T I O N S <========================================================= #
  belongs_to :owner,      polymorphic: true
  belongs_to :address,    class_name: "MagicAddresses::Address",    foreign_key: :address_id
  
  
  # =====> A T T R I B U T E S <============================================================= #
  accepts_nested_attributes_for :address, allow_destroy: true
  
  
  # =====> C A L L B A C K S <=============================================================== #
  # after_commit :log_some_stuff
  
  # =====>  P  R  I  V  A  T  E  !  <======================================================== # # # # # # # #
private
  
  def log_some_stuff
    Rails.logger.info "### ###"
    Rails.logger.info "### ###"
    Rails.logger.info "###  Triggered Addressible callback"
    Rails.logger.info "### ###"
    Rails.logger.info "### ###"
    puts "### ###"
    puts "### ###"
    puts "###  Triggered Addressible callback"
    puts "### ###"
    puts "### ###"
    self.address ? self.address.trigger_build_address_associations : true
  end
  
end

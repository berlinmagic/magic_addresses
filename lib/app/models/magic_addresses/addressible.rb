# encoding: utf-8
class MagicAddresses::Addressible < ActiveRecord::Base
  
  belongs_to :owner,      polymorphic: true
  belongs_to :address,    class_name: "MagicAddresses::Address",    foreign_key: :address_id
  
  after_commit :log_some_stuff
  
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

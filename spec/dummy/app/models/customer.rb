class Customer < ActiveRecord::Base
  
  
  has_one_address()
  has_one_named_address( "invoice_address" )
  has_one_named_address( "delivery_address" )
  
  
end

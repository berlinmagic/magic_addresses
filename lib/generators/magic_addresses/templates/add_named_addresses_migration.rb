# encoding: utf-8
class AddNamedAddresses < ActiveRecord::Migration
  def change
    
    
    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
    ## add new field for named addresses
    
    add_column  :mgca_addressibles, :named_address, :string
    
    add_index   :mgca_addressibles, :named_address
    
    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
    
    
  end
end

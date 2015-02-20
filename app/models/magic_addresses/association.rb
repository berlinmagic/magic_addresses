# encoding: utf-8
module MagicAddresses
  module Association
  
    def self.included(base)
      base.send :extend, ClassMethods
    end
  
    ##   C L A S S - M E T H O D S   # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
    module ClassMethods
    
      def has_addresses
        # => send :include, InstanceMethods
        has_many :addresses, as: :owner, class_name: "MagicAddresses::Address", dependent: :destroy
        accepts_nested_attributes_for :addresses, allow_destroy: true, reject_if: :all_blank
      end
      
      def has_one_address
        has_one     :address, -> { where(default: true) },
                    :as => :owner,
                    :class_name => "MagicAddresses::Address",
                    :autosave => true,
                    :dependent => :destroy
        # => delegate    :street, :street_number, :zipcode, :city, :subcity, :subsubcity, :state, :country, 
        # =>             to: :address, allow_nil: true
        accepts_nested_attributes_for :address, allow_destroy: true # => , reject_if: :all_blank
      end
    
    
    end #> ClassMethods
  
    ##   I N S T A N C E - M E T H O D S   # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
    module InstanceMethods
    
      # ...
    
    end #> InstanceMethods
  
  end
end

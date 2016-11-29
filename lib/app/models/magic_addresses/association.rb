# encoding: utf-8
module MagicAddresses
  module Association
  
    def self.included(base)
      base.send :extend, ClassMethods
    end
  
    ##   C L A S S - M E T H O D S   # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
    module ClassMethods
      
      
      def has_addresses
        # has_many    :addresses, 
        #             as: :owner, 
        #             class_name: "MagicAddresses::Address", 
        #             dependent: :destroy
        
        has_many    :addressibles,  
                    as: :owner, 
                    class_name: "MagicAddresses::Addressible", 
                    dependent: :destroy
        
        has_many    :addresses, 
                    through: :addressibles, 
                    source: :address
        
        accepts_nested_attributes_for :addresses, allow_destroy: true, reject_if: :all_blank
      end
      
      
      def has_one_address
        send :include, OneInstanceMethods
        # has_one     :address, -> { where(default: true) },
        #             as: :owner,
        #             class_name: "MagicAddresses::Address",
        #             autosave: true,
        #             dependent: :destroy
        
        has_one     :addressible, 
                    -> { where(default: true, named_address: ["", nil]) }, 
                    as: :owner, 
                    class_name: "MagicAddresses::Addressible", 
                    dependent: :destroy
        
        has_one     :address, 
                    through: :addressible, 
                    source: :address
        
        # accepts_nested_attributes_for :addressible, :address, allow_destroy: true, reject_if: :all_blank
      end
      
      def has_one_named_address( name = "address" )
        
        has_one     "#{name}_addressible".to_sym, 
                    -> { where(default: true, named_address: name) }, 
                    as: :owner, 
                    class_name: "MagicAddresses::Addressible", 
                    dependent: :destroy
        
        has_one     "#{name}".to_sym, 
                    through: "#{name}_addressible".to_sym, 
                    source: :address
        
        define_method "#{name}_attributes=" do |params|
          self.send( "#{name}=", MagicAddresses::Address.get_one( self, params ) )
        end
        
        define_method "#{name}_addressible_attributes=" do |params|
          self.send( "#{name}=", MagicAddresses::Address.get_one( self, params["#{name}_attributes".to_sym] ) )
        end
        
      end
      
      
      def has_nested_address
        send :include, NestedInstanceMethods
        # has_one     :address,
        #             as: :owner,
        #             class_name: "MagicAddresses::Address",
        #             autosave: true,
        #             dependent: :destroy
        
        has_one     :addressible, -> { where(default: true) }, 
                    as: :owner, class_name: "MagicAddresses::Addressible", dependent: :destroy
        has_one     :address,     through: :addressibles, source: :address
        
        delegate    :street, :number, :postalcode, :city, :district, :subdistrict, :state, :country,
                    :street=, :number=, :postalcode=, :city=, :country=, 
                    to: :address, allow_nil: true
        accepts_nested_attributes_for :address, allow_destroy: true, reject_if: :all_blank
        # alias_method_chain :address, :build
      end
      
      
    end #> ClassMethods
  
    ##   I N S T A N C E - M E T H O D S   # # # # # # # # # # # # # # # # # # # # # # # 
    module OneInstanceMethods
      
      # => http://stackoverflow.com/a/6989403/1470996
      def build_address(params = {})
        self.build_addressible
        # => self.addressible.address = MagicAddresses::Address.new(params)
        self.addressible.build_address(params)
      end
      
      def address_attributes=( params )
        # puts "address_attributes"
        self.address = MagicAddresses::Address.get_one( self, params )
      end
      
      def addressible_attributes=( params )
        # puts "addressible_attributes"
        self.address = MagicAddresses::Address.get_one( self, params[:address_attributes] )
      end
      
    end #> InstanceMethods
    
    
    # module OneNamedInstanceMethods
    #   @@named_address.each do |that|
    #     
    #     define_method "#{that}_attributes=" do |params|
    #       self.send( "#{that}=", MagicAddresses::Address.get_one( self, params ) )
    #     end
    #     
    #     define_method "#{that}_addressible_attributes=" do |params|
    #       self.send( "#{that}", MagicAddresses::Address.get_one( self, params[:address_attributes] ) )
    #     end
    #     
    #   end if @@named_address
    # end #> OneNamedInstanceMethods
    
    
    module NestedInstanceMethods
      
      # http://stackoverflow.com/a/4033761
      def address_with_build
        self.address_without_build || self.build_address
      end
      
    end #> InstanceMethods
  
  end
end

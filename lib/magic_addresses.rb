require "magic_addresses/configuration"

require "../../app/models/magic_addresses/association"
require "../../app/models/magic_addresses/translator"
require "../../app/models/magic_addresses"

require "magic_addresses/railtie" if defined?(Rails::Railtie)

module MagicAddresses
  
  autoload :Address,    "../../app/models/magic_addresses/address"
  
  class << self
    attr_accessor :configuration

    # Call this method to modify defaults in your initailizers.
    #
    #   MagicAddresses.configure do |config|
    #     config.active_locales << :fr
    #   end
    
    def configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end
    
  end
  
end

ActiveSupport.on_load(:active_record) do
  require 'globalize'
end

ActiveRecord::Base.send :include, MagicAddresses::Association
ActiveRecord::Base.send :include, MagicAddresses::Translator
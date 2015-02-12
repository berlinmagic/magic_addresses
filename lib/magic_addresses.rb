require "magic_addresses/configuration"

require "magic_addresses/railtie" if defined?(Rails::Railtie)

module MagicAddresses
  
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

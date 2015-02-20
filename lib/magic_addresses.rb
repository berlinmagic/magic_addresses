# require 'geocoder'

require 'activerecord-postgres-earthdistance'

# require 'geocoder/results/google_decorator'
# require 'geocoder/results/nominatim_decorator'

require "magic_addresses/configuration"

require "../../app/models/magic_addresses/association"
require "../../app/models/magic_addresses/translator"
require "../../app/models/magic_addresses"

require "magic_addresses/railtie" if defined?(Rails::Railtie)

module MagicAddresses
  
  autoload :Address,    "../../app/models/magic_addresses/address"
  autoload :Country,    "../../app/models/magic_addresses/country"
  autoload :State,      "../../app/models/magic_addresses/state"
  autoload :City,       "../../app/models/magic_addresses/city"
  autoload :District,   "../../app/models/magic_addresses/district"
  
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
  require 'geocoder'
end

#require 'geocoder'

ActiveRecord::Base.send :include, MagicAddresses::Association
ActiveRecord::Base.send :include, MagicAddresses::Translator
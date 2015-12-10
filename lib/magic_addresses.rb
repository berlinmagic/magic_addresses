# require 'geocoder'

require 'activerecord-postgres-earthdistance'

require 'geocoder/results/google_decorator'
require 'geocoder/results/nominatim_decorator'

require "magic_addresses/configuration"

require "app/models/magic_addresses/association"
require "app/models/magic_addresses/translator"
require "app/models/magic_addresses"

require "helpers/mgca_helper"

# require "magic_addresses/railtie" if defined?(Rails::Railtie)
require "magic_addresses/rails" if defined?(Rails)

# worker (sidekiq)
require "app/workers/magic_addresses/address_worker" if defined?(Sidekiq)

module MagicAddresses
  
  # models
  autoload :Address,                  "app/models/magic_addresses/address"
  autoload :Country,                  "app/models/magic_addresses/country"
  autoload :State,                    "app/models/magic_addresses/state"
  autoload :City,                     "app/models/magic_addresses/city"
  autoload :District,                 "app/models/magic_addresses/district"
  autoload :Subdistrict,              "app/models/magic_addresses/subdistrict"
  
  # connections
  autoload :Addressible,              "app/models/magic_addresses/addressible"
  
  # owner proxie
  autoload :OwnerProxy,               "app/models/magic_addresses/owner_proxy"
  
  # services
  autoload :GeoCoder,                 "app/models/magic_addresses/geo_coder"
  
  # controllers
  autoload :BaseController,           "app/controllers/magic_addresses/base_controller"
  autoload :CountriesController,      "app/controllers/magic_addresses/countries_controller"
  autoload :StatesController,         "app/controllers/magic_addresses/states_controller"
  autoload :CitiesController,         "app/controllers/magic_addresses/cities_controller"
  autoload :DistrictsController,      "app/controllers/magic_addresses/districts_controller"
  autoload :SubdistrictsController,   "app/controllers/magic_addresses/subdistricts_controller"
  
  
  
  # serializer
  autoload :AddressSerializer,        "app/serializers/magic_addresses/address_serializer" if defined?(ActiveModel::Serializer)
  
  class << self
    
    attr_accessor :configuration

    #initialize "mgca.add_views" do |app|
    #  app.view_paths.insert 0, ActionView::FileSystemResolver.new( "app/views" )
    #end

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

# ActionController::Base.prepend_view_path File.expand_path '../../app/views', __FILE__
ActionController::Base.append_view_path File.expand_path '../../app/views', __FILE__

#require 'geocoder'

ActiveRecord::Base.send :include, MagicAddresses::Association
ActiveRecord::Base.send :include, MagicAddresses::Translator
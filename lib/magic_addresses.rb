# require 'geocoder'

require 'activerecord-postgres-earthdistance'

require 'geocoder/results/google_decorator'
require 'geocoder/results/nominatim_decorator'

require "magic_addresses/configuration"

require "app/models/magic_addresses/association"
require "app/models/magic_addresses/translator"
require "app/models/magic_addresses"

require "helpers/mgca_helper"

require "magic_addresses/railtie" if defined?(Rails::Railtie)

module MagicAddresses
  
  # models
  autoload :Address,      "app/models/magic_addresses/address"
  autoload :Country,      "app/models/magic_addresses/country"
  autoload :State,        "app/models/magic_addresses/state"
  autoload :City,         "app/models/magic_addresses/city"
  autoload :District,     "app/models/magic_addresses/district"
  autoload :Subdistrict,  "app/models/magic_addresses/subdistrict"
  
  # services
  autoload :GeoCoder,     "app/models/magic_addresses/geo_coder"
  
  # controllers
  autoload :BaseController,           "app/controllers/magic_addresses/base_controller"
  autoload :CountriesController,      "app/controllers/magic_addresses/countries_controller"
  autoload :StatesController,         "app/controllers/magic_addresses/states_controller"
  autoload :CitiesController,         "app/controllers/magic_addresses/cities_controller"
  autoload :DistrictsController,      "app/controllers/magic_addresses/districts_controller"
  autoload :SubdistrictsController,   "app/controllers/magic_addresses/subdistricts_controller"
  
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
  
  class Engine < ::Rails::Engine
    
  end
  
  def self.root
    File.expand_path '../..', __FILE__
  end
  
end

ActiveSupport.on_load(:active_record) do
  require 'globalize'
  require 'geocoder'
end

# => ActionController::Base.prepend_view_path File.dirname(__FILE__) + "app/views"
ActionController::Base.append_view_path File.dirname(__FILE__) + "app/views"

#require 'geocoder'

ActiveRecord::Base.send :include, MagicAddresses::Association
ActiveRecord::Base.send :include, MagicAddresses::Translator
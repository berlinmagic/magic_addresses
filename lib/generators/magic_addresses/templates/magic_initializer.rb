MagicAddresses.configure do |config|
  # Address Owners .. all models that use addresses (name + class_name => {users: "User", things: "Namespace::Thing"}) 
  config.address_owners     = {}
  # in which locales addresses should be saved
  config.active_locales     = [:en, :de]
  # what is the default language (should be :en, except you don't need english at all)
  config.default_locale     = :en
  # what is the default country for query
  config.default_country    = "Germany"
  # add default country in each query ?
  config.query_defaults     = true
  # only save tranlations when differs from default-locale?
  config.uniq_translations  = false
  # use background-process for the lookups ( :none | :sidekiq )
  config.job_backend        = :none
  # use postgres earthdistance for distance calculation
  config.earthdistance      = false
end

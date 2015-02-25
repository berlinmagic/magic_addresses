MagicAddresses.configure do |config|
  # in which locales addresses should be saved
  config.active_locales = [:en, :de]
  # what is the default language (should be :en, except you don't need english at all)
  config.default_locale = :en
  # what is the default language (should be :en, except you don't need english at all)
  config.default_country = "Germany"
  # use a background-process for the lookups
  config.job_backend = :none
  # use a postgres earthdistance for distance calculation
  config.earthdistance = false
end
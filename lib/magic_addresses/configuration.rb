module MagicAddresses
  class Configuration
    OPTIONS = []

    # Enabled languages .. save address in each if different to default locale
    attr_accessor :active_locales

    # Addresses default locale
    attr_accessor :default_locale

    # Job backend
    attr_accessor :job_backend

    def initialize
      @active_locales = [:en, :de]
      @default_locale = :en
      @job_backend = :none
    end

    # Returns a hash of all configurable options
    def to_hash
      OPTIONS.inject({}) do |hash, option|
        hash.merge(option.to_sym => send(option))
      end
    end
  end
end
module MagicAddresses
  class Configuration
    OPTIONS = []

    # Address Owners .. all models that use addresses (name + class_name => {users: "User", things: "Namespace::Thing"}) 
    attr_accessor :address_owners

    # Enabled languages .. save address in each if different to default locale
    attr_accessor :active_locales

    # Addresses default locale
    attr_accessor :default_locale

    # Addresses default country
    attr_accessor :default_country
    # add default country in query ?
    attr_accessor :query_defaults

    # only save tranlations when differs from default?
    attr_accessor :uniq_translations

    # Job backend ( :sidekiq | :none )
    attr_accessor :job_backend

    # use earthdistance? ( true | false )
    attr_accessor :earthdistance

    # show state in tables ( true | false )
    attr_accessor :show_states

    # show triggers in tables ( true | false ) **not available for now!!!
    attr_accessor :show_triggers

    def initialize
      @address_owners     = {}
      @active_locales     = [:en, :de]
      @default_locale     = :en
      @default_country    = "Germany"
      @query_defaults     = true
      @uniq_translations  = false
      @job_backend        = :none
      @earthdistance      = false
      @show_states        = false
      @show_triggers      = false
    end

    # Returns a hash of all configurable options
    def to_hash
      OPTIONS.inject({}) do |hash, option|
        hash.merge(option.to_sym => send(option))
      end
    end
  end
end
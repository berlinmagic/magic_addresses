# Geocoder initialer slightly changed to work with magic_addresses
Geocoder.configure(

  # geocoding options
  :timeout      => 5,           # geocoding service timeout (secs)
  :lookup       => :google,     # name of geocoding service (symbol)
  :language     => :de,         # ISO-639 language code
  # :use_https    => false,       # use HTTPS for lookup requests? (if supported)
  # :http_proxy   => nil,         # HTTP proxy server (user:pass@host:port)
  # :https_proxy  => nil,         # HTTPS proxy server (user:pass@host:port)
  # :api_key      => nil,         # API key for geocoding service
  # :cache        => nil,         # cache object (must respond to #[], #[]=, and #keys)
  # :cache_prefix => "geocoder:", # prefix (string) to use for all cache keys

  # exceptions that should not be rescued by default
  # (if you want to implement custom error handling);
  # supports SocketError and TimeoutError
  # :always_raise => [],

  # needs to raise OverQueryLimitError to change lookup type when appears
  :always_raise => [Geocoder::OverQueryLimitError],

  # calculation options
  # :units     => :mi,       # :km for kilometers or :mi for miles
  # :distances => :linear    # :spherical or :linear

  # needed for nominatim lookups
  :http_headers => { "User-Agent" => "YOUR-APP-NAME", "Accept-Language" => "de" },

)
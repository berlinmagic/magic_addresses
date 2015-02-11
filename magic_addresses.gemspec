$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "magic_addresses/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "magic_addresses"
  s.version     = MagicAddresses::VERSION
  s.authors     = ["Torsten Wetzel"]
  s.email       = ["torstenwetzel@berlinmagic.com"]
  s.homepage    = "TODO"
  s.summary     = "A really nice address plugin we offten use."
  s.description = "Easy sortable and translated addresses uses google-api with nominatim fallback."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.0"

  s.add_development_dependency "sqlite3"
end

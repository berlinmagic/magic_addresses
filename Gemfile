source 'https://rubygems.org'

# Declare your gem's dependencies in magic_addresses.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.


## A S S E T S
gem 'sass-rails',         ">= 4.0.3"
gem 'uglifier',           ">= 2.5.1"
gem 'coffee-rails',       ">= 4.0.1"
gem 'jquery-rails',       ">= 3.1.1"
gem 'jquery-ui-rails',    '>= 4.2.1'


gem "magic_stylez",       ">= 0.0.0.65"

# To use a debugger
# gem 'byebug', group: [:development, :test]
group :test do
  gem 'shoulda-matchers'
  gem 'database_cleaner'
end

group :development, :test do
  gem 'awesome_print'
  gem 'spring-commands-rspec'
  gem 'guard-rails'
end
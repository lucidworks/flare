source 'https://rubygems.org'

gem 'rails', '3.2.13'
gem "warbler"

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'activerecord-jdbcsqlite3-adapter'

gem 'jruby-openssl'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyrhino'

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

gem 'blacklight'

# TODO: Use lucid_works gem to centralize and keep clean the LWS REST API
#   * Had troubles incorporating this into my environment, so going straight HTTP + JSON:

# ➜  lucidworks-ruby git:(master) ✗ jruby -S gem build lucid_works.gemspec                                                
#   Successfully built RubyGem
#   Name: lucid_works
#   Version: 0.9.3
#   File: lucid_works-0.9.3.gem

# ➜  lws_blacklight git:(master) ✗ jruby -S bundle update
# Fetching gem metadata from https://rubygems.org/...........
# Fetching gem metadata from https://rubygems.org/..
# Resolving dependencies...
# Could not find gem 'lucid_works (= 0.9.3) java' in the gems available on this
# machine.

# gem 'lucid_works', '0.9.3'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

gem "unicode", :platforms => [:mri_18, :mri_19]
gem "devise"
gem "devise-guests", "~> 0.3"
gem "bootstrap-sass"
gem 'bootswatch-rails'

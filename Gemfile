source 'https://rubygems.org'

gem 'rails', '3.2.13'
gem "devise", '3.0.1'
gem "devise-guests", "~> 0.3"
gem "bootstrap-sass"
gem 'blacklight'
gem "unicode", :platforms => [:mri_18, :mri_19]

platforms :jruby do
  gem 'activerecord-jdbcsqlite3-adapter'
  gem 'jruby-openssl'

  # something fishy with rubyzip, see the following:
  #   - http://stackoverflow.com/questions/18736166/warbler-no-such-file-to-load-zip-zip
  #   - https://github.com/jruby/warbler/issues/180  
  gem "rubyzip", "<1.0.0"
  
  gem 'warbler'
  gem 'log4jruby'
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem "font-awesome-sass-rails", "~> 3.0.2.2"
  gem 'coffee-rails', '~> 3.2.1'
  gem 'jquery-rails'
  gem 'uglifier', '>= 1.0.3'

  # The JavaScript interpreter to install on Linux. OS X uses Apple's JavaScriptCore.
  gem 'therubyrhino'
end

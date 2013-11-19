source 'https://rubygems.org'

### Framework
gem 'sinatra',   :require => 'sinatra/base'

### Utility
gem 'rake'
gem 'yajl-ruby', :require => 'yajl/json_gem'

### Database
gem 'dm-core'
gem 'dm-migrations'
gem 'dm-timestamps'
gem 'dm-validations'
gem 'dm-types'

### Billing
gem 'stripe'

### Communication
gem 'pony'

### Error Reporting
gem 'sentry-raven'

### Asset Management
group :assets do
  gem 'sprockets'
  gem 'sass'
  gem 'coffee-script'
end

### Development Tools
group :development, :test do
  gem 'dm-sqlite-adapter'
  gem 'rack-livereload'
  gem 'guard-livereload', :require => nil
end

### Production
group :production do
  gem 'dm-postgres-adapter'
end
source "https://rubygems.org"

# Core Rails gems
gem "rails", "~> 8.0.1"
gem "puma", ">= 5.0"
gem "bootsnap", require: false

# Database and caching
gem "sqlite3", ">= 2.1"
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

# Asset pipeline and frontend
gem "propshaft"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "thruster", require: false

# Deployment
gem "kamal", require: false

# Added dependencies
gem "annotate"
gem "faker"

# Platform specific
gem "tzinfo-data", platforms: %i[ windows jruby ]

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  gem "pry"
end

group :development do
  gem "web-console"
end

# Uncomment when needed:
# gem "bcrypt", "~> 3.1.7"
# gem "image_processing", "~> 1.2"

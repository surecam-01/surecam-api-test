source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# rack-stack gems
ruby "3.2.2"
gem "rails", "~> 7.0.8", ">= 7.0.8.4"
gem "puma", "~> 5.0"

# postgres database
gem "pg"


# add-on gem
gem "bcrypt"
gem "rack-cors"
gem "jwt"

gem "httparty"
gem "pry"

# default gems
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end


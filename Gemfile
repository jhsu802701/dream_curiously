# Gems used in the Rails Tutorial Sample App
source 'https://rubygems.org'

gem 'rails',                   '4.2.2'
gem 'bcrypt',                  '3.1.7'
gem 'faker',                   '1.4.2'
gem 'carrierwave',             '0.10.0'
gem 'mini_magick',             '3.8.0'
gem 'fog',                     '1.23.0'
gem 'will_paginate',           '3.0.7'
gem 'bootstrap-will_paginate', '0.0.10'
gem 'bootstrap-sass',          '3.2.0.0'
gem 'sass-rails',              '5.0.2'
gem 'uglifier',                '2.7.2'
gem 'coffee-rails',            '4.1.0'
gem 'jquery-rails',            '4.0.4'
gem 'turbolinks',              '2.3.0'
gem 'jbuilder',                '2.2.3'
gem 'sdoc',                    '0.4.0', group: :doc

group :development, :test do
  gem 'byebug',      '3.4.0'
  gem 'web-console', '2.1.3'
  gem 'spring',      '1.1.3'
end

group :test do
  gem 'minitest-reporters', '1.0.5'
  gem 'mini_backtrace',     '0.1.3'
  gem 'guard-minitest',     '2.3.1'
end

group :production do
  gem 'rails_12factor', '0.0.2'
  gem 'puma',           '2.11.1'
end

# ADDITIONS: code checking
group :development do
  gem 'rubocop'
  gem 'guard-rubocop'
  gem 'sandi_meter'
  gem 'rails_best_practices'
  gem 'guard-rails_best_practices', git: "https://github.com/logankoester/guard-rails_best_practices.git"
  gem 'brakeman'
  gem 'guard-brakeman'
  gem 'bundler-audit'
  gem 'guard-bundler-audit'
  gem 'metric_fu'
end

# ADDITIONS: user/authentication
gem 'devise'

# ADDITIONS: Capybara
group :test do
  gem 'capybara'
  gem 'capybara-email'
end

# DATABASE
group :development, :test do
  gem 'sqlite3', '1.3.9' # Delete if using only PostgreSQL
end
gem 'pg', '0.17.1' # Always included to simplify Gemfile management

# ADDITIONS: configuring PostgreSQL
gem 'figaro', '1.1.1'
gem 'string_in_file'
gem 'line_containing'

# ADDITION: search/filtering
gem 'ransack'

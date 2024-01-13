# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

gem 'rails', '~> 7.0.5'

gem 'sprockets-rails'

gem 'pg', '~> 1.1'

gem 'puma', '~> 5.0'

gem 'importmap-rails'

gem 'turbo-rails'

gem 'stimulus-rails'

gem 'jbuilder'

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem 'bootsnap', require: false

gem 'bootstrap', '5.3.0'

gem 'jquery-rails'

gem 'sorcery'

gem 'rails-i18n'

gem 'simple_calendar'

gem 'carrierwave'

gem 'chartkick'

gem 'config'

gem 'whenever', require: false

gem 'mini_racer'

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'hirb'
  gem 'hirb-unicode-steakknife'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'rubocop', '1.42.0', require: false
  gem 'rubocop-rails'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'simplecov', require: false
end

group :development do
  gem 'web-console'

  gem 'letter_opener_web'
end

gem 'dockerfile-rails', '>= 1.5', group: :development

gem 'redis', '~> 5.0'

gem 'sentry-ruby', '~> 5.12'

gem 'sentry-rails', '~> 5.12'

gem 'sassc-rails', '~> 2.1'

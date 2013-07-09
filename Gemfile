source 'https://rubygems.org'

ruby '1.9.3'

gem 'rails', '3.2.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'pg', '~> 0.14.1'
gem 'figaro'

gem 'jquery-rails'
# gem 'rinruby'
# gem 'bcrypt-ruby', '~> 3.0.0'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  # gem 'coffee-rails', '~> 3.2.1'g

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

group :development, :test do
	gem 'rspec-rails'
	gem 'better_errors'
	gem 'guard-rspec'
	gem 'guard-spork'
	gem 'childprocess'
	gem 'spork'
	gem 'jasmine'
  gem 'binding_of_caller'
end


gem 'geocoder'

group :test do
	gem 'factory_girl_rails'
	gem 'shoulda-matchers'
	gem 'capybara'
	gem 'rb-fsevent', :require => false
	gem 'database_cleaner'
	gem 'launchy'
	gem 'selenium-webdriver'
end

require 'capybara'
require 'rspec'
require 'capybara/cucumber'
require 'capybara-screenshot/cucumber'
## Uncomment to enable SimpleCov
require 'simplecov'

SimpleCov.start do
  add_filter 'features/'
end

require_relative '../../app.rb'

ENV['RACK_ENV'] = 'test'

Capybara.app = Sinatra::Application
Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.javascript_driver = :chrome
class Sinatra::ApplicationWorld
  include RSpec::Expectations
  include RSpec::Matchers
  include Capybara::DSL
end

World do
  Sinatra::ApplicationWorld.new  
end
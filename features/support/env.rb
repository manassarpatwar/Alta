require 'capybara'
require 'rspec'
require 'capybara/cucumber'
require 'webdrivers'
require 'chromedriver-helper'
require 'simplecov'
ENV['RACK_ENV'] = 'test'
require_relative '../../app.rb'

Capybara.app = Sinatra::Application
Capybara.app_host = 'http://localhost:4567'
Capybara.server_port = 4567

# Capybara.javascript_driver = :selenium_chrome_headless
#Set to chromedriver to see realtime tests
# Capybara.register_driver :selenium do |app|
#   Capybara::Selenium::Driver.new(app, browser: :chrome)
# end

Capybara.javascript_driver = :selenium_chrome
class Sinatra::ApplicationWorld
  include RSpec::Expectations
  include RSpec::Matchers
  include Capybara::DSL
  $db = PG.connect(dbname: 'taxitestdb');
end

World do
  Sinatra::ApplicationWorld.new  
end
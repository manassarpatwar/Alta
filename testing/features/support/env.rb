require 'capybara'
require 'rspec'
require 'capybara/cucumber'
require 'selenium-webdriver'
ENV['RACK_ENV'] = 'test'
require_relative '../../../app/app.rb'

Capybara.app = Sinatra::Application
Capybara.app_host = 'http://localhost:4567'
Capybara.server_port = 4567

Capybara.javascript_driver = :selenium_chrome_headless
#Set to chromedriver to see realtime tests
#Capybara.register_driver :chrome do |app|
#  Capybara::Selenium::Driver.new(app, browser: :chrome)
#end
#Capybara.javascript_driver = :chrome
class Sinatra::ApplicationWorld
  include RSpec::Expectations
  include RSpec::Matchers
  include Capybara::DSL
  $db = SQLite3::Database.new '../taxi_test_db.sqlite'
end

World do
  Sinatra::ApplicationWorld.new  
end
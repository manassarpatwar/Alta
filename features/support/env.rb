require 'capybara'
require 'rspec'
require 'capybara/cucumber'
require 'selenium-webdriver'
require 'simplecov'
ENV['RACK_ENV'] = 'test'
require_relative '../../app.rb'

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
  $db = SQLite3::Database.new 'database/taxi_test_db.sqlite'
end

Before do
  Capybara.session_name = ":session_#{Time.now.to_i}" 
end

After do
  if Capybara.current_driver == Capybara.javascript_driver
      Capybara.current_session.driver.quit
  end
end

World do
  Sinatra::ApplicationWorld.new  
end
require 'capybara'
require 'rspec'
require 'capybara/cucumber'
require 'capybara-screenshot/cucumber'
require 'selenium-webdriver'
## Uncomment to enable SimpleCov
#require 'simplecov'

#SimpleCov.start do
#  add_filter 'features/'
#end

require_relative '../../app.rb'

ENV['RACK_ENV'] = 'test'

Capybara.app = Sinatra::Application
Capybara.register_driver :headless_chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { args: %w[headless window-size=1280,960 remote-debugging-port=9222] }
  )
  Capybara::Selenium::Driver.new(app, browser: :headless_chrome, desired_capabilities: capabilities)
end
Capybara.javascript_driver = :selenium_chrome_headless
class Sinatra::ApplicationWorld
  include RSpec::Expectations
  include RSpec::Matchers
  include Capybara::DSL
end

World do
  Sinatra::ApplicationWorld.new  
end
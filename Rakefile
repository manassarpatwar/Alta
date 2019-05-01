require "rake/testtask"

# replace the below with the path to your app
require_relative 'app.rb'
require "selenium-webdriver"
require 'socket'

desc "Restore the state of the db"
task :wipedb do
  puts "Wiping the database"
  `ruby wipeDatabase.rb`
end

desc "Add callback url in twitter"
task :addcallback do
  STDOUT.puts "This task requires the user to be running from codio. Proceed? [Y/n]"
  proceed = STDIN.gets.strip
  if proceed == "y" || proceed == "Y" then
    driver = Selenium::WebDriver.for :chrome
    host = Socket.gethostname
    #Sign in to twitter
    driver.navigate.to "http://twitter.com/login"
    username = driver.find_element(class: 'js-username-field')
    username.send_keys "ise19team29"
    password = driver.find_element(class: 'js-password-field')
    password.send_keys "SoftEng2019"
    password.submit
    
    #Edit app callback url
    driver.navigate.to "https://developer.twitter.com/en/apps/16126309"
    edit = driver.find_element(class: "page-title-bar").find_element(class: "dropdown-button").click

    editdetails = driver.find_element(id: "feather-dropdown-7-menu-item-content-0").click

    add =  driver.find_element(class: 'addButton')
    add.click
    addUrl =  driver.find_element(name: 'callbackUrls[7].url')
    addUrl.send_keys "http://#{host}-4567.codio.io/auth/twitter"
    save = driver.find_element(class: 'Button--primary')
    save.click
    driver.quit
  else
    abort("Exiting")
  end
end

desc "Create db"
task :createdb do
  puts "Creating the database"
  `ruby createDatabase.rb`
end

desc "Delete temporary files"
task :clean => :wipedb do
  `echo deleting temporary files`
  # ... code to delete the database ....
end

desc "Run tests"
Rake::TestTask.new do |t|
  t.pattern = "*_test.rb"
end

desc "Run the Sinatra app locally"
task :run do
  Sinatra::Application.run!
end


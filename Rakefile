require "rake/testtask"

# replace the below with the path to your app

desc "Restore the state of the db"
task :wipedb do
  puts "Wiping the database"
  `ruby database/wipeDatabase.rb`
end

desc "Install gems"
task :installgems do
   puts "Installing gems"
   system('bundle install')
end

desc "Install chromedriver"
task :installchromedriver do
  puts "Installing chromedriver"
  system('sudo cp chromedriver /bin')
  system('sudo apt-get install chromium-chromedriver')
  system('sudo apt-get install libnss3-dev')
end

desc "Install rvm"
task :installrvm do
    system('sudo apt-get update')
    system('command curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -')
    system('\curl -sSL https://get.rvm.io | bash -s stable --ruby')
end


desc "Add callback url in twitter"
task :addcallback do
  require "selenium-webdriver"
  require 'socket'
  STDOUT.puts "This task requires the user to be running from codio. Proceed? [Y/n]"
  proceed = STDIN.gets.strip
  if proceed == "y" || proceed == "Y" then
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    driver = Selenium::WebDriver.for :chrome, options: options
    host = Socket.gethostname
    #Sign in to twitter
    driver.navigate.to "http://twitter.com/login"
    username = driver.find_element(class: 'js-username-field')
    username.send_keys "tbtonner1@sheffield.ac.uk"
    password = driver.find_element(class: 'js-password-field')
    password.send_keys "SoftEng2019"
    password.submit
    
    #Edit app callback url
    driver.navigate.to "https://developer.twitter.com/en/apps/16126309"
    sleep 2
    edit = driver.find_element(class: "page-title-bar").find_element(class: "dropdown-button").click

    editdetails = driver.find_element(id: "feather-dropdown-7-menu-item-content-0").click

    add =  driver.find_element(class: 'addButton')
    add.click
    size = driver.find_element(class: 'callback-urls').find_elements(class: "field-with-delete").length
    addUrl =  driver.find_element(name: "callbackUrls[#{size-1}].url")
    addUrl.clear
    addUrl.send_keys "http://#{host}-4567.codio.io/auth/twitter/callback"
    add.click
    size = driver.find_element(class: 'callback-urls').find_elements(class: "field-with-delete").length
    addUrl =  driver.find_element(name: "callbackUrls[#{size-1}].url")
    addUrl.clear
    addUrl.send_keys "https://#{host}-4567.codio.io/auth/twitter/callback"
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
  `ruby database/createDatabase.rb`
end

desc "Delete temporary files"
task :clean do
  `echo deleting temporary files`
  `rm database/taxi_test_db.sqlite`
  # ... code to delete the database ....
end

desc "Create backup of database into csv files"
task :backupdb do
    system('sqlite3 -header -csv database/taxi_db.sqlite "select * from users;" > public/csv/users.csv')
    system('sqlite3 -header -csv database/taxi_db.sqlite "select * from feedback;" > public/csv/feedback.csv')
    system('sqlite3 -header -csv database/taxi_db.sqlite "select * from taxis;" > public/csv/taxis.csv')
    system('sqlite3 -header -csv database/taxi_db.sqlite "select * from journeys;" > public/csv/journeys.csv')
end

desc "Run tests"
task :test do
#  require 'simplecov'
#  SimpleCov.start
  system('ruby database/createDatabase.rb testdb')
  system('ruby testing/minitests.rb')
  system('cd testing')
  system('cucumber')
  Rake::Task[:clean].execute
end

desc "Run the Sinatra app locally"
task :run do
  require_relative 'app/app.rb'
  Sinatra::Application.run!
end

desc "Install the app"
task :install do
  Rake::Task[:installchromedriver].execute
  Rake::Task[:installgems].execute
  Rake::Task[:createdb].execute
end


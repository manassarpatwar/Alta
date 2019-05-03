#--------------------Configuration and Setup--------------------#

#All gem requirements
require 'erb'
require 'sinatra'
require 'sinatra/cookies'
require 'twitter'
require 'rufus-scheduler'
require 'omniauth-twitter'
require 'sqlite3'
require 'chartkick'
require 'csv'
require 'socket'
#require_relative 'createDatabase.rb'
require_relative 'methods.rb'
require_relative 'editDatabases.rb'
require_relative 'dashboard.rb'
require_relative 'main.rb'
require_relative 'login.rb'
require_relative 'marketing.rb'
require_relative 'analytics.rb'

puts "#{Socket.gethostname}"

set :bind, '0.0.0.0' # Needed when running from Codio
include ERB::Util #Ensure ERB is enabled

#Setting up OmnuAuth-Twitter for our Twitter App
use OmniAuth::Builder do
  	provider :twitter, 'wVzUO14M25jvS3vmmtfDAtmh6', 'x1hieq7QNwhbUM8wjqgl5HujELyyqmZiJUzpaWi1tQEnG8cQrX'
end

#Before running load these configurations:
before do
    response.set_cookie(:tweeting, :value => "true")
    response.set_cookie(:following, :value => "true")
    response.set_cookie(:follow_state, :value => "true")
    response.set_cookie(:tweet_state, :value => "true")
end

#Configure sessions
configure do
	enable :sessions
    begin
      File.read("taxi_db.sqlite")
    rescue
      abort("Database not found... \nExiting\nTip: Run createDatabase.rb (ruby createDatabase.rb)")
    end
    $db = SQLite3::Database.new 'taxi_db.sqlite'
    #$db = SQLite3::Database.new 'taxi_database.sqlite'
    $rideDeal = 5
    begin
      TWITTER_CLIENT = Twitter::REST::Client.new do |config|
          config.consumer_key        = 'wVzUO14M25jvS3vmmtfDAtmh6'
          config.consumer_secret     = 'x1hieq7QNwhbUM8wjqgl5HujELyyqmZiJUzpaWi1tQEnG8cQrX'
          config.access_token        = '1092444312430919681-k6yytElynjt9A1ziskr28eHKLg580X'
          config.access_token_secret = 'UkK1okCoI1kFUKeofvh5Y5QQHkJyVOQxeIQGQfyCjIFQP'
      end
      $tweets = TWITTER_CLIENT.mentions_timeline(count: "5")
      puts "fetched tweets"
    rescue Twitter::Error::TooManyRequests => error
        puts "Too many requests. Try again in #{error.rate_limit.reset_in} seconds"
        sleep error.rate_limit.reset_in
    end
end

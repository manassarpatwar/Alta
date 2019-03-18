#--------------------Configuration and Setup--------------------#

#All gem requirements
require 'erb'
require 'sinatra'
require 'twitter'
require 'rufus-scheduler'
require 'omniauth-twitter'
require 'sqlite3'
require_relative 'addJourney.rb'
require_relative 'addTaxi.rb'
require_relative 'addUser.rb'
require_relative 'addComplaint.rb'
require_relative 'dashboard.rb'
require_relative 'main.rb'
require_relative 'login.rb'
require_relative 'complaint.rb'
require_relative 'marketing.rb'


set :bind, '0.0.0.0' # Needed when running from Codio

include ERB::Util #Ensure ERB is enabled

#Setting up OmnuAuth-Twitter for our Twitter App
use OmniAuth::Builder do
  	provider :twitter, 'wVzUO14M25jvS3vmmtfDAtmh6', 'x1hieq7QNwhbUM8wjqgl5HujELyyqmZiJUzpaWi1tQEnG8cQrX'
end

#Before running load these configurations:
before do
  	@db = SQLite3::Database.new './taxi_database.sqlite'
    @taxiTable = @db.execute("SELECT * FROM taxis")
    $tweets.each do |deletedTweet|
        begin
            TWITTER_CLIENT.status(deletedTweet.uri) == deletedTweet
        rescue Twitter::Error::NotFound => err
            $tweets.delete(deletedTweet)
        end 

    end
end

#Configure sessions
configure do
	enable :sessions
    TWITTER_CLIENT = Twitter::REST::Client.new do |config|
        config.consumer_key        = 'wVzUO14M25jvS3vmmtfDAtmh6'
        config.consumer_secret     = 'x1hieq7QNwhbUM8wjqgl5HujELyyqmZiJUzpaWi1tQEnG8cQrX'
        config.access_token        = '1092444312430919681-k6yytElynjt9A1ziskr28eHKLg580X'
        config.access_token_secret = 'UkK1okCoI1kFUKeofvh5Y5QQHkJyVOQxeIQGQfyCjIFQP'
    end
    $tweets = TWITTER_CLIENT.mentions_timeline(count: "5")
    puts "fetched tweets"
end

#Setting up privilages to different parts of the website
helpers do
	def admin?
    	session[:admin]
  	end
  
	def loggedin?
		session[:loggedin]
	end
end

get '/index' do
  erb :index
end

get '/order' do
  erb :user_orders
end

get'/account' do
  erb :user_account
end
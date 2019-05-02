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

#Setting up privilages to different parts of the website
helpers do
    def gather_taxis
      if session[:admin_sheffield] then
         @availableTaxis = $db.execute %{SELECT * FROM taxis WHERE city IS "SHEFFIELD" AND available IS "1"} #Gather all taxis
         @unavailableTaxis = $db.execute %{SELECT * FROM taxis WHERE city IS "SHEFFIELD" AND available IS "0"} #Gather all taxis
      elsif session[:admin_manchester] then
         @availableTaxis = $db.execute %{SELECT * FROM taxis WHERE city IS "MANCHESTER" AND available IS "1"} #Gather all taxis
         @unavailableTaxis = $db.execute %{SELECT * FROM taxis WHERE city IS "MANCHESTER" AND available IS "0"} #Gather all taxis
      end
    end
        
    def add_feedback(j_id, u_id, fdbk, rat)
      	#get feedback table from the database
        @feedbackInfo = $db.execute("SELECT * FROM feedback")

        @submitted = true

        #sanitize values
        @journey_id = j_id
        @user_id = u_id
        @date_time = Time.now.strftime("%Y/%m/%d %H:%M").to_s
        @feedback = fdbk
        @rating = rat

        # perform validation
        @journey_id_ok = isPositiveNumber? (@journey_id)
        @feedback_ok = !@feedback.nil? && @feedback != ""
        @user_id_ok = !@user_id.nil? && @user_id != ""
        @rating_ok = @rating == '' || @rating == '0' || @rating == '1' || @rating == '2' || @rating == '3' || @rating == '4' || @rating == '5'


        @all_ok = @journey_id_ok && @feedback_ok && @user_id_ok && @rating_ok

        @id = @feedbackInfo[@feedbackInfo.length-1][0].to_i + 1

        # add data to the database
        if @all_ok
            # do the insert
            $db.execute('INSERT INTO feedback VALUES (?, ?, ?, ?, ?, ?)', [@id, @journey_id, @user_id, @date_time, @feedback, @rating])
        end
    end

    def isPositiveNumber? string
      begin
          Float(string)
          int = string.to_i
          if int >= 0
              return true
          else
              return false
          end
      rescue
          return false
      end
    end
end

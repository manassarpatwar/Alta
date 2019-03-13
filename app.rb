#--------------------Configuration and Setup--------------------#

#All gem requirements
require 'erb'
require 'sinatra'
require 'twitter'
require 'rufus-scheduler'
require 'omniauth-twitter'
require 'sqlite3'

set :bind, '0.0.0.0' # Needed when running from Codio

include ERB::Util #Ensure ERB is enabled

#scheduler = Rufus::Scheduler.new
#time = 0
#scheduler.every "1s" do
#  time = time + 1
#  puts time
#end

#Setting up OmnuAuth-Twitter for our Twitter App
use OmniAuth::Builder do
  	provider :twitter, 'wVzUO14M25jvS3vmmtfDAtmh6', 'x1hieq7QNwhbUM8wjqgl5HujELyyqmZiJUzpaWi1tQEnG8cQrX'
end

#Before running load these configurations:
before do
  	config = {
		:consumer_key => 'wVzUO14M25jvS3vmmtfDAtmh6',
    	:consumer_secret => 'x1hieq7QNwhbUM8wjqgl5HujELyyqmZiJUzpaWi1tQEnG8cQrX',
    	:access_token => '1092444312430919681-k6yytElynjt9A1ziskr28eHKLg580X',
    	:access_token_secret => 'UkK1okCoI1kFUKeofvh5Y5QQHkJyVOQxeIQGQfyCjIFQP'
  	}
  	@client = Twitter::REST::Client.new(config)
    @tweets = @client.search("to:uber", result_type: "recent", lang: "en", geocode: "53.3,-1.5,10000km").take(10)
  	@db = SQLite3::Database.new './taxi_database.sqlite'
end

#Configure sessions
configure do
	enable :sessions
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

#--------------------Get Methods--------------------#

#Everyone is welcome page
get '/' do
  	erb :welcome
end

get '/dashboard' do
    #redirect '/' unless admin?

	response.set_cookie 'tweets_cookie',
	{:fetchedTweets => @tweets, :isUsed => false}
	puts(request.cookies['tweets_cookie'])

	erb :dashboard
end

fetch = false
get '/fetch_tweets' do
  if fetch then 
    since_id = @tweets[0].id
    @tweets = @client.search("to:uber", result_type: "recent", lang: "en", geocode: "53.3,-1.5,10000km", since_id: "#{since_id}").take(10)
  end
  fetch = true
  erb :fetch_tweets
end

get '/index' do
	redirect '/' unless loggedin?
	erb :index
	@test = "hello"
end

get '/cont' do
	redirect '/' unless loggedin?
	erb :homepage_cont
end

#Login page redirecting to twitter autherisation
get '/login' do
  	redirect to("/auth/twitter")
end

#Logs user out
get '/logout' do
	redirect '/' unless loggedin?

  	session[:loggedin] = nil
  	redirect '/'
end

#When autherisation for twitter is called
get '/auth/twitter/callback' do
	session[:loggedin] = true #User now logged in

	id = env['omniauth.auth']['uid'].to_s
	name = env['omniauth.auth']['info']['nickname'].to_s
	dateTime = Time.now.strftime("%d/%m/%Y %H:%M").to_s
	
    @user = @db.execute("SELECT * FROM users WHERE id = ?", id) #Get user data

	if @user == []
		@db.execute("INSERT INTO users VALUES (?, ?, ?, 0, 0)", id, name, dateTime)
		@user = @db.execute("SELECT * FROM users WHERE id = ?", id) #Get user data
	end 
	
	#Set global variables of user information to user logged in 
	@id = @user[0][0]
	@name = @user[0][1]
	@dateTime = @user[0][2]
	if @user[0][3] == 1
		session[:admin] = true 
	end	
	@freeRides = @user[0][4]

	redirect '/'
end

#When autherisation fails
get '/auth/failure' do
  	params[:message]
end

#--------------------Post Methods--------------------#

post '/replyToTweet' do
  puts("lol #{params[:tweetid]} #{params[:screen_name]}" )
  @client.update("@#{params[:screen_name]} #{params[:reply]}", :in_reply_to_status_id => params[:tweetid].to_i)
  redirect '/dashboard'
end



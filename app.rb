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
  	@tweets = @client.search("to:uber", result_type: "recent", lang: "en", geocode: "53.3,-1.5,1000km").take(2)
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
	redirect '/' unless admin?

	response.set_cookie 'tweets_cookie',
	{:fetchedTweets => @tweets, :isUsed => false}
	puts(request.cookies['tweets_cookie'])

	erb :dashboard
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
	@found = false #Boolean to see if user is already in database

	session[:loggedin] = true #User now logged in
	
    @usersTable = @db.execute %{SELECT * FROM users} #Gather all user data

    @usersTable.each do |record| #Go through each user record
        if env['omniauth.auth']['uid'] == record[0] #If uid = id then:
            @found = true #Boolean found is true (record is already there)
        end
    end
	
	#Gather user information from twitter	
	id = env['omniauth.auth']['uid'].to_s
	name = env['omniauth.auth']['info']['name'].to_s
	dateTime = Time.now.strftime("%d/%m/%Y %H:%M").to_s
	
	#Add to database if user is not found already
	if @found == false		
		@db.execute("INSERT INTO users VALUES (?, ?, ?, 0, 0)", id, name, dateTime)
	end 	
	
	#Set global variables of user information to user logged in 
	@userInfo = @db.execute("SELECT * FROM users WHERE id = ?", id)
	@id = @userInfo[0][0]
	@name = @userInfo[0][1]
	@dateTime = @userInfo[0][2]
	if @userInfo[0][3] == 1
		session[:admin] = true 
	end	
	@freeRides = @userInfo[0][4]

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

post '/fetch_tweets' do
 
  redirect '/dashboard'
end



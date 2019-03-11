#All gem requirements
require 'sinatra'
require 'omniauth-twitter'
require 'sqlite3'

set :bind, '0.0.0.0' # Only needed if you're running from Codio

#Setting up OmnuAuth-Twitter for our Twitter App
use OmniAuth::Builder do
	provider :twitter, 'wVzUO14M25jvS3vmmtfDAtmh6', 'x1hieq7QNwhbUM8wjqgl5HujELyyqmZiJUzpaWi1tQEnG8cQrX'
end

#Set up database
before do 
	@db = SQLite3::Database.new './taxi_database.sqlite'
end

#Configure sessions
configure do
	enable :sessions
end

#Setting up priviages to different parts of the website
helpers do
	def admin?
    	session[:admin]
  	end

	def loggedin?
		session[:loggedin]
	end
end

#Everyone is welcome page
get '/' do
  	"This is the public page - everybody is welcome!"
end

#Index page locked to if user is logged in
get '/index' do
  	halt(401,'Not Authorised') unless loggedin?
  	erb:index
end

#Admin page locked to users that are admins
get '/admin' do
  	halt(401,'Not Authorised') unless admin?
  	"This is the admin page"
end

#Login page redirecting to twitter autherisation
get '/login' do
  	redirect to("/auth/twitter")
end

#Logs user out
get '/logout' do
  	session[:loggedin] = nil
  	"You are now logged out"
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

	#Print welcome message
  	"<h1>#{@id}, #{@name}, #{@dateTime}, #{@freeRides} </h1>"
end

#When autherisation fails
get '/auth/failure' do
  	params[:message]
end

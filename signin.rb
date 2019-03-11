require 'sinatra'
require 'omniauth-twitter'
require 'sqlite3'

set :bind, '0.0.0.0' # Only needed if you're running from Codio

use OmniAuth::Builder do
	provider :twitter, 'wVzUO14M25jvS3vmmtfDAtmh6', 'x1hieq7QNwhbUM8wjqgl5HujELyyqmZiJUzpaWi1tQEnG8cQrX'
end

before do 
	@db = SQLite3::Database.new './taxi_database.sqlite'
end

configure do
	enable :sessions
end

helpers do
	def admin?
    	session[:admin]
  	end

	def loggedin?
		session[:loggedin]
	end
end

get '/' do
  	"This is the public page - everybody is welcome!"
end

get '/index' do
  	halt(401,'Not Authorised') unless loggedin?
  	erb:index
end

get '/admin' do
  	halt(401,'Not Authorised') unless admin?
  	"This is the admin page"
end

get '/login' do
  	redirect to("/auth/twitter")
end

get '/logout' do
  	session[:loggedin] = nil
  	"You are now logged out"
end

get '/auth/twitter/callback' do
	@found = false

	session[:loggedin] = true
	
    @usersTable = @db.execute %{SELECT * FROM users}

    @usersTable.each do |record| 
        if env['omniauth.auth']['uid'] == record[0]
            @found = true
        end
    end
	
	id = env['omniauth.auth']['uid'].to_s
	name = env['omniauth.auth']['info']['name'].to_s
	dateTime = Time.now.strftime("%d/%m/%Y %H:%M").to_s
	
	if @found == false		
		@db.execute("INSERT INTO users VALUES (?, ?, ?, 0, 0)", id, name, dateTime)
	end 	
	
	@userInfo = @db.execute("SELECT * FROM users WHERE id = ?", id)
	@id = @userInfo[0][0]
	@name = @userInfo[0][1]
	@dateTime = @userInfo[0][2]
	if @userInfo[0][3] == 1
		session[:admin] = true 
	end	
	@freeRides = @userInfo[0][4]

  	"<h1>#{@id}, #{@name}, #{@dateTime}, #{@freeRides} </h1>"
end

get '/auth/failure' do
  	params[:message]
end

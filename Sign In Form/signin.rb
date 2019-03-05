require 'erb'
require 'sinatra'
require 'sqlite3'

set :bind, '0.0.0.0' # Only needed if you're running from Codio

include ERB::Util

enable :sessions
set :session_secret, 'super secret'

before do 
	@db = SQLite3::Database.new './taxi_database.sqlite'
end


get '/' do
	redirect '/login' unless session[:logged_in]	

	erb :index
end

get '/login' do
	erb :login
end

post '/login' do
	query = %{SELECT * FROM customer}
	@results = @db.execute query
	
	@results.each do |record| 
		if params[:username] == record[0] && params[:password] == record[4]
	    	session[:logged_in] = true
	    	session[:login_time] = Time.now
	    	redirect '/'
		end
	end

	@error = "Password incorrect"

	erb :login
end

get '/logout' do
	session.clear
	erb :logout
end

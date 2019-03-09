require 'erb'
require 'sinatra'
require 'sqlite3'
require 'omniauth-twitter'

set :bind, '0.0.0.0' # Only needed if you're running from Codio

use OmniAuth::Builder do 
    provider :twitter,
    :consumer_key => wVzUO14M25jvS3vmmtfDAtmh6,
    :consumer_secret => x1hieq7QNwhbUM8wjqgl5HujELyyqmZiJUzpaWi1tQEnG8cQrX,
    #:access_token => 1092444312430919681-k6yytElynjt9A1ziskr28eHKLg580X,
    #:access_token_secret => UkK1okCoI1kFUKeofvh5Y5QQHkJyVOQxeIQGQfyCjIFQP 
end

include ERB::Util

configure do
    enable :sessions
end

helpers do 
    def customer?
        session[:customer]
    end
end

set :session_secret, 'super secret'

before do 
	@db = SQLite3::Database.open './taxi_database.sqlite'
end


    get '/' do
        redirect '/login' unless customer?

        erb :index_signin
    end

    get '/login' do
        #erb :logi
        redirect to("/auth/twitter")
    end

    #post '/login' do
       ## query = %{SELECT * FROM customer}
       # @results = @db.execute query

      #  @results.each do |record| 
         #   if params[:username] == record[0] && params[:password] == record[4]
        #        session[:customer] = true
       #         session[:login_time] = Time.now
       #         redirect '/'
       #     end
     #   end

      #  @error = "Password incorrect"

       # erb :login
    #end
    
    get '/auth/twitter/callback' do
        env['omniauth.auth'] ? session[:customer] = true :
    halt(401,'Not Authorized')
        "You are now logged in"
    end
       
    get '/auth/failure' do
        params[:message]
    end

    get '/logout' do
        session.clear
        erb :logout
    end



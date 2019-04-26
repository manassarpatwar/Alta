#--------------------Configuration and Setup--------------------#

#All gem requirements
require 'erb'
require 'sinatra'
require 'sinatra/cookies'
require 'twitter'
require 'rufus-scheduler'
require 'omniauth-twitter'
require 'sqlite3'

set :bind, '0.0.0.0' # Needed when running from Codio
include ERB::Util #Ensure ERB is enabled   WHERE city LIKE '%#{params[:search]}%'}

before do
    @db = SQLite3::Database.new './taxi_database.sqlite'
end
 
get'/userOrders' do
    
        query = %{  SELECT id, taxi_id, user_id, twitter_handle, date_time, start_location, end_location, free_ride, cancelled, rating, conversation_link
                    FROM journeys
                    WHERE id LIKE '1'}
        @results = @db.execute query
    

    erb :user_orders
end

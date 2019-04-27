require 'erb'
require 'sinatra'
require 'sinatra/cookies'
require 'twitter'
require 'rufus-scheduler'
require 'omniauth-twitter'
require 'sqlite3'
require "./login.rb"

set :bind, '0.0.0.0' # Needed when running from Codio
include ERB::Util #Ensure ERB is enabled   
# WHERE city LIKE '%#{params[:search]}%'}

 
get'/userOrders' do
        @db = SQLite3::Database.new './taxi_database.sqlite'

        query = %{SELECT * FROM journeys WHERE id LIKE '%#{h params[:search]}%' }
        @results = @db.execute query
        # @results = @db.execute("SELECT id, taxi_id, user_id, twitter_handle, date_time, start_location, end_location, free_ride, cancelled, rating, conversation_link FROM journeys WHERE '%#{h params[:search]}%' LIKE 1")
        
    erb :user_orders
end

# get'/userOrders' do
#     @db = SQLite3::Database.new './taxi_database.sqlite'
#     query = @db.prepare('SELECT start_location FROM journeys WHERE start_location LIKE ?')
#     query.bind_params("%#{h params[:searc3h]}%")
#     @results = @db.execute(query)
  
#     erb :user_orders
#   end
# get'/userOrders' do

  
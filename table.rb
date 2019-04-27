# require 'sequel'

set :bind, '0.0.0.0' # Needed when running from Codio
include ERB::Util #Ensure ERB is enabled   


get'/userOrders' do
    @db = SQLite3::Database.new './taxi_database.sqlite'

    if params[:column].nil?
        query = %{SELECT * FROM journeys}
        @results = @db.execute query
    elsif params[:column] == 'all'
        query = %{SELECT * FROM journeys}
        @results = @db.execute query
    elsif params[:column] == 'id'   
        query = %{SELECT * FROM journeys WHERE id LIKE '%#{h params[:search]}%' }
        @results = @db.execute query
    elsif params[:column] == 'date_time' 
        query = %{SELECT * FROM journeys WHERE date_time LIKE '%#{h params[:search]}%' }
        @results = @db.execute query
    elsif params[:column] == 'start_location' 
        query = %{SELECT * FROM journeys WHERE start_location LIKE '%#{h params[:search]}%' }
        @results = @db.execute query
    elsif params[:column] == 'end_location' 
        query = %{SELECT * FROM journeys WHERE end_location LIKE '%#{h params[:search]}%' }
        @results = @db.execute query
    elsif params[:column] == 'free_ride' 
        query = %{SELECT * FROM journeys WHERE free_ride LIKE '%#{h params[:search]}%' }
        @results = @db.execute query
    elsif params[:column] == 'cancelled' 
        query = %{SELECT * FROM journeys WHERE cancelled LIKE '%#{h params[:search]}%' }
        @results = @db.execute query
    elsif params[:column] == 'rating' 
        query = %{SELECT * FROM journeys WHERE rating LIKE '%#{h params[:search]}%' }
        @results = @db.execute query
    else
        puts 'Wrong'
    end
    erb :user_orders
end
    

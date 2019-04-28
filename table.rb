# require 'sequel'

set :bind, '0.0.0.0' # Needed when running from Codio
include ERB::Util #Ensure ERB is enabled   


get'/userOrders' do
    @db = SQLite3::Database.new './taxi_database.sqlite'

    if params[:column].nil? && !params[:allAlltype] && !params[:paidtype] && !params[:freetype] && !params[:cancelledtype]
        query = %{SELECT * FROM journeys WHERE twitter_handle = '%#{h session[:name]}%'}
        @results = @db.execute query
    elsif params[:column] == 'all'
        query = %{SELECT * FROM journeys WHERE twitter_handle = '%#{h session[:name]}%'}
        @results = @db.execute query
    elsif params[:column] == 'id'   
        query = %{SELECT * FROM journeys WHERE twitter_handle = '%#{h session[:name]}%' AND id LIKE '%#{h params[:search]}%'}
        @results = @db.execute query
    elsif params[:column] == 'date_time' 
        query = %{SELECT * FROM journeys WHERE twitter_handle = '%#{h session[:name]}%' AND date_time LIKE '%#{h params[:search]}%' }
        @results = @db.execute query
    elsif params[:column] == 'start_location' 
        query = %{SELECT * FROM journeys WHERE twitter_handle = '%#{h session[:name]}%' AND start_location LIKE '%#{h params[:search]}%' }
        @results = @db.execute query
    elsif params[:column] == 'end_location' 
        query = %{SELECT * FROM journeys WHERE twitter_handle = '%#{h session[:name]}%' AND end_location LIKE '%#{h params[:search]}%' }
        @results = @db.execute query
    elsif params[:column] == 'free_ride' 
        query = %{SELECT * FROM journeys WHERE twitter_handle = '%#{h session[:name]}%' AND free_ride LIKE '%#{h params[:search]}%' }
        @results = @db.execute query
    elsif params[:column] == 'cancelled' 
        query = %{SELECT * FROM journeys WHERE twitter_handle = '%#{h session[:name]}%' AND cancelled LIKE '%#{h params[:search]}%' }
        @results = @db.execute query
    elsif params[:column] == 'rating' 
        query = %{SELECT * FROM journeys WHERE twitter_handle = '%#{h session[:name]}%' AND rating LIKE '%#{h params[:search]}%' }
        @results = @db.execute query
    elsif params[:allAlltype]
        query = %{SELECT * FROM journeys WHERE twitter_handle = '%#{h session[:name]}%'}
        @results = @db.execute query
    elsif params[:paidtype]
        query = %{SELECT * FROM journeys WHERE twitter_handle = '%#{h session[:name]}%' AND free_ride LIKE 0}
        @results = @db.execute query
    elsif params[:freetype]
        query = %{SELECT * FROM journeys WHERE twitter_handle = '%#{h session[:name]}%' AND free_ride LIKE 1}
        @results = @db.execute query
    elsif params[:cancelledtype]
        query = %{SELECT * FROM journeys WHERE twitter_handle = '%#{h session[:name]}%' AND cancelled LIKE 1}
        @results = @db.execute query
    else
        puts 'Error1'
    end
    erb :user_orders
end



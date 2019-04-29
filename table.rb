# require 'sequel'

set :bind, '0.0.0.0' # Needed when running from Codio
include ERB::Util #Ensure ERB is enabled   


get'/userOrders' do
    # $db = SQLite3::Database.new './taxi_database.sqlite'

    if params[:column].nil? && !params[:allAlltype] && !params[:paidtype] && !params[:freetype] && !params[:cancelledtype]
        @results = $db.execute("SELECT * FROM journeys WHERE user_id =  '#{session[:id]}'")
    elsif params[:column] == 'all'
        @results = $db.execute("SELECT * FROM journeys WHERE user_id =  '#{session[:id]}'")
    elsif params[:column] == 'id'   
        @results = $db.execute("SELECT * FROM journeys WHERE user_id = '#{session[:id]}' AND id = '#{params[:search].strip}'") 

    elsif params[:column] == 'date_time' 
        @results = $db.execute("SELECT * FROM journeys WHERE user_id = '#{session[:id]}' AND date_time LIKE '#{params[:search].strip}'") 
    elsif params[:column] == 'start_location' 
        @results = $db.execute("SELECT * FROM journeys WHERE user_id = '#{session[:id]}' AND start_location LIKE '#{params[:search].strip}'") 
    elsif params[:column] == 'end_location' 
        @results = $db.execute("SELECT * FROM journeys WHERE user_id = '#{session[:id]}' AND end_location LIKE '#{params[:search].strip}'") 
    elsif params[:column] == 'free_ride' 
        @results = $db.execute("SELECT * FROM journeys WHERE user_id = '#{session[:id]}' AND free_ride = '#{params[:search].strip}'") 
    elsif params[:column] == 'cancelled' 
        @results = $db.execute("SELECT * FROM journeys WHERE user_id = '#{session[:id]}' AND cancelled = '#{params[:search].strip}'") 
    elsif params[:column] == 'rating' 
        @results = $db.execute("SELECT * FROM journeys WHERE user_id = '#{session[:id]}' AND rating = '#{params[:search].strip}'") 
    elsif params[:allAlltype]
        @results = $db.execute("SELECT * FROM journeys WHERE user_id = '#{session[:id]}'") 
    elsif params[:paidtype]
        @results = $db.execute("SELECT * FROM journeys WHERE user_id = '#{session[:id]}' AND free_ride = 0") 
    elsif params[:freetype]
        @results = $db.execute("SELECT * FROM journeys WHERE user_id = '#{session[:id]}' AND free_ride = 1") 
    elsif params[:cancelledtype]
        @results = $db.execute("SELECT * FROM journeys WHERE user_id = '#{session[:id]}' AND cancelled = 1") 
    else
        puts 'Error1'
    end
    erb :user_orders
end



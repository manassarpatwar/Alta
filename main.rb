#--------------------Get Methods--------------------#
#Everyone is welcome page
get '/' do
  	redirect '/index'
end

get '/index' do
    @ratings = $db.execute("SELECT * FROM complaints") 
	erb :index
end

#get '/userAccount' do
#    redirect '/index' unless session[:loggedin]
#    erb :user_account
#end

get'/userOrders' do
    redirect '/index' unless session[:loggedin]
    if params[:column].nil? && !params[:allAlltype] && !params[:paidtype] && !params[:freetype] && !params[:cancelledtype]
        @results = $db.execute("SELECT * FROM journeys WHERE user_id =  '#{session[:id]}'")
    elsif params[:column] == 'all'
        @results = $db.execute("SELECT * FROM journeys WHERE user_id =  '#{session[:id]}'")
    elsif params[:column] == 'id'   
        @results = $db.execute("SELECT * FROM journeys WHERE user_id = '#{session[:id]}' AND id LIKE '%#{params[:search].strip}%'") 
    elsif params[:column] == 'date_time' 
        @results = $db.execute("SELECT * FROM journeys WHERE user_id = '#{session[:id]}' AND date_time LIKE '%#{params[:search]}%'") 
    elsif params[:column] == 'start_location' 
        @results = $db.execute("SELECT * FROM journeys WHERE user_id = '#{session[:id]}' AND start_location LIKE '%#{params[:search].strip}%'") 
    elsif params[:column] == 'end_location' 
        @results = $db.execute("SELECT * FROM journeys WHERE user_id = '#{session[:id]}' AND end_location LIKE '%#{params[:search].strip}%'") 
    elsif params[:column] == 'free_ride' 
        @results = $db.execute("SELECT * FROM journeys WHERE user_id = '#{session[:id]}' AND free_ride LIKE '%#{params[:search].strip}%'") 
    elsif params[:column] == 'cancelled' 
        @results = $db.execute("SELECT * FROM journeys WHERE user_id = '#{session[:id]}' AND cancelled LIKE '%#{params[:search].strip}%'") 
    elsif params[:column] == 'rating' 
        @results = $db.execute("SELECT * FROM journeys WHERE user_id = '#{session[:id]}' AND rating LIKE '%#{params[:search].strip}%'") 
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

not_found do
    erb :not_found404
end
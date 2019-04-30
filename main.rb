#--------------------Get Methods--------------------#
#Everyone is welcome page
get '/' do
  	redirect '/index'
end

get '/index' do
    @ratings = $db.execute("SELECT * FROM feedback WHERE rating >= 4")
    @users = $db.execute("SELECT * FROM users") 
	erb :index
end

#get '/userAccount' do
#    redirect '/index' unless session[:loggedin]
#    erb :user_account
#end

get'/userOrders' do
    redirect '/index' unless session[:loggedin]
    if params[:search].nil? || params[:search] == "" || params[:column == "none"] then
      if params[:column] == 'all'
          @results = $db.execute("SELECT * FROM journeys WHERE user_id =  '#{session[:id]}'")
      elsif params[:allAlltype]
          @results = $db.execute("SELECT * FROM journeys WHERE user_id = '#{session[:id]}'") 
      elsif params[:paidtype]
          @results = $db.execute("SELECT * FROM journeys WHERE user_id = '#{session[:id]}' AND free_ride = 0") 
      elsif params[:freetype]
          @results = $db.execute("SELECT * FROM journeys WHERE user_id = '#{session[:id]}' AND free_ride = 1") 
      elsif params[:cancelledtype]
          @results = $db.execute("SELECT * FROM journeys WHERE user_id = '#{session[:id]}' AND cancelled = 1") 
      elsif params[:column] == "none" 
          @results = ""
      else
          puts 'Error1'
      end
    else 
       @results = $db.execute("SELECT * FROM journeys WHERE user_id = '#{session[:id]}' AND #{params[:column]} LIKE '%#{params[:search].strip}%'") 
    end
    erb :user_orders
end

not_found do
    erb :not_found404
end

post'/addRating' do
    @rating1 = params[:rating1]
    @rating2 = params[:rating2]
    @rating3 = params[:rating3]
    @rating4 = params[:rating4]
    @rating5 = params[:rating5]
end

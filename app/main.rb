#--------------------Get Methods--------------------#
#Everyone is welcome page
get '/' do
  	redirect '/index'
end

get '/index' do
    @ratings = $db.exec("SELECT * FROM feedback WHERE rating >= 4 AND journey_id IS NULL").map{|x| x.values}
    @users = $db.exec("SELECT * FROM users").map{|x| x.values}
	erb :index
end

get'/myAccount' do
    redirect '/index' unless session[:loggedin]
    @results = $db.exec("SELECT * FROM journeys WHERE user_id =  #{session[:id]}").map{|x| x.values}
    @totalRides = get_total_rides(session[:id])
    @rideDeal = $rideDeal
    @temp = @totalRides % $rideDeal
    @ridesUntilDeal = $rideDeal - @temp
    erb :myAccount
end

not_found do
    erb :not_found404
end

post'/addRating' do
    @rating = params[:rating].to_i
    @referenceNo = params[:referenceNo].to_i

    $db.exec("UPDATE journeys SET rating = '#{@rating}' WHERE id = '#{@referenceNo}' AND user_id = '#{session[:id]}'")
    redirect '/myAccount'
end

post'/addReview' do
    if params[:newReview] == "" then @nofdbk end
    @all_ok = add_feedback(params[:referenceNo], session[:id], params[:newReview], params[:generalRating]) unless @nofdbk
    erb :addReview
end

# delete account
post '/deleteAccount' do
	#execute the deletion
	$db.exec("DELETE FROM users WHERE id='#{session[:id]}'")
	redirect '/logout'
end

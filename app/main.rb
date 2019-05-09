#--------------------Get Methods--------------------#
#Everyone is welcome page
get '/' do
  	redirect '/index'
end

get '/index' do
    @ratings = $db.execute("SELECT * FROM feedback WHERE rating >= 4 AND journey_id IS NULL ")
    @users = $db.execute("SELECT * FROM users")
	erb :index
end

get'/myAccount' do
    redirect '/index' unless session[:loggedin]
    @results = $db.execute("SELECT * FROM journeys WHERE user_id =  '#{session[:id]}'")
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

    $db.execute("UPDATE journeys SET rating = '#{@rating}' WHERE id = '#{@referenceNo}' AND user_id = '#{session[:id]}'")
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
	$db.execute("DELETE FROM users WHERE id='#{session[:id]}'")
	redirect '/logout'
end

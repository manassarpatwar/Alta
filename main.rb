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
    @totalRides = 0
    @freeRides = 0
    @freeDeal = Hash.new()
    @results = $db.execute("SELECT * FROM journeys WHERE user_id =  '#{session[:id]}'")
    @db2 = $db.execute("SELECT * FROM journeys WHERE user_id =  '#{session[:id]}' AND free_ride = 0")
    @db3 = $db.execute("SELECT * FROM journeys WHERE user_id =  '#{session[:id]}' AND free_ride = 1")

    @db2.each do |ride|
        @totalRides+=1
    end
    @db3.each do |ride|
        @freeRides+=1
    end

    @temp = @totalRides % $rideDeal
    @ridesUntilDeal = $rideDeal - @temp
    @percentageDeal = (@totalRides.to_f / $rideDeal.to_f)*100

    @freeDeal["Rides Until Deal"] = @ridesUntilDeal
    # @freeDeal["You need"] = $rideDeal
    erb :user_orders
end

not_found do
    erb :not_found404
end

post'/addRating' do
    @rating = params[:rating].to_i
    @referenceNo = params[:referenceNo].to_i

    $db.execute("UPDATE journeys SET rating = '#{@rating}' WHERE id = '#{@referenceNo}' AND user_id = '#{session[:id]}'")
    # puts params[:rating]
    puts params[:referenceNo]
    redirect '/userOrders'
end

post'/addReview' do
    add_feedback(params[:referenceNo].to_i, session[:id], params[:newReview], params[:generalRating])
    redirect '/userOrders'
end

# delete account
post '/deleteAccount/' do
	#execute the deletion
	$db.execute("DELETE FROM users WHERE id='#{session[:id]}'")
	redirect '/'
end

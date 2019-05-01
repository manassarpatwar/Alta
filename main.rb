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
    @totalRides = 0
    @freeRides = 0
    @cancelledRides = 0
    @db2 = $db.execute("SELECT * FROM journeys WHERE user_id =  '#{session[:id]}' AND free_ride = 0")
    @db3 = $db.execute("SELECT * FROM journeys WHERE user_id =  '#{session[:id]}' AND free_ride = 1")
    @db4 = $db.execute("SELECT * FROM journeys WHERE user_id =  '#{session[:id]}' AND cancelled = 1")

    @db2.each do |ride|
        @totalRides+=1
    end
    @db3.each do |ride|
        @freeRides+=1
    end
    @db4.each do |ride|
        @cancelledRides+=1
    end

    @temp = @totalRides % $rideDeal
    @ridesUntilDeal = $rideDeal - @temp

    redirect '/index' unless session[:loggedin]
    if params[:search].nil? || params[:search] == "" || params[:column == "none"] then
        @results = $db.execute("SELECT * FROM journeys WHERE user_id =  '#{session[:id]}'")
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
    @rating = params[:rating].to_i
    @referenceNo = params[:referenceNo].to_i
    
    $db.execute("UPDATE journeys SET rating = '#{@rating}' WHERE id = '#{@referenceNo}' AND user_id = '#{session[:id]}'")
    # puts params[:rating]
    puts params[:referenceNo]
    redirect '/userOrders'
end

post'/addReview' do
    @feedback = params[:newReview]
    @date_time = Time.now.strftime("%Y/%m/%d %H:%M").to_s
    # @rating = 0
    @journey_id = params[:referenceNo].to_i
    @rating  = params[:generalRating]
    # @generalFeedBack = params[:generalFeedBack]


    #get feedback table from the database
	@feedbackInfo = $db.execute("SELECT * FROM feedback")

    @submitted = true

    @feedback_ok = !@feedback.nil? && @feedback != ""

	@id = @feedbackInfo[@feedbackInfo.length-1][0].to_i + 1

    # add data to the database
    if @feedback_ok
		# do the insert
        $db.execute('INSERT INTO feedback VALUES (?, ?, ?, ?, ?, ?)', [@id, @journey_id, session[:id], @date_time, @feedback, @rating])
    end
     

    redirect '/userOrders'
end

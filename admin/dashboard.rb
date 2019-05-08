#--------------------Get Methods--------------------#
get '/dashboard' do
    redirect '/index' unless session[:admin]
    gather_taxis(session[:admin_city]) 
    @submitted = false
    @tweets = $tweets.dup
    erb :dashboard
end
#--------------------Post Methods--------------------#

post '/replyToTweet' do
    index = (params[:tweetindex]).to_i
    begin
        if(params[:reply] != "")
            $tweets[index] = TWITTER_CLIENT.update("@#{params[:screen_name]} #{params[:reply]}", :in_reply_to_status_id => params[:tweetid].to_i)
        end
    rescue Twitter::Error::TooManyRequests => error
        @error = "Too many requests."
        sleep error.rate_limit.reset_in
    end
    @tweets = $tweets.dup
    erb :tweetActions
end

post '/destroyTweet' do
    index = (params[:tweetindex]).to_i
    begin
        TWITTER_CLIENT.destroy_status($tweets[index].uri)
        unless $tweets[index].in_reply_to_status_id.nil?
          $tweets[index] = TWITTER_CLIENT.status($tweets[index].in_reply_to_status_id)
        end
    rescue Twitter::Error::TooManyRequests => error
        @error = "Too many requests."
        sleep error.rate_limit.reset_in
    end
    @tweets = $tweets.dup
    erb :tweetActions
end


post '/fetchTweets' do
    if $tweets.length > 0
        $since_id = $tweets[0].id
    end
    begin
        @noNewTweets = false
        tweetsLenBefore = $tweets.length()
        $tweets = TWITTER_CLIENT.mentions_timeline(count: "5", since_id: "#{$since_id}") + $tweets
        tweetsLenAfter = $tweets.length()
        if tweetsLenBefore == tweetsLenAfter then
          @noNewTweets = true
        else
          @newTweets = tweetsLenAfter - tweetsLenBefore
        end
    rescue Twitter::Error::TooManyRequests => error
        sleep error.rate_limit.reset_in
        puts "Too many requests. Try again in #{error.rate_limit.reset_in} seconds"
    end
    @tweets = $tweets.dup
    erb :tweetActions
end


post '/deleteTweet' do
    $since_id = $tweets[0].id
    index = (params[:tweetindex]).to_i
    $tweets.delete($tweets[index])
    begin
        $tweets =  TWITTER_CLIENT.mentions_timeline(count: "1", since_id: "#{$since_id}") + $tweets
    rescue Twitter::Error::TooManyRequests => error
        sleep error.rate_limit.reset_in
        puts "Too many requests. Try again in #{error.rate_limit.reset_in} seconds"
    end
    @tweets = $tweets.dup
    erb :tweetActions
end

post '/addJourney' do
	redirect '/index' unless session[:admin]

	#get journey table from the database

    @submitted = true

    #sanitize values
	@taxiId = params[:taxiId].strip
	@userId = params[:userId].strip
	@twitterHandle = params[:twitterHandle].strip
	@dateTime = params[:dateTime].strip
	@startLocation = params[:startLocation].strip
	@endLocation = params[:endLocation].strip
	@freeRide = params[:freeRide].strip
	@cancelled = params[:cancelled].strip
	@rating = params[:rating].strip
	@convoLink = params[:convoLink].strip

	# perform validation
	#taxiID and userID and twitterHandle needs better validation!!!!!
	@taxiId_ok = isPositiveNumber?(@taxiId)
	@userId_ok = !@userId.nil? && @userId != ""
	@twitterHandle_ok = !@twitterHandle.nil? && @twitterHandle != ""
	@dateTime_ok = !@dateTime.nil? && @dateTime != ""
	@startLocation_ok = !@startLocation.nil? && @startLocation != ""
	@endLocation_ok = !@endLocation.nil? && @endLocation != ""
	@freeRide_ok = @freeRide == '0' || @freeRide == '1'
	@cancelled_ok = @cancelled == '0' || @cancelled == '1'
	@rating_ok = @rating == '0' || @rating == '1' || @rating == '2' || @rating == '3' || @rating == '4' || @rating == '5'
	@convoLink_ok =	!@convoLink.nil? && @convoLink != ""

	@all_ok = @taxiId_ok && @userId_ok && @twitterHandle_ok && @dateTime_ok && @startLocation_ok && @endLocation_ok && @freeRide_ok && @cancelled_ok && @rating_ok && @convoLink_ok

  	# add data to the database
	if @all_ok
        $db.execute('INSERT INTO journeys VALUES (?, ?, ?, ?, ?, ? ,?, ?, ?, ?, ?)', [@id, @taxiId, @userId, @twitterHandle, @dateTime, @startLocation, @endLocation, @freeRide, @cancelled, @rating, @convoLink])
        @userInfo = $db.execute("SELECT * FROM users WHERE id = #{@userId}") #Gather all user data
        if @userInfo.size > 0 #If uid = id then:
           if @freeRide == '1' then
             $db.execute("UPDATE users SET free_rides = #{@userInfo[0][4]-1}  WHERE id='#{@userId}'")
           elsif (get_total_rides(@userId)) % $rideDeal == 0 && @freeRide == '0' then
             $db.execute("UPDATE users SET free_rides = #{@userInfo[0][4]+1}  WHERE id='#{@userId}'")
           end
        end
  	end
    erb :addJourney
end

post '/addToAvailable' do
    taxiId = params[:taxiId].to_i
    $db.execute("UPDATE taxis SET available = 1 WHERE id='#{taxiId}'")
    gather_taxis(session[:admin_city])
    erb :displayTaxis
end

post '/addToUnavailable' do
    taxiId = params[:taxiId].to_i
    $db.execute("UPDATE taxis SET available = 0 WHERE id='#{taxiId}'")
    gather_taxis(session[:admin_city])
    erb :displayTaxis
end

post '/handleDeletedTweet' do
    index = (params[:tweetindex]).to_i
    $tweets.delete($tweets[index])
end

post '/fillInfoInJourney' do
    gather_taxis(session[:admin_city])
    @noAvailableTaxis = false
    if !@availableTaxis[0].nil?
	 @taxiId = @availableTaxis[0][0]
    else
     @noAvailableTaxis = true
    end
	@userId = params[:userId]
	@twitterHandle = params[:twitterHandle]
    @convoLink = params[:convoLink]
    @dateTime = Time.now.strftime("%Y/%m/%d %H:%M").to_s
    @usersTable = $db.execute %{SELECT * FROM users} #Gather all user data
    @usersTable.each do |record| #Go through each user record
        if @userId == record[0] #If uid = id then:
           @userInfo = $db.execute("SELECT * FROM users WHERE id = ?", @userId)
           if @userInfo[0][4] != 0 then
             @freeRide = 1
           else
             @freeRide = 0
           end
        end
    end
    @cancelled = 0
	@convoLink = params[:convoLink].strip
    erb :addJourney
end

#--------------------Get Methods--------------------#
get '/dashboard' do
    redirect '/index' unless session[:admin]
    @submitted = false
    @tweets = $tweets.dup
    @availableTaxis = $avTaxis.dup
    @unavailableTaxis = $unavTaxis.dup
	erb :dashboard
end

get '/settings' do
  redirect '/index' unless session[:admin]
  @submitted = false
  erb :settings
end
#--------------------Post Methods--------------------#

post '/replyToTweet' do
    begin
      if(params[:reply] != "")
          replytweet = TWITTER_CLIENT.update("@#{params[:screen_name]} #{params[:reply]}", :in_reply_to_status_id => params[:tweetid].to_i)
      end
    rescue Twitter::Error::TooManyRequests => error
      sleep error.rate_limit.reset_in
      puts "Too many requests. Try again in #{error.rate_limit.reset_in} seconds"
    end
    @tweets = $tweets.dup
    erb :tweetActions
end

post '/fetchTweets' do
    if $tweets.length > 0
      $since_id = $tweets[0].id
    end
    begin
      $tweets =  TWITTER_CLIENT.mentions_timeline(count: "5", since_id: "#{$since_id}") + $tweets
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
	@submitted = true
	# sanitize values
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
	@freeRide_ok = @freeRide = '0' || @freeRide = '1'
 	@cancelled_ok = @cancelled = '0' || @cancelled = '1'
	@convoLink_ok =	!@convoLink.nil? && @convoLink != ""

	@all_ok = @taxiId_ok && @userId_ok && @twitterHandle_ok && @dateTime_ok && @startLocation_ok && @endLocation_ok && @freeRide_ok && @cancelled_ok && @convoLink_ok

	count = $db.get_first_value('SELECT COUNT(*) FROM journeys')
	@id = count + 1

  	# add data to the database
	if @all_ok
    	# do the insert
		$db.execute('INSERT INTO journeys VALUES (?, ?, ?, ?, ?, ? ,?, ?, ?, ?, ?)', [@id, @taxiId, @userId, @twitterHandle, @dateTime, @startLocation, @endLocation, @freeRide, @cancelled, @rating, @convoLink])
  	end
    erb :addJourney
end

post '/addToAvailable' do
    taxiIndex = params[:taxiIndex].to_i
    $avTaxis.push($unavTaxis[taxiIndex])
    $unavTaxis.delete($unavTaxis[taxiIndex])
    @availableTaxis = $avTaxis.dup
    @unavailableTaxis = $unavTaxis.dup
    erb :displayTaxis
end

post '/addToUnavailable' do
    taxiIndex = params[:taxiIndex].to_i
    $unavTaxis.push($avTaxis[taxiIndex])
    $avTaxis.delete($avTaxis[taxiIndex])
    @availableTaxis = $avTaxis.dup
    @unavailableTaxis = $unavTaxis.dup
   erb :displayTaxis
end

post '/handleDeletedTweet' do
  $tweets.each do |deletedTweet|
      begin
          TWITTER_CLIENT.status(deletedTweet.uri) == deletedTweet
      rescue Twitter::Error::NotFound => err
          $tweets.delete(deletedTweet)
      rescue Twitter::Error::TooManyRequests => error
        sleep error.rate_limit.reset_in
        puts "Too many requests. Try again in #{error.rate_limit.reset_in} seconds"
      end
  end
    @tweets = $tweets.dup
    erb :tweetActions
end

require 'erb'
require 'sinatra'
require 'sqlite3'

set :bind, '0.0.0.0' # Only needed if you're running from Codio

include ERB::Util

before do
	@db = SQLite3::Database.new('./taxi_database.sqlite')
end

get '/add' do
	@submitted = false
	erb :addJourney
end

post '/add' do
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

	count = @db.get_first_value('SELECT COUNT(*) FROM journeys')
	@id = count + 1

  	# add data to the database
	if @all_ok
    	# do the insert
		@db.execute('INSERT INTO journeys VALUES (?, ?, ?, ?, ?, ? ,?, ?, ?, ?, ?)', [@id, @taxiId, @userId, @twitterHandle, @dateTime, @startLocation, @endLocation, @freeRide, @cancelled, @rating, @convoLink])
  	end
	erb :addJourney
end

def isPositiveNumber? string
	begin
		Float(string)
		int = string.to_i 
		puts "Not fail"
		if int >= 0
			return true
		else
			return false
		end
	rescue 
		puts "fail"
		return false
	end
end



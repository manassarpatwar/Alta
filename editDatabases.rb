#---------------get settings---------------#

get '/settings' do
    redirect '/index' unless session[:admin]

	@usersInfo = $db.execute("SELECT * FROM users")
	@journeyInfo = $db.execute("SELECT * FROM journeys")
	@complatintsInfo = $db.execute("SELECT * FROM complaints")
	@taxiInfo = $db.execute("SELECT * FROM taxis")

    erb :settings
end

#---------------get delete---------------#
# delete user
get '/deleteUser/:id' do
	redirect '/index' unless session[:admin]

	#set id to be deleted
	@id = params[:id]
	#execute the deletion
	$db.execute("DELETE FROM users WHERE id='#{@id}'")

	redirect '/settings'
end

# delete taxi
get '/deleteTaxi/:id' do
	redirect '/index' unless session[:admin]

	#set id to be deleted
	@id = params[:id]
	#execute the deletion
	$db.execute("DELETE FROM taxis WHERE id='#{@id}'")

	redirect '/settings'
end

# delete complaint
get '/deleteComplaint/:id' do
	redirect '/index' unless session[:admin]

	#set id to be deleted
	@id = params[:id]
	#execute the deletion
	$db.execute("DELETE FROM complaints WHERE id='#{@id}'")

	redirect '/settings'
end

# delete complaint
get '/deleteJourney/:id' do
	redirect '/index' unless session[:admin]

	#set id to be deleted
	@id = params[:id]
	#execute the deletion
	$db.execute("DELETE FROM journeys WHERE id='#{@id}'")

	redirect '/settings'
end

#---------------get edit---------------#
# edit user
get '/editUser/:id' do
	redirect '/index' unless session[:admin]

	#get users table and journey table from the database
	@usersInfo = $db.execute("SELECT * FROM users")
	@journeyInfo = $db.execute("SELECT * FROM journeys")

	#find user which has the ID given
	@usersInfo.each do |user|
		if user[0] == params[:id]
			@userToEdit = user
		end
	end

	#submitted is false
	@submitted = false

	#setting all the variables to various values from the table
	@id = params[:id]
	@name = @userToEdit[1]
	@dateTime = @userToEdit[2]
	@userType = @userToEdit[3]
	@freeRide = @userToEdit[4]
    @totalRides = @userToEdit[5]

	erb :editUserMain
end

# edit taxi
get '/editTaxi/:id' do
	redirect '/index' unless session[:admin]

	#get taxi table and journey table from the database
	@taxiInfo = $db.execute("SELECT * FROM taxis")

	#find taxi which has the ID given
	@taxiInfo.each do |taxi|
		if taxi[0] == params[:id].to_i
			@taxiToEdit = taxi
		end
	end

	#submitted is false
	@submitted = false

	#setting all the variables to various values from the table
	@id = params[:id].to_i
	@regNum = @taxiToEdit[1]
	@contact = @taxiToEdit[2]
	@taxiType = @taxiToEdit[3]
	@city = @taxiToEdit[4]
    @available = @taxiToEdit[5]

	erb :editTaxiMain
end

# edit complaint
get '/editComplaint/:id' do
	redirect '/index' unless session[:admin]

	#get complaints table from the database
	@complatintsInfo = $db.execute("SELECT * FROM complaints")

	#find user which has the ID given
	@complatintsInfo.each do |complaint|
		if complaint[0] == params[:id].to_i
			@complaintToEdit = complaint
		end
	end

	#submitted is false
	@submitted = false

	#setting all the variables to various values from the table
	@id = params[:id]
	@journey_id = @complaintToEdit[1]
	@user_id = @complaintToEdit[2]
	@date_time = @complaintToEdit[3]
	@complaint = @complaintToEdit[4]

	erb :editComplaintMain
end

# edit journey
get '/editJourney/:id' do
	redirect '/index' unless session[:admin]

	#get complaints table from the database
	@journeyInfo = $db.execute("SELECT * FROM journeys")
	@id = params[:id].to_i

	#find user which has the ID given
	@journeyInfo.each do |journey|
		if journey[0] == @id
			@journeyToEdit = journey
		end
	end

	#submitted is false
	@submitted = false

	#sanitize values
	@taxiId = @journeyToEdit[1]
	@userId = @journeyToEdit[2]
	@twitterHandle = @journeyToEdit[3]
	@dateTime = @journeyToEdit[4]
	@startLocation = @journeyToEdit[5]
	@endLocation = @journeyToEdit[6]
	@freeRide = @journeyToEdit[7]
	@cancelled = @journeyToEdit[8]
	@rating = @journeyToEdit[9]
	@convoLink = @journeyToEdit[10]

	erb :editJourneyMain
end

#---------------post edit---------------#
# edit user
post '/editUser/:id' do
	redirect '/index' unless session[:admin]

	#get users table and journey table from the database
	@usersInfo = $db.execute("SELECT * FROM users")
	@journeyInfo = $db.execute("SELECT * FROM journeys")

	#find user which has the ID given
	@usersInfo.each do |user|
		if user[0] == params[:id]
			@userToEdit = user
		end
	end

	#submitted is true
	@submitted = true

	#setting all the variables to paramaters given
	@id = params[:id]
	@name = params[:name].strip
	@dateTime = params[:dateTime]
	@userType = params[:userType].strip
	@freeRide = params[:freeRide].strip
    @totalRides = params[:totalRides].strip

	# perform validation
	@name_ok = !@name.nil? && @name != ""
	@dateTime_ok = !@dateTime.nil? && @dateTime != ""
	if @userType == "2" || @userType == "1" || @userType == "0"
		@userType_ok = true
	else
		@userType_ok = false
	end
	@freeRide_ok = isPositiveNumber?(@freeRide)
	@totalRide_ok = isPositiveNumber?(@freeRide)

	@all_ok = @name_ok && @dateTime_ok && @userType_ok && @freeRide_ok && @totalRide_ok

  	# add data to the database
	if @all_ok
		# do the edit
		$db.execute("UPDATE users SET name = '#{@name}' WHERE id='#{@id}'")
    	$db.execute("UPDATE users SET signup_date = '#{@dateTime}' WHERE id='#{@id}'")
		$db.execute("UPDATE users SET user_type = '#{@userType}' WHERE id='#{@id}'")
		$db.execute("UPDATE users SET free_rides = '#{@freeRide}' WHERE id='#{@id}'")
		$db.execute("UPDATE users SET total_rides = '#{@totalRides}' WHERE id='#{@id}'")
  	end

	erb :editUserMain
end

# edit taxi
post '/editTaxi/:id' do
	redirect '/index' unless session[:admin]

	#get taxi table and journey table from the database
	@taxiInfo = $db.execute("SELECT * FROM taxis")

	#find taxi which has the ID given
	@taxiInfo.each do |taxi|
		if taxi[0] == params[:id].to_i
			@taxiToEdit = taxi
		end
	end

	#submitted is false
	@submitted = true

	#setting all the variables to various values from the table
	@id = params[:id].to_i
	@regNum = params[:regNum].strip
    @contact = params[:contact].strip
	@taxiType = params[:taxiType].strip.upcase
    @city = params[:city].strip.upcase

	# perform validation
    @regNum_ok = !@regNum.nil? && @regNum != ""
    @contact_ok = !@contact.nil? && @contact != ""
    @city_ok = !@city.nil? && @city != "" && (@city == "SHEFFIELD" || @city == "MANCHESTER")
    if @taxiType == "S" || @taxiType == "M" || @taxiType == "L"
        @taxiType_ok = true
    else
        @taxiType_ok = false
    end
    @regNum_unique = true
    @contact_unique = true

    @taxiInfo.each do |taxi| #Go through each user record
        if taxi[1] == @regNum && taxi != @taxiToEdit #If uid = id then:
            @regNum_unique = false #Boolean found is true (record is already there)
        end
        if taxi[2] == @contact && taxi != @taxiToEdit
          @contact_unique = false
        end
    end

    @all_ok = @regNum_ok && @contact_ok && @taxiType_ok && @city_ok && @regNum_unique && @contact_unique

	if @all_ok
		# do the edit
		$db.execute("UPDATE taxis SET reg_num = '#{@regNum}' WHERE id='#{@id}'")
    	$db.execute("UPDATE taxis SET contact_num = '#{@contact}' WHERE id='#{@id}'")
		$db.execute("UPDATE taxis SET taxi_type = '#{@taxiType}' WHERE id='#{@id}'")
		$db.execute("UPDATE taxis SET city = '#{@city}' WHERE id='#{@id}'")
  	end

	erb :editTaxiMain
end

# edit complaint
post '/editComplaint/:id' do
	redirect '/index' unless session[:admin]

	#get complaints table from the database
	@complatintsInfo = $db.execute("SELECT * FROM complaints")

	#find user which has the ID given
	@complatintsInfo.each do |complaint|
		if complaint[0] == params[:id].to_i
			@complaintToEdit = complaint
		end
	end

	#submitted is false
	@submitted = true

	#setting all the variables to various values from the table
	@id = params[:id]
	@journey_id = params[:journey_id]
    @user_id = params[:user_id]
    @date_time = params[:date_time]
    @complaint = params[:complaint]

	# perform validation
    @journey_id_ok = isPositiveNumber? (@journey_id)
    @complaint_ok = !@complaint.nil? && @complaint != ""
    @user_id_ok = !@user_id.nil? && @user_id != ""
	@date_time_ok = !@date_time.nil? && @date_time != ""

    @all_ok = @journey_id_ok && @complaint_ok && @user_id_ok && @date_time_ok

    # add data to the database
    if @all_ok# do the insert
		$db.execute("UPDATE complaints SET journey_id = '#{@journey_id}' WHERE id='#{@id}'")
		$db.execute("UPDATE complaints SET user_id = '#{@user_id}' WHERE id='#{@id}'")
		$db.execute("UPDATE complaints SET date_time = '#{@date_time}' WHERE id='#{@id}'")
		$db.execute("UPDATE complaints SET complaint = '#{@complaint}' WHERE id='#{@id}'")
	end

	erb :editComplaintMain
end

# edit journey
post '/editJourney/:id' do
	redirect '/index' unless session[:admin]

	#get complaints table from the database
	@journeyInfo = $db.execute("SELECT * FROM journeys")
	@id = params[:id].to_i

	#find user which has the ID given
	@journeyInfo.each do |journey|
		if journey[0] == @id
			@journeyToEdit = journey
		end
	end

	#submitted is false
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
	@rating_ok = @rating == '' || @rating == '0' || @rating == '1' || @rating == '2' || @rating == '3' || @rating == '4' || @rating == '5'
	@convoLink_ok =	!@convoLink.nil? && @convoLink != ""

	@all_ok = @taxiId_ok && @userId_ok && @twitterHandle_ok && @dateTime_ok && @startLocation_ok && @endLocation_ok && @freeRide_ok && @cancelled_ok && @rating_ok && @convoLink_ok

    # add data to the database
    if @all_ok# do the insert
		$db.execute("UPDATE journeys SET taxi_id = '#{@taxiId}' WHERE id='#{@id}'")
		$db.execute("UPDATE journeys SET user_id = '#{@userId}' WHERE id='#{@id}'")
		$db.execute("UPDATE journeys SET twitter_handle = '#{@twitterHandle}' WHERE id='#{@id}'")
		$db.execute("UPDATE journeys SET date_time = '#{@dateTime}' WHERE id='#{@id}'")
		$db.execute("UPDATE journeys SET start_location = '#{@startLocation}' WHERE id='#{@id}'")
		$db.execute("UPDATE journeys SET end_location = '#{@endLocation}' WHERE id='#{@id}'")
		$db.execute("UPDATE journeys SET free_ride = '#{@freeRide}' WHERE id='#{@id}'")
		$db.execute("UPDATE journeys SET cancelled = '#{@cancelled}' WHERE id='#{@id}'")
		$db.execute("UPDATE journeys SET rating = '#{@rating}' WHERE id='#{@id}'")
		$db.execute("UPDATE journeys SET conversation_link = '#{@convoLink}' WHERE id='#{@id}'")
	end

	erb :editJourneyMain
end


#---------------get add---------------#
# add user
get '/addUser' do
	redirect '/index' unless session[:admin]

	erb :addUserMain
end

# add taxi
get '/addTaxi' do
	redirect '/index' unless session[:admin]

	erb :addTaxiMain
end

# add complaint
get '/addComplaint' do
	redirect '/index' unless session[:admin]

	erb :addComplaintMain
end

# add journey
get '/addJourney' do
	redirect '/index' unless session[:admin]

	erb :addJourneySettingsMain
end

#---------------post add---------------#
# add user
post '/addUser' do
	redirect '/index' unless session[:admin]

	@submitted = true

	# sanitise values
	@id = params[:id].strip
	@name = params[:name].strip
	@dateTime = params[:dateTime]
	@userType = params[:userType].strip
	@freeRide = params[:freeRide].strip
    @total_rides = 0

	# perform validation
	@id_ok = !@id.nil? && @id != ""
	@name_ok = !@name.nil? && @name != ""
	@dateTime_ok = !@dateTime.nil? && @dateTime != ""
	if @userType == "2" || @userType == "1" || @userType == "0"
		@userType_ok = true
	else
		@userType_ok = false
	end
	@freeRide_ok = isPositiveNumber?(@freeRide)

	@all_ok = @id_ok && @name_ok && @dateTime_ok && @userType_ok && @freeRide_ok

  	# add data to the database
	if @all_ok
    	# do the insert
		$db.execute('INSERT INTO users VALUES (?, ?, ?, ?, ?, ?)', [@id, @name, @dateTime, @userType.to_i, @freeRide.to_i, @total_rides.to_i])
  	end
	erb :addUserMain
end

# add taxi
post '/addTaxi' do
	redirect '/index' unless session[:admin]

    @submitted = true
    @taxiInfo= $db.execute %{SELECT * FROM taxis} #Gather all user data

    #sanitize values
    @regNum = params[:regNum].strip
    @contact = params[:contact].strip
    @city = params[:city].strip.upcase
    @taxiType = params[:taxiType].strip.upcase
	@available = 1

	# perform validation
    @regNum_ok = !@regNum.nil? && @regNum != ""
    @contact_ok = !@contact.nil? && @contact != ""
    @city_ok = !@city.nil? && @city != "" && (@city == "SHEFFIELD" || @city == "MANCHESTER")
    if @taxiType == "S" || @taxiType == "M" || @taxiType == "L"
        @taxiType_ok = true
    else
        @taxiType_ok = false
    end
    @regNum_unique = true
    @contact_unique = true

    @taxiInfo.each do |taxi| #Go through each user record
        if taxi[1] == @regNum #If uid = id then:
            @regNum_unique = false #Boolean found is true (record is already there)
        end
        if taxi[2] == @contact
          @contact_unique = false
        end
    end

    @all_ok = @regNum_ok && @contact_ok && @taxiType_ok && @city_ok && @regNum_unique && @contact_unique

	@id = @taxiInfo[@taxiInfo.length-1][0].to_i + 1


    # add data to the database
    if @all_ok
		# do the insert
        $db.execute('INSERT INTO taxis VALUES (?, ?, ?, ?, ?, ?)', [@id, @regNum, @contact, @taxiType, @city, @available])
    end
    erb :addTaxiMain
end

# add complaint
post '/addComplaint' do
	redirect '/index' unless session[:admin]

	#get complaints table from the database
	@complatintsInfo = $db.execute("SELECT * FROM complaints")

    @submitted = true

    #sanitize values
    @journey_id = params[:journey_id]
    @user_id = params[:user_id]
    @date_time = Time.now.strftime("%d/%m/%Y %H:%M").to_s
    @complaint = params[:complaint]

    # perform validation
    @journey_id_ok = isPositiveNumber? (@journey_id)
    @complaint_ok = !@complaint.nil? && @complaint != ""
    @user_id_ok = !@user_id.nil? && @user_id != ""

    @all_ok = @journey_id_ok && @complaint_ok && @user_id_ok

	@id = @complaintsInfo[@complaintsInfo.length-1][0].to_i + 1

    # add data to the database
    if @all_ok
		# do the insert
        $db.execute('INSERT INTO complaints VALUES (?, ?, ?, ?, ?)', [@id, @journey_id, @user_id, @date_time, @complaint])
    end
    erb :addComplaintMain
end

# add journey
post '/addJourney' do
	redirect '/index' unless session[:admin]

	#get journey table from the database
	@journeyInfo = $db.execute("SELECT * FROM journeys")

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
	@rating_ok = @rating == '' || @rating == '0' || @rating == '1' || @rating == '2' || @rating == '3' || @rating == '4' || @rating == '5'
	@convoLink_ok =	!@convoLink.nil? && @convoLink != ""

	@all_ok = @taxiId_ok && @userId_ok && @twitterHandle_ok && @dateTime_ok && @startLocation_ok && @endLocation_ok && @freeRide_ok && @cancelled_ok && @rating_ok && @convoLink_ok

	@id = @journeyInfo[@journeyInfo.length-1][0].to_i + 1
    # add data to the database
    if @all_ok
		# do the insert
		$db.execute('INSERT INTO journeys VALUES (?, ?, ?, ?, ?, ? ,?, ?, ?, ?, ?)', [@id, @taxiId, @userId, @twitterHandle, @dateTime, @startLocation, @endLocation, @freeRide, @cancelled, @rating, @convoLink])
    end

	erb :addJourneySettingsMain
end

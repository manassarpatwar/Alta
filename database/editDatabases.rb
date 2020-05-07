#---------------get settings---------------#

get '/settings' do
    # only show page if admin
    redirect '/index' unless session[:admin]
    # gather data for users, journeys, feedback and taxis
	@usersInfo = $db.exec("SELECT * FROM users").map{|x| x.values}
	@journeyInfo = $db.exec("SELECT * FROM journeys").map{|x| x.values}
	@feedbackInfo = $db.exec("SELECT * FROM feedback").map{|x| x.values}
	@taxiInfo = $db.exec("SELECT * FROM taxis").map{|x| x.values}
    # set current local ride deal to current global ride deal
    @rideDeal = $rideDeal
    erb :settings
end

#---------------post delete & ride deal---------------#

post '/rideDeal' do
    # only show page if admin
    redirect '/index' unless session[:admin]
    @submitted = true
    @rd = params[:rideDeal] # purposed new ride deal

    @rideDeal_ok = isPositiveNumber?(@rd) # if new ride deal is a positive number then true
    if @rideDeal_ok then
      $rideDeal = @rd.to_i # replace ride deal with new set number
    end
    @rideDeal = $rideDeal
    erb :rideDeal
end

post '/deleteFromTable' do
    # only show page if admin
	redirect '/index' unless session[:admin]

	# set table and id to be deleted
    @table = params[:table]
	@id = params[:id]
	#execute the deletion
	$db.exec("DELETE FROM #{@table} WHERE id=#{@id}")

	redirect '/settings'
end

#---------------get edit---------------#
# edit user
get '/editUser/:id' do
    # only show page if admin
	redirect '/index' unless session[:admin]

	# get users table and journey table from the database
	@userToEdit =  get_entry(params[:id], "users")
    if @userToEdit.nil? then redirect '/404' end

	@submitted = false

	# setting all the variables to various values from the table
	@id = params[:id]
	@name = @userToEdit[1]
	@dateTime = @userToEdit[2]
	@userType = @userToEdit[3]
	@freeRide = @userToEdit[4]

	erb :editUserMain
end

# edit taxi
get '/editTaxi/:id' do
    # only show page if admin
	redirect '/index' unless session[:admin]

	# get taxi table and journey table from the database
	@taxiToEdit =  get_entry(params[:id], "taxis")
    if @taxiToEdit.nil? then redirect '/404' end

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

# edit feedback
get '/editFeedback/:id' do
    # only show page if admin
	redirect '/index' unless session[:admin]

	# get feedback from the database
	@feedbackToEdit = get_entry(params[:id], "feedback")
    if @feedbackToEdit.nil? then redirect '/404' end
	@submitted = false

	# setting all the variables to various values from the table
	@id = params[:id]
	@journey_id = @feedbackToEdit[1]
	@user_id = @feedbackToEdit[2]
	@date_time = @feedbackToEdit[3]
	@feedback = @feedbackToEdit[4]
    @rating = @feedbackToEdit[5]

	erb :editFeedbackMain
end

# edit journey
get '/editJourney/:id' do
    # only show page if admin
	redirect '/index' unless session[:admin]

	# get feedback table from the database
	@journeyToEdit = get_entry(params[:id], "journeys")
    if @journeyToEdit.nil? then redirect '/404' end
        
	@id = params[:id].to_i

	@submitted = false

	# setting all the variables to various values from the table
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
    # only show page if admin
	redirect '/index' unless session[:admin]

	# get users table and journey table from the database
	@userToEdit = get_entry(params[:id], "users")

	@submitted = true

	# setting all the variables to paramaters given
	@id = params[:id]
	@name = params[:name]
	@dateTime = params[:dateTime]
	@userType = params[:userType]
	@freeRide = params[:freeRide]

	# perform validation
	@name_ok = !@name.nil? && @name != ""
	@dateTime_ok = !@dateTime.nil? && @dateTime != ""
	if @userType == "2" || @userType == "1" || @userType == "0"
		@userType_ok = true
	else
		@userType_ok = false
	end
	@freeRide_ok = isPositiveNumber?(@freeRide)

	@all_ok = @name_ok && @dateTime_ok && @userType_ok && @freeRide_ok

  	# add data to the database
	if @all_ok
		# do the edit
		$db.exec("UPDATE users SET name = '#{@name}' WHERE id='#{@id}'")
    	$db.exec("UPDATE users SET signup_date = '#{@dateTime}' WHERE id='#{@id}'")
		$db.exec("UPDATE users SET user_type = '#{@userType}' WHERE id='#{@id}'")
		$db.exec("UPDATE users SET free_rides = '#{@freeRide}' WHERE id='#{@id}'")
  	end

	erb :editUserMain
end

# edit taxi
post '/editTaxi/:id' do
    # only show page if admin
	redirect '/index' unless session[:admin]

	# get taxi table and journey table from the database
	@taxiToEdit = get_entry(params[:id], "taxis")

	@submitted = true

	# setting all the variables to various values from the table
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
    if @taxiToEdit[1] != @regNum && @taxiToEdit[2] != @contact then
        @regNum_and_contact_unique = $db.exec("SELECT * FROM taxis WHERE reg_num = '#{@regNum}' AND contact_num = '#{@contact}'").map{|x| x.values}.size == 0
    else
        @regNum_and_contact_unique = true
    end

    @all_ok = @regNum_ok && @contact_ok && @taxiType_ok && @city_ok &&  @regNum_and_contact_unique 
	if @all_ok
		# do the edit
		$db.exec("UPDATE taxis SET reg_num = '#{@regNum}' WHERE id='#{@id}'")
    	$db.exec("UPDATE taxis SET contact_num = '#{@contact}' WHERE id='#{@id}'")
		$db.exec("UPDATE taxis SET taxi_type = '#{@taxiType}' WHERE id='#{@id}'")
		$db.exec("UPDATE taxis SET city = '#{@city.upcase}' WHERE id='#{@id}'")
  	end

	erb :editTaxiMain
end

# edit feedback
post '/editFeedback/:id' do
    # only show page if admin
	redirect '/index' unless session[:admin]

	# get feedback table from the database
	@feedbackToEdit =  get_entry(params[:id], "feedback")
    
	@submitted = true

	# setting all the variables to various values from the table
	@id = params[:id]
	@journey_id = params[:journey_id]
    @user_id = params[:user_id]
    @date_time = params[:date_time]
    @feedback = params[:feedback]
    @rating = params[:rating]

	# perform validation
    @journey_id_ok = @journey_id.nil? || @journey_id == "" || (isPositiveNumber? (@journey_id))
    @feedback_ok = !@feedback.nil? && @feedback != ""
    @user_id_ok = !@user_id.nil? && @user_id != ""
	@date_time_ok = !@date_time.nil? && @date_time != ""
    @rating_ok = @rating == '' || @rating == '0' || @rating == '1' || @rating == '2' || @rating == '3' || @rating == '4' || @rating == '5'

    @all_ok = @journey_id_ok && @feedback_ok && @user_id_ok && @date_time_ok && @rating_ok

    # add data to the database
    if @all_ok
        # do the insert
		$db.exec("UPDATE feedback SET journey_id = '#{@journey_id}' WHERE id='#{@id}'")
		$db.exec("UPDATE feedback SET user_id = '#{@user_id}' WHERE id='#{@id}'")
		$db.exec("UPDATE feedback SET date_time = '#{@date_time}' WHERE id='#{@id}'")
		$db.exec("UPDATE feedback SET feedback = '#{@feedback}' WHERE id='#{@id}'")
        $db.exec("UPDATE feedback SET rating = '#{@rating}' WHERE id='#{@id}'")
	end

	erb :editFeedbackMain
end

# edit journey
post '/editJourney/:id' do
    # only show page if admin
	redirect '/index' unless session[:admin]

	# get journey
    @id = params[:id].to_i
	@journeyToEdit =  get_entry(params[:id], "journeys")

	# submitted is false
	@submitted = true

	# sanitise values
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

    @currentTaxiId = @journeyToEdit[1].to_i
    @currentUserId = @journeyToEdit[2].to_i


    if @currentTaxiId != @taxiId.to_i then
      #looping to check for every id/name whether they are in the database
      taxi = $db.exec ("SELECT * FROM taxis WHERE id = #{@taxiId.to_i}").map{|x| x.values}
      @taxiIdFound = taxi.size > 0
    else
      @taxiIdFound = true
    end

    if @currentUserId != @userId.to_i then
      user = $db.exec ("SELECT * FROM users WHERE id = #{@userId}").map{|x| x.values}
      @userIdFound = user.size > 0    
    else
       @userIdFound = true
    end

	# perform validation
	@taxiId_ok = isPositiveNumber?(@taxiId) && @taxiIdFound
    @userId_ok = isPositiveNumber?(@userId) && @userIdFound
    @twitterHandle_ok = !@twitterHandle.nil? && @twitterHandle != ""
	@dateTime_ok = !@dateTime.nil? && @dateTime != ""
	@startLocation_ok = !@startLocation.nil? && @startLocation != ""
	@endLocation_ok = !@endLocation.nil? && @endLocation != ""
	@freeRide_ok = @freeRide == '0' || @freeRide == '1'
	@cancelled_ok = @cancelled == '0' || @cancelled == '1'
	@rating_ok = @rating == '0' || @rating == '1' || @rating == '2' || @rating == '3' || @rating == '4' || @rating == '5'
	@convoLink_ok =	!@convoLink.nil? && @convoLink != ""

	@all_ok = @taxiId_ok && @twitterHandle_ok && @dateTime_ok && @startLocation_ok && @endLocation_ok && @freeRide_ok && @cancelled_ok && @rating_ok && @convoLink_ok

    # add data to the database
    if @all_ok
        # do the insert
        $db.exec("UPDATE journeys SET taxi_id = '#{@taxiId}' WHERE id='#{@id}'")
		$db.exec("UPDATE journeys SET user_id = '#{@userId}' WHERE id='#{@id}'")
		$db.exec("UPDATE journeys SET twitter_handle = '#{@twitterHandle}' WHERE id='#{@id}'")
		$db.exec("UPDATE journeys SET date_time = '#{@dateTime}' WHERE id='#{@id}'")
		$db.exec("UPDATE journeys SET start_location = '#{@startLocation}' WHERE id='#{@id}'")
		$db.exec("UPDATE journeys SET end_location = '#{@endLocation}' WHERE id='#{@id}'")
		$db.exec("UPDATE journeys SET free_ride = '#{@freeRide}' WHERE id='#{@id}'")
		$db.exec("UPDATE journeys SET cancelled = '#{@cancelled}' WHERE id='#{@id}'")
		$db.exec("UPDATE journeys SET rating = '#{@rating}' WHERE id='#{@id}'")
		$db.exec("UPDATE journeys SET conversation_link = '#{@convoLink}' WHERE id='#{@id}'")
	end

	erb :editJourneyMain
end


#---------------get add---------------#
# add user
get '/addUser' do
    # only show page if admin
	redirect '/index' unless session[:admin]

	erb :addUserMain
end

# add taxi
get '/addTaxi' do
    # only show page if admin
	redirect '/index' unless session[:admin]

	erb :addTaxiMain
end

# add feedback
get '/addFeedback' do
    # only show page if admin
	redirect '/index' unless session[:admin]

	erb :addFeedbackMain
end

# add journey
get '/addJourney' do
    # only show page if admin
	redirect '/index' unless session[:admin]

	erb :addJourneySettingsMain
end

#---------------post add---------------#
# add user
post '/addUser' do
    # only show page if admin
	redirect '/index' unless session[:admin]

	@submitted = true

	# sanitise values
	@id = params[:id].strip
	@name = params[:name].strip
	@dateTime = params[:dateTime]
	@userType = params[:userType].strip
	@freeRide = params[:freeRide].strip

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
		begin
			$db.exec("INSERT INTO users VALUES (#{@id}, '#{@name}', '#{@dateTime}', #{@userType.to_i}, #{@freeRide.to_i})")
		rescue PG::Error => e
			@all_ok = false
		end
  	end
	erb :addUserMain
end

# add taxi
post '/addTaxi' do
    # only show page if admin
	redirect '/index' unless session[:admin]

    @submitted = true
    @taxiInfo= $db.exec("SELECT * FROM taxis").map{|x| x.values} # gather all user data

    # sanitise values
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

    @taxiInfo.each do |taxi| # go through each user record
        if taxi[1] == @regNum # if uid = id then:
            @regNum_unique = false # boolean found is true (record is already there)
        end
        if taxi[2] == @contact
          @contact_unique = false
        end
    end

    @all_ok = @regNum_ok && @contact_ok && @taxiType_ok && @city_ok && @regNum_unique && @contact_unique


    # add data to the database
    if @all_ok
		# do the insert
		begin
			$db.exec("INSERT INTO taxis VALUES (DEFAULT, '#{@regNum}', '#{@contact}', '#{@taxiType}', '#{@city}', #{@available})")
		rescue PG::Error => e
			@all_ok = false
		end
    end
    erb :addTaxiMain
end

# add feedback
post '/addFeedback' do
    # only show page if admin
	redirect '/index' unless session[:admin]
    add_feedback(params[:journey_id], params[:user_id], params[:feedback], params[:rating])
    erb :addFeedbackMain
end

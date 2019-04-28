get '/viewUsers' do
	#get users table and journey table from the database
	@usersInfo = $db.execute("SELECT * FROM users")
	@journeyInfo = $db.execute("SELECT * FROM journeys")
	erb :viewUsers
end

get '/deleteUser/:id' do
	#set id to be deleted
	@id = params[:id]
	#execute the deletion
	$db.execute("DELETE FROM users WHERE id='#{@id}'")

	redirect '/viewUsers'
end

get '/editUser/:id' do
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

	erb :editUser
end

post '/editUser/:id' do
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

	erb :editUser
end

get '/addUser' do
	erb :addUser
end

post '/addUser' do
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
	erb :addUser
end

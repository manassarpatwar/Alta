post '/addUser' do
	@submitted = true

	# sanitize values
	@id = params[:id].strip
	@name = params[:name].strip
	@dateTime = params[:dateTime]
	@userType = params[:userType].strip
	@freeRide = params[:freeRide].strip

	# perform validation
	@id_ok = !@id.nil? && @id != ""
	@name_ok = !@name.nil? && @name != ""
	@dateTime_ok = !@dateTime.nil? && @dateTime != ""
	if @userType = "1" || @userType = "0"
		@userType_ok = true
	else
		@userType_ok = false
	end
	@freeRide_ok = isPositiveNumber?(@freeRide)

	#count = @db.get_first_value('SELECT COUNT(*) FROM cities WHERE city = ? AND country = ?', [@city, @country])
	#@unique = (count == 0)
	
	@all_ok = @id_ok && @name_ok && @dateTime_ok && @userType_ok && @freeRide_ok

  	# add data to the database
	if @all_ok
    	# do the insert
		@db.execute('INSERT INTO users VALUES (?, ?, ?, ?, ?)', [@id, @name, @dateTime, @userType.to_i, @freeRide.to_i])
  	end
	erb :addUser
end

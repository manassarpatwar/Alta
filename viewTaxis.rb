get '/viewTaxis' do
	#get taxi table and journey table from the database
	@taxiInfo = $db.execute("SELECT * FROM taxis")
	@journeyInfo = $db.execute("SELECT * FROM journeys")
	erb :viewTaxis
end

get '/deleteTaxi/:id' do
	#set id to be deleted
	@id = params[:id]
	#execute the deletion
	$db.execute("DELETE FROM taxis WHERE id='#{@id}'")

	redirect '/viewTaxis'
end

get '/editTaxi/:id' do
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

	erb :editTaxi
end

post '/editTaxi/:id' do
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

	erb :editTaxi
end

get '/addTaxi' do
	erb :addTaxi
end

post '/addTaxi' do
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

    numberOfRecords = $db.execute('SELECT COUNT(*) FROM taxis')
	numberOfRecords = numberOfRecords[0][0].to_i - 1

    @id = @taxiInfo[numberOfRecords][0].to_i + 1

    # add data to the database
    if @all_ok
		# do the insert
        $db.execute('INSERT INTO taxis VALUES (?, ?, ?, ?, ?, ?)', [@id, @regNum, @contact, @taxiType, @city, @available])
    end
    erb :addTaxi
end

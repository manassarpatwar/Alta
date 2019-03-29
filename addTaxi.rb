post '/addTaxi' do
    @submitted = true
    @taxiTable = $db.execute %{SELECT * FROM taxis} #Gather all user data
    #sanitize values
    @regNum = params[:regNum].strip
    @contact = params[:contact].strip
    @city = params[:city].strip
    @taxiType = params[:taxiType].strip.upcase# perform validation
  
    @regNum_ok = !@regNum.nil? && @regNum != ""
    @contact_ok = !@contact.nil? && @contact != ""
    @city_ok = !@city.nil? && @city != "" && (@city == "SHEFFIELD" || @city == "MANCHESTER")
    @available = 1
  
    if @taxiType == "S" || @taxiType == "M" || @taxiType == "L"
        @taxiType_ok = true
    else
        @taxiType_ok = false
    end
    
    @regNum_unique = true
    @contact_unique = true
  
    @taxiTable.each do |taxi| #Go through each user record
        if taxi[1] == @regNum #If uid = id then:
            @regNum_unique = false #Boolean found is true (record is already there)
        end
        if taxi[2] == @contact
          @contact_unique = false
        end
    end

    @all_ok = @regNum_ok && @contact_ok && @taxiType_ok && @city_ok && @regNum_unique && @contact_unique

    count = $db.get_first_value('SELECT COUNT(*) FROM taxis')
    @id = count + 1

    # add data to the database
    if @all_ok# do the insert
        $db.execute('INSERT INTO taxis VALUES (?, ?, ?, ?, ?, ?)', [@id, @regNum, @contact, @taxiType, @city, @available])
    end
    erb :addTaxi
end

post '/addComplaint' do
	redirect '/index' unless session[:admin]

	#get complaints table from the database
	@complatintsInfo = $db.execute("SELECT * FROM complaints")

    @submitted = true

    #sanitize values
    @journey_id = params[:journey_id] #taking it out from the table
    @user_id = session[:id]
    @date_time = Time.now.strftime("%d/%m/%Y %H:%M").to_s
    @complaint = params[:complaint]

    # perform validation
    @journey_id_ok = isPositiveNumber? (@journey_id)
    @complaint_ok = !@complaint.nil? && @complaint != ""
    
    @all_ok = @journey_id_ok && @complaint_ok 

	@id = @complaintsInfo[@complaintsInfo.length-1][0].to_i + 1

    # add data to the database
    if @all_ok
		# do the insert
        $db.execute('INSERT INTO complaints VALUES (?, ?, ?, ?, ?)', [@id, @journey_id, @user_id, @date_time, @complaint])
    end
    erb :
end

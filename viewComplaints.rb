get '/viewComplaints' do
	#get complaints table from the database
	@complatintsInfo = $db.execute("SELECT * FROM complaints")
	erb :viewComplaints
end

get '/deleteComplaint/:id' do
	#set id to be deleted
	@id = params[:id]
	#execute the deletion
	$db.execute("DELETE FROM complaints WHERE id='#{@id}'")

	redirect '/viewComplaints'
end

get '/editComplaint/:id' do
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

	erb :editComplaint
end

post '/editComplaint/:id' do
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

	erb :editComplaint
end

get '/addComplaint' do
	erb :addComplaint
end

post '/addComplaint' do
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

	numberOfRecords = $db.execute('SELECT COUNT(*) FROM complaints')
	numberOfRecords = numberOfRecords[0][0].to_i - 1

    @id = @complatintsInfo[numberOfRecords][0].to_i + 1

    # add data to the database
    if @all_ok
		# do the insert
        $db.execute('INSERT INTO complaints VALUES (?, ?, ?, ?, ?)', [@id, @journey_id, @user_id, @date_time, @complaint])
    end
    erb :addComplaint
end

post '/addComplaint' do
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

    count = $db.get_first_value('SELECT COUNT(*) FROM complaints')
    @id = count

    # add data to the database
    if @all_ok# do the insert
        $db.execute('INSERT INTO complaints VALUES (?, ?, ?, ?, ?)', [@id, @journey_id, @user_id, @date_time, @complaint])
    end
    erb :addComplaint
end

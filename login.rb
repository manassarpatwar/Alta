#--------------------Get Methods--------------------#
#Login page redirecting to twitter autherisation
get '/login' do
  	redirect to("/auth/twitter")
end

#Logs user out
get '/logout' do
	redirect '/index' unless session[:loggedin]

  	session[:loggedin] = nil
    session[:admin] = nil
  	redirect '/index'
end

#When autherisation for twitter is called
get '/auth/twitter/callback' do
	@found = false #Boolean to see if user is already in database

    session[:loggedin] = true #User now logged in
    session[:admin] = false #User is not an admin until confirmed

    @usersTable = $db.execute %{SELECT * FROM users} #Gather all user data

    @usersTable.each do |record| #Go through each user record
        if env['omniauth.auth']['uid'] == record[0] #If uid = id then:
            @found = true #Boolean found is true (record is already there)
        end
    end

	#Gather user information from twitter
	id = env['omniauth.auth']['uid'].to_s
	name = env['omniauth.auth']['info']['name'].to_s
	dateTime = Time.now.strftime("%d/%m/%Y %H:%M").to_s

	#Add to database if user is not found already
	if @found == false
		$db.execute("INSERT INTO users VALUES (?, ?, ?, 0, 0)", id, name, dateTime)
	end

	#Set global variables of user information to user logged in
	@userInfo = $db.execute("SELECT * FROM users WHERE id = ?", id)
	session[:id] = @userInfo[0][0]
	session[:name] = @userInfo[0][1]
	session[:dateTime] = @userInfo[0][2]
	if @userInfo[0][3] == 1
		session[:admin] = true
        session[:admin_sheffield] = true
	end
    if @userInfo[0][3] == 2
		session[:admin] = true
        session[:admin_manchester] = true
	end
	session[:freeRides] = @userInfo[0][4]

	redirect '/index'
end

#When autherisation fails
get '/auth/failure' do
  	erb :not_found404
end

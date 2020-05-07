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
    session[:admin_city] = nil
  	redirect '/index'
end

#When autherisation for twitter is called
get '/auth/twitter/callback' do
	@found = false #Boolean to see if user is already in database

    session[:loggedin] = true #User now logged in
    session[:admin] = false #User is not an admin until confirmed

    @user = $db.exec("SELECT * FROM users WHERE id = #{env['omniauth.auth']['uid']}").entries #Gather all user data
    @found = @user.size > 0

	#Gather user information from twitter
	id = env['omniauth.auth']['uid']
	name = env['omniauth.auth']['info']['name'].to_s
	dateTime = Time.now.strftime("%Y/%m/%d %H:%M").to_s

	#Add to database if user is not found already
	if @found == false
		$db.exec("INSERT INTO users VALUES (#{id}, '#{name}', '#{dateTime}', 0, 0)")
	end

	#Set global variables of user information to user logged in
	@userInfo = $db.exec("SELECT * FROM users WHERE id = #{id}")[0].values

	session[:id] = @userInfo[0]
	session[:name] = @userInfo[1]
	session[:dateTime] = @userInfo[2]
	if @userInfo[3].to_i == 1 
		session[:admin] = true
        session[:admin_city] = "SHEFFIELD"
	end
    if @userInfo[3].to_i == 2
		session[:admin] = true
        session[:admin_city] = "MANCHESTER"
	end
	session[:freeRides] = @userInfo[4]
	puts "Session id at login is #{session[:id]}"
	redirect '/index'
end

#When autherisation fails
get '/auth/failure' do
  	erb :not_found404
end

get '/viewUsers' do
	@usersInfo = $db.execute("SELECT * FROM users")
	@journeyInfo = $db.execute("SELECT * FROM journeys")
	erb :viewUsers
end

get '/editUser/:id' do
	@usersInfo = $db.execute("SELECT * FROM users")
	@journeyInfo = $db.execute("SELECT * FROM journeys")

	@usersInfo.each do |user|
		if user[0] == params[:id]
			@userToEdit = user
		end
	end

	erb :editUser
end

# delete account
post '/deleteAccount/' do
	#execute the deletion
	$db.execute("DELETE FROM users WHERE id='#{session[:id]}'")
	redirect '/'
end
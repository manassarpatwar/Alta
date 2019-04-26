get '/userData' do
	gather_users
	erb :userData
end

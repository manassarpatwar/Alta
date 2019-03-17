#--------------------Get Methods--------------------#
#Everyone is welcome page
get '/' do
  	erb :welcome
end

get '/index' do
	redirect '/' unless loggedin?
	erb :index
end
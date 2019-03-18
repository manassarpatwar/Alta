#--------------------Get Methods--------------------#
#Everyone is welcome page
get '/' do
  	redirect '/index'
end

get '/index' do
	@loggedin = loggedin?
    @admin = admin?
	erb :index
end

get '/userAccount' do
  @loggedin = loggedin?
  @admin = admin?
  erb :user_account
end
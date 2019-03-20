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

get '/userOrders' do
  @loggedin = loggedin?
  @admin = admin?
  erb :user_orders
end


not_found do 
    erb :not_found404
end

error do 
    erb :error500
end

#--------------------Get Methods--------------------#
#Everyone is welcome page
get '/' do
  	redirect '/index'
end

get '/index' do
	erb :index
end

#get '/userAccount' do
#    redirect '/index' unless session[:loggedin]
#    erb :user_account
#end

get '/userOrders' do
    redirect '/index' unless session[:loggedin]
    erb :user_orders
end


not_found do
    erb :not_found404
end
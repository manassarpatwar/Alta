require 'sinatra' 
set :bind, '0.0.0.0'
# needed if you're running from Codio

get '/sayHello' do 
    @name = 'Phil' 
    erb :sayHello 
end

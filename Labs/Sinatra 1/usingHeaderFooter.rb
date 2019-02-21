require 'sinatra' 
set :bind, '0.0.0.0' # Only needed if you're running from Codio

get '/usingHeaderFooter' do 
    erb :headerFooter 
end

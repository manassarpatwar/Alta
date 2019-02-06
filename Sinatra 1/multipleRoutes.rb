

require 'sinatra' 
set :bind, '0.0.0.0' # Only needed if you're running from Codio

get '/' do 
    '<a href="page2">Click me</a>' 
end

get '/page2' do 
    '<a href=".">Go back</a>' 
end
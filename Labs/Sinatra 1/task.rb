require 'sinatra' 
set :bind, '0.0.0.0' # Only needed if you're running from Codio

title = "Task 1" 
tweets = Array.new(7)

for i in 1..tweets.length
	tweets[i] = "Tweet ##{i}"
end

get '/' do 
    erb :task, :locals => {:title => title, :tweets => tweets}
end

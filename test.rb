require 'erb'
require 'sinatra'
require 'twitter'
require "sinatra/cookies"
require 'rufus-scheduler'


set :bind, '0.0.0.0' # needed if you're running from Codio

include ERB::Util
scheduler = Rufus::Scheduler.new
time = 0
scheduler.every "1s" do
  time = time + 1
  puts time
end

before do
  config = {
    :consumer_key => 'wVzUO14M25jvS3vmmtfDAtmh6',
    :consumer_secret => 'x1hieq7QNwhbUM8wjqgl5HujELyyqmZiJUzpaWi1tQEnG8cQrX',
    :access_token => '1092444312430919681-k6yytElynjt9A1ziskr28eHKLg580X',
    :access_token_secret => 'UkK1okCoI1kFUKeofvh5Y5QQHkJyVOQxeIQGQfyCjIFQP'
  }
  @client = Twitter::REST::Client.new(config)
  @tweets = @client.search("to:uber", result_type: "recent", lang: "en", geocode: "53.3,-1.5,1000km").take(2)
end

get '/dashboard' do
  response.set_cookie 'tweets_cookie',
  {:fetchedTweets => @tweets, :isUsed => false}
  puts(request.cookies['tweets_cookie'])

  erb :dashboard
end

get '/index' do
  erb :index
  @test = "hello"
end

post '/replyToTweet' do
  puts("lol #{params[:tweetid]} #{params[:screen_name]}" )
  @client.update("@#{params[:screen_name]} #{params[:reply]}", :in_reply_to_status_id => params[:tweetid].to_i)
  redirect '/dashboard'
end

post '/fetch_tweets' do
 
  redirect '/dashboard'
end

get '/cont' do
  erb :homepage_cont
end

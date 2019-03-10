require 'erb'
require 'sinatra'
require 'twitter'


set :bind, '0.0.0.0' # needed if you're running from Codio

include ERB::Util

before do
  config = {
    :consumer_key => 'wVzUO14M25jvS3vmmtfDAtmh6',
    :consumer_secret => 'x1hieq7QNwhbUM8wjqgl5HujELyyqmZiJUzpaWi1tQEnG8cQrX',
    :access_token => '1092444312430919681-k6yytElynjt9A1ziskr28eHKLg580X',
    :access_token_secret => 'UkK1okCoI1kFUKeofvh5Y5QQHkJyVOQxeIQGQfyCjIFQP'
  }
  @client = Twitter::REST::Client.new(config)
  def fetch_tweets
    @tweets = @client.search("to:lyft", result_type: "recent", lang: "en", geocode: "53.3,-1.5,1000km").take(2)
  end
end

get '/dashboard' do
  fetch_tweets
  erb :dashboard
end

get '/index' do
  erb :index
  @test = "hello"
end

post '/replyToTweet' do

  puts("lol #{params[:tweetid]} #{params[:screen_name]}" )
  @client.update("@#{params[:screen_name]} #{params[:reply]}", in_reply_to_status_id: @params[:tweetid])
  redirect '/dashboard'
end

post '/fetch_tweets' do 
  redirect '/dashboard'
end

get '/cont' do
  erb :homepage_cont
end

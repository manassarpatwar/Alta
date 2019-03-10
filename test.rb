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
    @tweets = @client.search("to:uber", result_type: "recent", lang: "en", geocode: "53.3,-1.5,1000km").take(20)
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
  id = @tweets.id
  reply_to = tweet.in_reply_to_screen_name
  @client.update("#{reply_to} #{params[:reply]}", in_reply_to_status_id: id)
end

post '/fetch_tweets' do 
  redirect '/dashboard'
end

get '/cont' do
  erb :homepage_cont
end

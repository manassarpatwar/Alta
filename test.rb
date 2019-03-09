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
end

get '/dashboard' do
    def fetch_tweets
      results = @client.search("to:lyft", result_type: "recent", lang: "en", geocode: "53.3,-1.5,1000km").take(20)
      @tweets = @client.oembeds(results, hide_media: "true", hide_thread: "true")
    end
  fetch_tweets
  erb :dashboard
end

get '/index' do
  erb :index
  sleep(5)
  @test = "hello"
end

post '/replyToTweet' do
  id = @tweets.id
  reply_to = tweet.in_reply_to_screen_name
  @client.update("#{reply_to} #{params[:reply]}", in_reply_to_status_id: id)
end

get '/cont' do
  erb :homepage_cont
end

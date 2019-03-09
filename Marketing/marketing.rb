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

get '/marketing' do
  # if to many request give error to the user
  @follow_state = true
  
  # Follows 5 people at the time that use the certain keyword most recently
  # also catches any errors
  begin
    unless params[:follow].nil?
      follow_string = params[:follow]
      results = @client.search(follow_string)
      @marketing_tweets = results.take(5)
      @marketing_tweets.each do |name|
        @client.follow(name.user.screen_name)
      end
    end
  rescue Twitter::Error::TooManyRequests => err
    @follow_state = false
    puts ("To many requests to twitter API Marketing.rb line 34")
  end

  # if button pressed follow all recent people that tweeted or mentioned us add later 
  erb :marketing
end

post '/followIfMention' do
  mentions = @client.mentions_timeline()
  most_recent = mentions.take(5)
  most_recent.each do |tweet|
    @client.follow(tweet.user.screen_name)  
  end
  redirect '/marketing'
end

post '/tweetToTimeline' do
  
  # Tweets a message from the dashboard to the Twitter
  if !(params[:tweet].nil?)
    tweet_string = params[:tweet]
    @client.update(tweet_string)
  end
  redirect '/marketing'
end

# client.follow('name')
# 
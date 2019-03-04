require 'erb'
require 'sinatra'
require 'twitter'


set :bind, '0.0.0.0' # needed if you're running from Codio

include ERB::Util

before do
  config = {
    :consumer_key => '0gz9YqiS7VD6kgNJTkeVhjnd7',
    :consumer_secret => 'GEmoZ61BNX8BRXcS2dGwZZ36BIsqKvV1HXlB5v6iOOlSnvif5U',
    :access_token => '1092444312430919681-7Wfb7Bymkw5i7t1RQc2Lwip0IhFSzR',
    :access_token_secret => 'nlDgQf8Cx0wYMhgFQnp1WgaflRt6nlmyO869W4Kxsit88'
  }
  @client = Twitter::REST::Client.new(config)
  
end

get '/marketing' do
  @follow_state = true
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
  
   unless params[:tweet].nil?
     tweet_string = params[:tweet]
     @client.update(tweet_string)
   end
  
  # if button pressed follow all recent people that tweeted or mentioned us add later
  
  
  
  erb :marketing
end

# client.follow('name')
# 
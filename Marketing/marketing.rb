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
  
  unless params[:search].nil?
    search_string = params[:search]
    results = @client.search(search_string)
    @tweets = results.take(5)
    @tweets.each do |name|
      @client.follow(name.user.screen_name)
    end
  end
  
   unless params[:tweet].nil?
    tweet_string = params[:tweet]
     @client.update(tweet_string)
    end
  
  
  
  erb :marketing
end

# client.follow('name')
# 
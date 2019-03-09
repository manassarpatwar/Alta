require 'erb'
require 'sinatra'
require 'twitter'


set :bind, '0.0.0.0' # needed if you're running from Codio

include ERB::Util

before do
  config = {
    :consumer_key => '6VCt8o2esXR3JoWYSIqxjlfEE',
    :consumer_secret => 'Cjj1zX9T99xKqb8BFO9WQPjco6WbBpDXNUbaN4Y68ZZJrNU9nL',
    :access_token => '1092444312430919681-g4S8YlnAD6vaqZ63YU7O7n1vS26O2O',
    :access_token_secret => 'Hrkx1ZicwUNzRsoKMEPUAMaUqd2GRKY1sawCNRzcL414q'
  }
  @client = Twitter::REST::Client.new(config)
end

get '/dashboard' do
   helper_method :fetch_tweets
    def fetch_tweets
      results = @client.search("to:uber", result_type: "recent", lang: "en", geocode: "53.3,-1.5,1000km").take(20)
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

get '/cont' do
  erb :homepage_cont
end
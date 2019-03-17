# check cookie boolean google
# 

require 'erb'
require 'sinatra'
require 'twitter'
require 'rufus-scheduler'


set :bind, '0.0.0.0' # needed if you're running from Codio

include ERB::Util

before do
    config = {
        :consumer_key => 'wVzUO14M25jvS3vmmtfDAtmh6',
        :consumer_secret => 'x1hieq7QNwhbUM8wjqgl5HujELyyqmZiJUzpaWi1tQEnG8cQrX',
        :access_token => '1092444312430919681-k6yytElynjt9A1ziskr28eHKLg580X',
        :access_token_secret => 'UkK1okCoI1kFUKeofvh5Y5QQHkJyVOQxeIQGQfyCjIFQP'
    }
    autoConfig = {
        :consumer_key => 'bPRgFITcTjgp9XwVXmygQ7uLW',
        :consumer_secret => 'NMTShC5veeca7VlIihU3IaEHaOqDwfPeiWcfqjxAqvAoAOcVgV',
        :access_token => '1092444312430919681-l310PeiErGI2Caa9JKP3Mm3FgyoqXb',
        :access_token_secret => 'VQpivEpVIE3xJw5MqRzcPmIon9pNPqbSGRltBychnRNRV'
    }
  
    @client = Twitter::REST::Client.new(config)
    @clientAutomaticFollowing = Twitter::REST::Client.new(autoConfig)
    @scheduler = Rufus::Scheduler.new
    @scheduler.every "30m" do
    
        mentions = @clientAutomaticFollowing.mentions_timeline()
        most_recent = mentions.take(5)
        most_recent.each do |tweet|
            @clientAutomaticFollowing.follow(tweet.user.screen_name)  
        end
    end
end

get '/marketing' do
    response.set_cookie(:tweeting, :value => "true")
    response.set_cookie(:following, :value => "true")
    response.set_cookie(:follow_state, :value => "true")
    response.set_cookie(:tweet_state, :value => "true")

    
    erb :marketing
end

post '/followPeopleUsingKeyword' do
    
  # if to many request give error to the user
    response.set_cookie(:follow_state, :value => "true")
  
    # Follows 5 people at the time that use the certain keyword most recently
    # also catches any errors
    begin
        
        if(params[:follow] != "")
            unless params[:follow].nil?
                response.set_cookie(:following, :value => "false")
                follow_string = params[:follow]
                results = @client.search(follow_string)
                @marketing_tweets = results.take(5)
                @marketing_tweets.each do |name|
                   @client.follow(name.user.screen_name)
                end
            end
        end
    rescue Twitter::Error::TooManyRequests => err
        
        response.set_cookie(:follow_state, :value => "false")
        puts ("To many requests to twitter API Marketing.rb line 34")
    end

    redirect '/marketing'
end

post '/tweetToTimeline' do
    
    response.set_cookie(:tweet_state, :value => "true")
    
    # Tweets a message from the dashboard to the Twitter and catches an error if not allowed
    begin
        if(params[:tweet] != "")
            if !(params[:tweet].nil?)
                response.set_cookie(:tweeting, :value => "false")
                @tweet_string = params[:tweet]
                @client.update(@tweet_string)
            end
        end
    rescue Twitter::Error::TooManyRequests => err
       response.set_cookie(:tweet_state, :value => "false")
       puts ("To many requests to twitter API Marketing.rb line 86")
    end    
    redirect '/marketing'
end

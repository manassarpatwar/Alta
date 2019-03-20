require 'erb'
require 'sinatra'
require 'twitter'
require 'rufus-scheduler'


set :bind, '0.0.0.0' # needed if you're running from Codio

include ERB::Util

before do
    marketingConfig = {
        :consumer_key => 'DjSQ85AGsA2oFDoELKGiQlqe9',
        :consumer_secret => 'aUb8fC0nsl0IaWJl29h0cvSMzSR4aGJJWLNDpI3s8RDATAjGqJ',
        :access_token => '1092444312430919681-50Rz1rCJV24YFT1DyDXcDvDffPfYXN',
        :access_token_secret => '49vy1Z2j6ysww2b5BKlnUD0lRBDCc7sUhtQVQ5Ao35ZkH'
    }
    autoConfig = {
        :consumer_key => 'OH20bwn5ml5a6J7cpWAfn44sw',
        :consumer_secret => '20cW4vtmfWNTbcXf5XrCAlWtGktFHXOBGafK1RwImOQCI473XN',
        :access_token => '1092444312430919681-04XWeN319ppuOGPy6Qtdpz4t0AwcVB',
        :access_token_secret => '4B00DH6sUPvugxshMQjmmaYPTlnQM4ftpUOgcyoDaGfYq'
    }
  
    @clientMarketing = Twitter::REST::Client.new(marketingConfig)
    @clientAutomaticFollowing = Twitter::REST::Client.new(autoConfig)
    @scheduler = Rufus::Scheduler.new
    @scheduler.every "30m" do
        begin
            
            mentions = @clientAutomaticFollowing.mentions_timeline()
            most_recent = mentions.take(5)
            most_recent.each do |tweet|
                @clientAutomaticFollowing.follow(tweet.user.screen_name)  
            end
            puts ("Automated following initiated")
        rescue Twitter::Error::TooManyRequests => error
            sleep error.rate_limit.reset_in
            puts ("To many requests to twitter API Marketing.rb line 37 before do")
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
    
    response.set_cookie(:follow_state, :value => "true")
  
    # Follows 5 people at the time that use the certain keyword most recently
    # also catches any errors
    begin
        
        if(params[:follow] != "")
            unless params[:follow].nil?
                response.set_cookie(:following, :value => "false")
                follow_string = params[:follow]
                results = @clientMarketing.search(follow_string)
                @marketing_tweets = results.take(5)
                @marketing_tweets.each do |name|
                   @clientMarketing.follow(name.user.screen_name)
                end
            end
        end
    rescue Twitter::Error::TooManyRequests => err
        
        response.set_cookie(:follow_state, :value => "false")
        puts ("To many requests to twitter API Marketing.rb line 73, followPeopleUsingKeyword")
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
                @clientMarketing.update(@tweet_string)
            end
        end
    rescue Twitter::Error::TooManyRequests => err
        
        response.set_cookie(:tweet_state, :value => "false")
        puts ("To many requests to twitter API Marketing.rb line 95 tweetToTimeline")
    end    
    
    redirect '/marketing'
end

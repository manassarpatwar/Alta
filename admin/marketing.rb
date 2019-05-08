#--------------Marketing code---------------#

before do
    marketingConfig = {
        :consumer_key => 'DjSQ85AGsA2oFDoELKGiQlqe9',
        :consumer_secret => 'aUb8fC0nsl0IaWJl29h0cvSMzSR4aGJJWLNDpI3s8RDATAjGqJ',
        :access_token => '1092444312430919681-50Rz1rCJV24YFT1DyDXcDvDffPfYXN',
        :access_token_secret => '49vy1Z2j6ysww2b5BKlnUD0lRBDCc7sUhtQVQ5Ao35ZkH'
    }
    @clientMarketing = Twitter::REST::Client.new(marketingConfig)
end

get '/marketing' do
    # if not admin redirect to homepage
    redirect '/index' unless session[:admin]
    # set cookies for feedback when one submits any marketing form
    response.set_cookie(:tweeting, :value => "true")
    response.set_cookie(:following, :value => "true")
    response.set_cookie(:follow_state, :value => "true")
    response.set_cookie(:tweet_state, :value => "true")

    erb :marketing
end

# follows 5 people that uses entered keyword
post '/followPeopleUsingKeyword' do
    
    # set cookie that shows that form has been submitted and feedback should be displayed
    response.set_cookie(:follow_state, :value => "true")
    
    # Follows 5 people at the time that use the certain keyword most recently
    # also catches twitter limit error
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
        puts ("To many requests to twitter API Marketing.rb line 48, followPeopleUsingKeyword")
    end
    redirect '/marketing'
end

# tweets anything to the timeline
post '/tweetToTimeline' do

    # set cookie that shows that form has been submitted and feedback should be displayed
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
        puts ("To many requests to twitter API Marketing.rb line 70 tweetToTimeline")
    end
    redirect '/marketing'
end

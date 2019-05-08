configure do
     autoConfig = {
        :consumer_key => 'OH20bwn5ml5a6J7cpWAfn44sw',
        :consumer_secret => '20cW4vtmfWNTbcXf5XrCAlWtGktFHXOBGafK1RwImOQCI473XN',
        :access_token => '1092444312430919681-04XWeN319ppuOGPy6Qtdpz4t0AwcVB',
        :access_token_secret => '4B00DH6sUPvugxshMQjmmaYPTlnQM4ftpUOgcyoDaGfYq'
    }
    @clientAutomaticFollowing = Twitter::REST::Client.new(autoConfig)
end

# trying to make scheduler running once per server run, not working yet.
def following_scheduler()
     scheduler = Rufus::Scheduler.new
    
    begin
        #schedule events to follow people that tweet to us
        scheduler.every("3m") do
            puts ("loop started scheduler #{scheduler.object_id}")
                mentions = @clientAutomaticFollowing.mentions_timeline()
                tweet = mentions.take(1)
                if tweet[0].user.screen_name != "ise19team29"
                    @clientAutomaticFollowing.follow(tweet.user.screen_name)
                end
                puts ("Automated following completed")
        end
    rescue Twitter::Error::TooManyRequests => error
        sleep error.rate_limit.reset_in
        puts ("To many requests to twitter API scheduler.rb line 28 before do")
    end
    puts("started Scheduler #{scheduler.object_id}")
end
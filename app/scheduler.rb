configure do
     autoConfig = {
        :consumer_key => 'OH20bwn5ml5a6J7cpWAfn44sw',
        :consumer_secret => '20cW4vtmfWNTbcXf5XrCAlWtGktFHXOBGafK1RwImOQCI473XN',
        :access_token => '1092444312430919681-04XWeN319ppuOGPy6Qtdpz4t0AwcVB',
        :access_token_secret => '4B00DH6sUPvugxshMQjmmaYPTlnQM4ftpUOgcyoDaGfYq'
    }
    @clientAutomaticFollowing = Twitter::REST::Client.new(autoConfig)
end

def following_scheduler()
     scheduler = Rufus::Scheduler.new
     scheduler.every "3m" do |job|
        begin
            #schedule events to follow people that tweet to us
            mentions = @clientAutomaticFollowing.mentions_timeline(count: "1")
            if mentions[0].user.screen_name != "ise19team29"
                @clientAutomaticFollowing.follow(mentions[0].user.screen_name)
            end
        rescue Twitter::Error::TooManyRequests => error
            puts "Too many requests. Try again in #{error.rate_limit.reset_in} seconds"
            job.next_time = Time.now + error.rate_limit.reset_in
        end
     end
end
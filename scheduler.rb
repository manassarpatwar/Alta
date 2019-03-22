require 'rufus-scheduler'
require 'sinatra'
require 'twitter'

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
    scheduler = Rufus::Scheduler.new(:frequency => '30s')

    scheduler.every("1m") do
        puts ("loop started scheduler")
        begin
            puts ("1")
            mentions = @clientAutomaticFollowing.mentions_timeline()
            puts ("2")
            most_recent = mentions.take(5)
            puts ("3")
            most_recent.each do |tweet|
                puts ("4")
                @clientAutomaticFollowing.follow(tweet.user.screen_name)
            end
            puts ("Automated following initiated")
        rescue Twitter::Error::TooManyRequests => error
            sleep error.rate_limit.reset_in
            puts ("To many requests to twitter API scheduler.rb line 30 before do")
        end
    end
    puts("started Scheduler #{scheduler.object_id}")
    #response.set_cookie(:automated_following, :value => "false")
end
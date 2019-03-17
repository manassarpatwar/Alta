#--------------------Get Methods--------------------#
get '/dashboard' do
    redirect '/' unless admin?
    @tweets = $tweets.dup
    @submitted = false
	erb :addJourney
	erb :dashboard
end

get '/dashboard/fetch_tweets' do
    if $tweets.length > 0
      $since_id = $tweets[0].id
      puts $tweets[0].user.screen_name
    end
    $tweets =  TWITTER_CLIENT.mentions_timeline(count: "5", since_id: "#{$since_id}") + $tweets
    redirect '/dashboard'
end

#--------------------Post Methods--------------------#

post '/replyToTweet' do
    if(params[:reply] != "")
        replytweet = TWITTER_CLIENT.update("@#{params[:screen_name]} #{params[:reply]}", :in_reply_to_status_id => params[:tweetid].to_i)
    end    
    redirect '/dashboard'
end

post '/delete_tweet' do
  $since_id = $tweets[0].id
  index = (params[:tweetindex]).to_i
  $tweets.delete($tweets[index])
  $tweets =  TWITTER_CLIENT.mentions_timeline(count: "1", since_id: "#{$since_id}") + $tweets
  redirect '/dashboard'
end
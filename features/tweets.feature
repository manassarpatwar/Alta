Feature: Tweet actions
   @javascript
   Scenario: Reply to tweet is shown and destroy the tweet after replying 
            Given I am signed in as admin from sheffield
            And I am on the dashboard page
            And I scroll down within ".displaytweets"
            When I click "#reply_tweet_icon0" within "#incoming_tweets"
            When I fill in "reply" with "Testing reply to tweets" within "#incoming_tweets"
            And I scroll down within ".displaytweets"
            When I press "replyBtn0" within "#incoming_tweets"
            Then I should see "Testing reply to tweets" within "#incoming_tweets"
            And I click "#destroy_tweet_icon0"
            Then I should not see "Testing reply to tweets" within "#incoming_tweets"
            
   @javascript
   Scenario: Update to fetchttweets button click is shown
            Given I am signed in as admin from sheffield
            And I am on the dashboard page
            And I wait for 10 seconds
            When I click "#fetch_tweets" within "#incoming_tweets"
            Then I should see "available" within "#incoming_tweets"
            And I tweet to "ise19team29"
            And I wait for 10 seconds
            When I click "#fetch_tweets" within "#incoming_tweets"
            And I scroll down within "#incoming_tweets"
            Then I should see "this is a test" within "#incoming_tweets"
            And I click "#destroy_tweet_icon0"
            Then I should not see "this is a test" within "#incoming_tweets"
            
            
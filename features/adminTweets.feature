Feature: Tweet actions on dashboard 
            
   @javascript
   Scenario: Reply to tweet is shown and destroy the tweet after replying 
            Given I am signed in as admin from sheffield
            And I am on the dashboard page
            And I wait for 1 seconds
            And I scroll down within ".displaytweets"
            And I wait for 1 seconds
            When I click "#reply_tweet_icon0" within "#incoming_tweets"
            And I scroll down within ".displaytweets"
            And I wait for 1 seconds
            When I fill in "reply" with "Testing reply to tweets" within "#tweet0"
            And I scroll down within ".displaytweets"
            And I wait for 1 seconds
            When I press "replyBtn0" within "#incoming_tweets"
            Then I should see "Testing reply to tweets" within "#incoming_tweets"
            And I wait for 1 seconds
            And I click "#destroy_tweet_icon0"
            Then I should not see "Testing reply to tweets" within "#incoming_tweets"
            
   @javascript
   Scenario: Update to fetchttweets button click is shown
            Given I am signed in as admin from sheffield
            And I am on the dashboard page
            And I wait for 10 seconds
            When I click "#fetch_tweets" within "#incoming_tweets"
            Then I should see "available" within "#incoming_tweets"
            And I tweet to "ise19team29" with "Testing updates to fetch tweets"
            And I wait for 10 seconds
            When I click "#fetch_tweets" within "#incoming_tweets"
            And I scroll down within "#incoming_tweets"
            Then I should see "Testing updates to fetch tweets" within "#incoming_tweets"
            And I click "#destroy_tweet_icon0"
            Then I should not see "Testing updates to fetch tweets" within "#incoming_tweets"
            
   @javascript
   Scenario: Delete tweet function is working
            Given I am signed in as admin from sheffield
            And I am on the dashboard page
            And I tweet to "ise19team29" with "Testing delete tweet"
            And I wait for 1 seconds
            And I scroll down within ".displaytweets"
            And I wait for 1 seconds
            When I click "#delete_tweet_icon0" within "#incoming_tweets"
            Then I should not see "Testing delete tweet" within "#incoming_tweets"
            And I delete the tweet
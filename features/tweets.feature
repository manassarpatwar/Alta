Feature: Reply to tweets
   @javascript
   Scenario: Reply to tweet is shown
            Given I am on the dashboard page
            When I click "#reply_tweet_icon4" within "#incoming_tweets"
            When I fill in "replyInput4" with "Testing reply to tweets"
            When I press "replyBtn4"
            Then I should see "Testing reply to tweets" within "#incoming_tweets"
            
            
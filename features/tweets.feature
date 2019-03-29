Feature: Reply to tweets
   @javascript
   Scenario: Reply to tweet is shown
            Given I am on the dashboard page
            When I click "#reply_tweet_icon0" within "#incoming_tweets"
            When I fill in "replyInput0" with random text
            When I press "replyBtn0"
            Then I should see "Alta" within "#incoming_tweets"
            
            
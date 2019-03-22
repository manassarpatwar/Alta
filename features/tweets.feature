Feature: Reply to tweets
   @javascript
   Scenario: Reply to tweet is shown
            Given I am on the dashboard page
            When I click "#reply_tweet_icon4" within "#incoming_tweets"
            When I fill in "reply" with "This is testing reply to tweets"
            When I press "REPLY"
            Then I should see "This is testing reply to tweets"
            
            
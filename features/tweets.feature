Feature: Reply to tweets
   @javascript
   Scenario: Reply to tweet is shown
            Given I am signed in as admin
            And I am on the dashboard page
            When I click "#reply_tweet_icon1" within "#incoming_tweets"
            When I fill in "replyInput1" with random text within "#reply1"
            When I press "replyBtn1"
            Then I should see "Alta" within "#incoming_tweets"
            
            
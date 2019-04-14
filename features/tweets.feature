Feature: Tweet actions
   @javascript
   Scenario: Reply to tweet is shown
            Given I am signed in as admin from sheffield
            And I am on the dashboard page
            When I click "#reply_tweet_icon1" within "#incoming_tweets"
            When I fill in "replyInput1" with random text within "#incoming_tweets"
            When I press "replyBtn1"
            Then I should see "ise19team29" within "#incoming_tweets"
            
   @javascript
   Scenario: Update to fetchttweets button click is shown
            Given I am signed in as admin from sheffield
            And I am on the dashboard page
            And I wait for 10 seconds
            When I click "#fetch_tweets" within "#incoming_tweets"
            Then I should see "available" within "#incoming_tweets"
            
    @javascript
   Scenario: Delete tweet function is working
            Given I am signed in as admin from sheffield
            And I am on the dashboard page
            When I click "#delete_tweet_icon0" within "#incoming_tweets"
            Then I should not see "#delete_tweet_icon0" within "#incoming_tweets"
            
            
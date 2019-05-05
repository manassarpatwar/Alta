Feature: Tweet deletion
   @javascript
   Scenario: Delete tweet function is working
            Given I am signed in as admin from sheffield
            And I am on the dashboard page
            When I click "#delete_tweet_icon0" within "#incoming_tweets"
            Then I should not see "#delete_tweet_icon0" within "#incoming_tweets"
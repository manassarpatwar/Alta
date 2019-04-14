Feature: Add Journey
   @javascript
   Scenario: Correct Journey Data entered
            Given I am signed in as admin from sheffield
            And I am on the dashboard page
            When I click "#reply_tweet_icon1" within "#incoming_tweets"
            When I fill in "startLocation" with "Diamond"
            When I fill in "endLocation" with "Meadowhall"
            When I press "Submit" within "#add_journey"
            Then I should see "Journey Added." within "#add_journey"
            
   @javascript
   Scenario: Incorrect Journey Data entered
            Given I am signed in as admin from sheffield
            And I am on the dashboard page
            When I click "#reply_tweet_icon1" within "#incoming_tweets"
            When I fill in "endLocation" with "Meadowhall"
            When I press "Submit" within "#add_journey"
            Then I should see "There were errors in your form submission"
            
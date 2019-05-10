Feature: Editing Journey on editJourney
   @javascript
   Scenario: Correct Journey Data entered
            Given I am signed in as admin from sheffield
            And I am on the settings page
            When I click "Edit" within first element in "#journeys" 
            When I fill in "taxiId" with "1"
            When I fill in "dateTime" with "8/2/2019"
            When I fill in "startLocation" with "Diamond"
            When I fill in "endLocation" with "Meadowhall"
            When I fill in "freeRide" with "0"
            When I fill in "cancelled" with "0"
            When I fill in "rating" with "4"
            When I fill in "convoLink" with "some_twitter_url"
            When I press "Submit"
            Then I should see "Journey Edited." 
            
            
   @javascript
   Scenario: Incorrect Journey Data entered
            Given I am signed in as admin from sheffield
            And I am on the settings page
            When I click "Edit" within first element in "#journeys" 
            When I fill in "taxiId" with "-1"
            When I press "Submit"
            Then I should see "There were errors in your form submission"
            
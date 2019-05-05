Feature: DisplayTaxi features
   @javascript
   Scenario: Machester taxis are displayed when admin is from manchester
            Given I am signed in as admin from manchester
            Given I am on the dashboard page
            Then I should see "MANCHESTER" within "#taxis"
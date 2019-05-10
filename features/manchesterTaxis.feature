Feature: Dashboard displays taxi correctly according to admin
   @javascript
   Scenario: Machester taxis are displayed when admin is from manchester
            Given I start a new session
            Given I am signed in as admin from manchester
            Given I am on the dashboard page
            Then I should see "MANCHESTER" within "#taxis"
            And I start a new session
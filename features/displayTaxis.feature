Feature: Switching from unavailable to available
   @javascript
   Scenario: Available taxi is now unavailable
            Given I am signed in as admin from sheffield
            And I am on the dashboard page
            When I click "#add_icon0" within "#availableTaxis"
            Then I should see "1" within "#unavailableTaxis"
            
   @javascript
   Scenario: Unavailable taxi is now available
            Given I am signed in as admin from sheffield
            Given I am on the dashboard page
            When I click "#delete_icon0" within "#unavailableTaxis"
            Then I should see "1" within "#availableTaxis"
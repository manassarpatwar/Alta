Feature: DisplayTaxi add and remove buttons working
   @javascript
   Scenario: Available taxi is now unavailable
            Given I am signed in as admin
            And I am on the dashboard page
            When I click "#add_icon0" within "#availableTaxis"
            Then I should see "1" within "#unavailableTaxis"
            
   @javascript
   Scenario: Unavailable taxi is now available
            Given I am signed in as admin
            And I am on the dashboard page
            When I click "#delete_icon0" within "#unavailableTaxis"
            Then I should see "1" within "#availableTaxis"
            
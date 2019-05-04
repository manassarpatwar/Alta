Feature: DisplayTaxi features
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
            
    @javascript
   Scenario: Machester taxis are displayed when admin is from manchester
            Given I log out of twitter
            Given I am signed in as admin from manchester
            Given I am on the dashboard page
            Then I should see "MANCHESTER"
            
  Feature: deleting data
        @javascript
        Scenario: Correct Date/Time entered
            Given I am signed in as admin from sheffield
            And I am on the addUser page
            When I fill in "freeRide" with "10"
            When I fill in "userType" with "0"
            When I fill in "dateTime" with "1232245678"
            When I fill in "name" with "Gerald"
            When I fill in "id" with randomid
            When I press "Submit"
            Then I should see "User Added"
            And I am on the settings page
            When I click "Delete" within last element in "#users"
            And I click on the alert
            Then I should not see "1232245678" within "#users"
Feature: Adding data
            
        @javascript
        Scenario: Correct Date/Time entered
            Given I am on the settings page
            When I fill in "freeRide" with "10"
            When I fill in "userType" with "0"
            When I fill in "dateTime" with "20/03/2019 11:50"
            When I fill in "name" with "Gerald"
            When I fill in "id" with randomid
            When I press "Submit" within "#add_user"
            Then I should see "User Added"
        
        @javascript
        Scenario: Wrong Date/Time entered
             Given I am on the settings page
             When I fill in "freeRide" with "-1"
             When I fill in "userType" with "0"
             When I fill in "dateTime" with "20/03/2019 11:50"
             When I fill in "name" with "Gerald"
             When I fill in "id" with "12094109210"
             When I press "Submit" within "#add_user"
             Then I should see "There were errors in your form submission, please correct them below"
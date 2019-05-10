Feature: Editing data on editUser
            
        @javascript
        Scenario: Correct Date/Time entered
            Given I am signed in as admin from sheffield
            And I am on the settings page
            When I click "Edit" within first element in "#users" 
            When I fill in "freeRide" with "10"
            When I press "Submit"
            Then I should see "User Edited"
        
        @javascript
        Scenario: Wrong user type entered
           Given I am signed in as admin from sheffield
           And I am on the settings page
           When I click "Edit" within first element in "#users" 
           When I fill in "freeRide" with "-1"
           When I fill in "userType" with "5"
           When I press "Submit"
           Then I should see "There were errors in your form submission, please correct them below"
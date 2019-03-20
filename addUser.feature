Feature: Adding data

        Scenario: Correct Date/Time entered
            Given I am on the setting in admin dashboard
            When I fill in "freeRide" with "10"
            When I fill in "userType" with "0"
            When I fill in "dateTime" with "20/03/2019 11:50"
            When I fill in "name" with "Gerald"
            When I fill in "id" with "12094109210"
            When I press "Submit" within "form"
            Then I should see "User Added"

        Scenario: Wrong Date/Time entered
             Given I am on the setting in admin dashboard
             When I fill in "freeRide" with "-1"
             When I fill in "userType" with "0"
             When I fill in "dateTime" with "20/03/2019 11:50"
             When I fill in "name" with "Gerald"
             When I fill in "id" with "12094109210"
             When I press "Submit" within "form"
             Then I should see "There were errors in your form submission, please correct them below"
             Then I should see "Please enter a valid free ride value (0 or more)"                          
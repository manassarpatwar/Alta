Feature: Adding data
            
        @javascript
        Scenario: Correct Data entered
            Given I am signed in as admin from sheffield
            And I am on the settings page
            When I fill in "regNum" with randomid
            When I fill in "contact" with randomid
            When I fill in "taxiType" with "L"
            When I fill in "city" with "SHEFFIELD"
            When I press "Submit" within "#add_taxi"
            Then I should see "Taxi Added"
        
       @javascript
        Scenario: Missing Data
            Given I am signed in as admin from sheffield
            And I am on the settings page
            When I fill in "regNum" with randomid
            When I fill in "contact" with "12345"
            When I fill in "taxiType" with "L" 
            When I press "Submit" within "#add_taxi"
            Then I should see "There were errors in your form submission"
            
        @javascript
        Scenario: Duplicate contact and wrong taxi type entered
            Given I am signed in as admin from sheffield
            And I am on the settings page
            When I fill in "regNum" with "12345"
            When I fill in "contact" with "12345"
            When I fill in "taxiType" with "L"
            When I fill in "city" with "SHEFFIELD"
            When I press "Submit" within "#add_taxi"
            When I fill in "regNum" with "12345"
            When I fill in "contact" with "12345"
            When I fill in "taxiType" with "O"
            When I press "Submit" within "#add_taxi"
            Then I should see "There were errors in your form submission"
            
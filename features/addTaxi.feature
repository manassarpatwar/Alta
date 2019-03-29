Feature: Adding data
            
        @javascript
        Scenario: Correct Data entered
            Given I am on the settings page
            When I fill in "regNum" with randomid
            When I fill in "contact" with randomid
            When I fill in "taxiType" with "L"
            When I fill in "city" with "SHEFFIELD"
            When I press "Submit" within "#add_taxi"
            Then I should see "Taxi Added"
        
       @javascript
        Scenario: Correct Data entered
            Given I am on the settings page
            When I fill in "regNum" with randomid
            When I fill in "taxiType" with "L"
            When I press "Submit" within "#add_taxi"
            Then I should see "There were errors in your form submission"
            
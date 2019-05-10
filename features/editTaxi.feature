Feature: Editing taxi on editTaxi
            
        @javascript
        Scenario: Correct Data entered
            Given I am signed in as admin from sheffield
            And I am on the settings page
            When I click "Edit" within first element in "#taxis" 
            When I fill in "regNum" with "1"
            When I fill in "contact" with randomid
            When I fill in "taxiType" with "L"
            When I fill in "city" with "SHEFFIELD"
            When I press "Submit"
            Then I should see "Taxi Edited"
        
       @javascript
        Scenario: Missing Data & wrong data
            Given I am signed in as admin from sheffield
            And I am on the settings page
            When I click "Edit" within first element in "#taxis" 
            When I fill in "contact" with randomid
            When I fill in "taxiType" with "0" 
            When I press "Submit"
            Then I should see "There were errors in your form submission"
            
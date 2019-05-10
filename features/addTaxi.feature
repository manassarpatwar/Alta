Feature: Adding taxi to addTaxi
            
        @javascript
        Scenario: Correct Data entered
            Given I am signed in as admin from sheffield
            And I am on the addTaxi page
            When I fill in "regNum" with randomid
            When I fill in "contact" with randomid
            When I fill in "taxiType" with "L"
            When I fill in "city" with "SHEFFIELD"
            When I press "Submit"
            Then I should see "Taxi Added"
        
       @javascript
        Scenario: Missing Data
            Given I am signed in as admin from sheffield
            And I am on the addTaxi page
            When I fill in "regNum" with randomid
            When I fill in "contact" with "12345"
            When I fill in "taxiType" with "L" 
            When I press "Submit"
            Then I should see "There were errors in your form submission"
            
        @javascript
        Scenario: Duplicate contact and wrong taxi type entered
            Given I am signed in as admin from sheffield
            And I am on the addTaxi page
            When I fill in "regNum" with "12345"
            When I fill in "contact" with "12345"
            When I fill in "taxiType" with "L"
            When I fill in "city" with "SHEFFIELD"
            When I press "Submit"
            And I am on the addTaxi page
            When I fill in "regNum" with "12345"
            When I fill in "contact" with "12345"
            When I fill in "taxiType" with "O"
            When I press "Submit"
            Then I should see "There were errors in your form submission"
            
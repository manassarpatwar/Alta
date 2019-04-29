Feature: Editing data
            
        @javascript
        Scenario: Correct Data entered
            Given I am signed in as admin from sheffield
            And I am on the settings page
            When I click "Edit" within first element in "#complaints" 
            When I fill in "journey_id" with randomid
            When I fill in "user_id" with randomid
            When I fill in "complaint" with "I am not satisfied"
            When I press "Submit"
            Then I should see "Complaint Edited"
        
        @javascript
        Scenario: Missing Data
            Given I am signed in as admin from sheffield
            And I am on the settings page
            When I click "Edit" within first element in "#complaints" 
            When I fill in "journey_id" with ""
            When I fill in "complaint" with "I am not satisfied"
            When I press "Submit"
            Then I should see "There were errors in your form submission"
Feature: Adding data
            
        @javascript
        Scenario: Correct Data entered
            Given I am on the settings page
            When I fill in "journey_id" with randomid
            When I fill in "user_id" with randomid
            When I fill in "complaint" with "I am not satisfied"
            When I press "Submit" within "#add_complaint"
            Then I should see "Complaint Added"
        
        @javascript
        Scenario: Missing Data
            Given I am on the settings page
            When I fill in "journey_id" with randomid
            When I fill in "complaint" with "I am not satisfied"
            When I press "Submit" within "#add_complaint"
            Then I should see "There were errors in your form submission"
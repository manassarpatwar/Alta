Feature: Adding data
            
        @javascript
        Scenario: Correct Data entered
            Given I am signed in as admin from sheffield
            And I am on the addFeedback page
            When I fill in "journey_id" with randomid
            When I fill in "user_id" with randomid
            When I fill in "feedback" with "I am not satisfied"
            When I fill in "rating" with "0"
            When I press "Submit"
            Then I should see "Feedback Added"
        
        @javascript
        Scenario: Missing Data
            Given I am signed in as admin from sheffield
            And I am on the addFeedback page
            When I fill in "journey_id" with randomid
            When I fill in "feedback" with "I am not satisfied"
            When I press "Submit"
            Then I should see "There were errors in your form submission"
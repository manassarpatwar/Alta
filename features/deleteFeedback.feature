Feature: Deleting data
            
        @javascript
        Scenario: Correct Data entered
            Given I am signed in as admin from sheffield
            And I am on the addFeedback page
            When I fill in "journey_id" with randomid
            When I fill in "user_id" with randomid
            When I fill in "feedback" with "1232245678"
            When I press "Submit"
            Then I should see "Feedback Added"
            And I am on the settings page
            When I press "Delete" within last element in "#feedback"
            And I click on the alert
            Then I should not see "1232245678" within "#feedback"
        
        
Feature: Adding review to addReview
            
        @javascript
        Scenario: Correct Data entered
            Given I am signed in as admin from sheffield
            And I am on the my account page
            When I fill in "newReview" with "good service" within "#addReview"
            When I click "#rating-4" within "#addReview"
            When I press "Submit" within "#addReview"
            Then I should see "THANK YOU FOR YOUR FEEDBACK." within "#addReview"
            
        @javascript
        Scenario: Correct Data entered
            Given I am signed in as admin from sheffield
            And I am on the my account page
            When I click "#rating-4" within "#addReview"
            When I press "Submit" within "#addReview"
            Then I should see "PLEASE ENTER FEEDBACK" within "#addReview"

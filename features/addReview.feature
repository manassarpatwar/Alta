Feature: Adding review
            
        @javascript
        Scenario: Correct Data entered
            Given I am signed in as admin from sheffield
            And I am on the user orders page
            When I fill in "newReview" with "good service" within "#addNewReview"
            When I click "#rate3" within ".generalReviewBox"
            Then I should see "THANK YOU FOR YOUR FEEDBACK." within "#addNewReview"
            
        @javascript
        Scenario: Correct Data entered
            Given I am signed in as admin from sheffield
            And I am on the user orders page
            When I click "#rate3" within ".generalReviewBox"
            Then I should see "PLEASE ENTER FEEDBACK" within "#addNewReview"

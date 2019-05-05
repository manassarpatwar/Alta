Feature: Editing data
            
        @javascript
        Scenario: Correct Deal entered
            Given I am signed in as admin from sheffield
            And I am on the settings page
            When I fill in "rideDeal" with "10"
            When I click "#rideDealEdit" within "#rideDealForm"
            Then I should see "Ride deal value updated."
        
        @javascript
        Scenario: Correct Deal entered
            Given I am signed in as admin from sheffield
            And I am on the settings page
            When I fill in "rideDeal" with "-64"
            When I click "#rideDealEdit" within "#rideDealForm"
            Then I should see "Please enter a valid ride deal"
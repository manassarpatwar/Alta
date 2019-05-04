Feature: Testing User Orders page 
       @javascript
       Scenario: Testing go to user orders page
            Given I am signed in as admin from sheffield
            And I am on the user orders page
            Then I should see "SUMMARY"
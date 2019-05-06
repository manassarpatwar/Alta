Feature: Testing My account page 
       @javascript
       Scenario: Testing go to my account page
            Given I am signed in as admin from sheffield
            And I am on the my account page
            Then I should see "SUMMARY"
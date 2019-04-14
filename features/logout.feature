Feature: Testing logging out
       @javascript
       Scenario: Testing go to login page and sign in and then logout
              Given I am signed in as admin from sheffield
              And I am on the logout page
              And I go to the home page
              Then I should see "LOG IN" within ".nav-signin"
              
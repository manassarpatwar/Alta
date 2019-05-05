Feature: Testing logging in
       @javascript
       Scenario: Testing go to login page and sign in
              Given I log out of twitter
              Given I am on the login page
              When I fill in "Username or email" with "ise19team29"
              When I fill in "Password" with "SoftEng2019"
              When I press "Sign In"
              And I am on the dashboard page
              Then I should see "Taxis"
              And I am on the logout page
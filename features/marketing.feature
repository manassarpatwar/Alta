Feature: Follow by keyword and tweet to timeline
   @javascript
   Scenario: Follow by keyword
            Given I am signed in as admin from sheffield
            And I am on the marketing page
            When I fill in "follow" with "taxi"
            When I press "Follow"
            Then I should see "You followed 5 people that used this keyword recently."
            
   @javascript 
   Scenario: Tweet to timeline
            Given I am signed in as admin from sheffield
            And I am on the marketing page
            When I fill in "tweet" with "Testing tweet to timeline"
            When I press "Tweet"
            Then I should see "Your tweet has been posted"
            And I delete the reply
            
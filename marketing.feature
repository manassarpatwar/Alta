Feature: Follow by keyword and tweet to timeline

   Scenario: Follow by keyword
            Given I am on the marketing page
            And I am on the marketing page
            When I fill in "follow" with "taxi"
            When I press "submit" within "#follow"
            Then I should see "You followed 5 people that used this keyword recently." within "#follow"
            

   Scenario: Tweet to timeline
            Given I am on the marketing page
            And I am on the marketing page
            When I fill in "tweet" with "Testing tweet to timeline"
            When I press "submit" within "#tweet"
            Then I should see "Your tweet has been posted" within "#tweet"
            
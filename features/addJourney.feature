Feature: Add Journey
   @javascript
   Scenario: Correct Journey Data entered
            Given I am on the dashboard page
            When I fill in "taxiId" with randomid
            When I fill in "userId" with randomid
            When I fill in "twitterHandle" with "something"
            When I fill in "dateTime" with "8/2/2019"
            When I fill in "startLocation" with "Diamond"
            When I fill in "endLocation" with "Meadowhall"
            When I fill in "freeRide" with "0"
            When I fill in "cancelled" with "0"
            When I fill in "rating" with "4"
            When I fill in "convoLink" with "some_twitter_url"
            When I press "Submit" within "#add_journey"
            Then I should see "Journey Added."
            
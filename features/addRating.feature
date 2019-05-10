Feature: Adding rating to addRating
            
        @javascript
        Scenario: Correct Data entered
            Given I am signed in as admin from sheffield
            And I am on the addJourney page
            When I fill in "taxiId" with randomid
            When I fill in "userId" with "1092444312430919681"
            When I fill in "twitterHandle" with "ise19team29"
            When I fill in "dateTime" with "8/2/2019"
            When I fill in "startLocation" with "Diamond"
            When I fill in "endLocation" with "Meadowhall"
            When I fill in "freeRide" with "0"
            When I fill in "cancelled" with "0"
            When I fill in "rating" with "0"
            When I fill in "convoLink" with "some_twitter_url"
            When I press "Submit" within "#add_journey"
            Then I should see "Journey Added."
            And I am on the my account page
            When I click "#rating-3" within ".rating0"
            Then I should see css ".rating0 .fa-star" "3" times

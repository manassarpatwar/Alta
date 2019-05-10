Feature: Analytics headings correct
        @javascript
        Scenario: Correct page heading
            Given I am signed in as admin from sheffield
            And I am on the analytics page
            Then I should see "Analytics"
            Then I should see "Total number of users by day:"
            Then I should see "Total number of journeys taken by day:"
            Then I should see "Total number of feedback given by day:"
            Then I should see "Number of taxis registered:"
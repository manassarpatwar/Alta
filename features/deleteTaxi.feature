  Feature: Deleting taxi on settings
        @javascript
        Scenario: Correct Data entered
            Given I am signed in as admin from sheffield
            And I am on the addTaxi page
            When I fill in "regNum" with "1232245678"
            When I fill in "contact" with randomid
            When I fill in "taxiType" with "L"
            When I fill in "city" with "SHEFFIELD"
            When I press "Submit"
            Then I should see "Taxi Added"
            And I am on the settings page
            When I press "Delete" within last element in "#taxis"
            And I click on the alert
            Then I should not see "1232245678" within "#taxis"
      
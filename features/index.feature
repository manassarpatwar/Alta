Feature: Testing Navigation of Home page         
       Scenario: Testing go home navigation link
            Given I am on the home page
            When I follow "alta" within "nav"
            Then I should see "RIDE WITH US" within "#section0"  
        
       Scenario: Testing How To? navigation link
            Given I am on the home page
            When I follow "how to?" within ".nav-center"
            Then I should see "How to Use our Services" within "#section1"
       Scenario: Testing Deals navigation link
            Given I am on the home page
            When I follow "deals" within ".nav-center"
            Then I should see "Deals" within "#section2"
       Scenario: Testing Services navigation link
            Given I am on the home page within "#section1"
            When I follow "services" within ".nav-center"
            Then I should see "Types of Taxis" within "#section3"
       Scenario: Testing Reviews navigation link
            Given I am on the home page
            When I follow "reviews" within ".nav-center"
            Then I should see "What Do People Say" within "#section4"
       Scenario: Testing About navigation link
            Given I am on the home page
            When I follow "about" within ".nav-center"
            Then I should see "About Us" within "#section5"
       Scenario: Testing Contact navigation link
            Given I am on the home page
            When I follow "contact" within ".nav-center"
            Then I should see "Get in Touch" within "#section6"
                          
Feature: When I search for a Invoice I should see a autocomplete list
  Scenario: Type in search field and list matches
    Given I am signed in
      And there is a setting_name
      And there is a setting_website
      
      And there is a customer with the name "Weirdboy1" and the address "Teufelsstr. 1" and the company "Paloma, Pinky & the Brain"
      And there is a entry with the title "Weirdstufff1" and the status "paid" and the delivery_date "2016-02-03 08:00:00 +0200" and the customer above
      And there is a item with the price "245.67" and the count "90" with the entry above
      And there is a item with the price "86.72" and the count "60" with the entry above

      And there is a entry with the title "Weirdstufff2" and the status "paid" and the delivery_date "2016-02-03 08:00:00 +0200" and the customer above
      And there is a item with the price "25.93" and the count "120" with the entry above
      And there is a item with the price "12.22" and the count "70" with the entry above

      When I go to the edit admin customer page for that customer

      Then show me the page

      And the "customer[name]" field should contain "Weirdboy1"
      And the "customer[company]" field should contain "Paloma, Pinky & the Brain"
      And the "customer[address]" field should contain "Teufelsstr. 1"

      And I should see "455,23 €" in the HTML
      And I should see "66,12 €" in the HTML
      And I should see "521,35 € total" in the HTML



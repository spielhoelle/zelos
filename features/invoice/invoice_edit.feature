Feature: I change the values of the invoice and see the expected result
  Scenario: Check invoice edit view
    Given I am signed in
      And there is a setting_name
      And there is a setting_website
      
      And there is a customer with the name "Customer"
      And there is a entry with the title "Invoice" and the delivery_date "2013-12-08 08:00:00 +0200" and the customer above
      And there is a item with the name "Modern IT slavery" the price "150.31" and the count "60" and with the entry above
      And there is a item with the name "Big afford, less money" the price "170.72" and the count "90" and with the entry above
      And there is a item with the name "NGO development without result" the price "199.99" and the count "150" and with the entry above

    When I go to the edit admin entry page for that entry

      Then the "entry[items_attributes][0][name]" field should contain "Modern IT slavery"
      And the "entry[items_attributes][0][count_hours]" field should contain "1"
      #And the "entry[items_attributes][0][count_mins]" field should contain "0"
    
      Then the "entry[items_attributes][1][name]" field should contain "Big afford, less money"
      And the "entry[items_attributes][1][count_hours]" field should contain "1"
      #And the "entry[items_attributes][1][count_mins]" field should contain "30"

      Then the "entry[items_attributes][2][name]" field should contain "NGO development without result"
      And the "entry[items_attributes][2][count_hours]" field should contain "2"
      #And the "entry[items_attributes][2][count_mins]" field should contain "30"


    Then I should see "5:0 H" in the HTML
    Then I should see "906,37 €" in the HTML
    #When I hit on the "open_in_browser" in the ".tooltipped.btn"

    #Then I should see "Modern" in the HTML
    #Then show me the page



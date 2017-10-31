Feature: When I search for a Invoice I should see a autocomplete list
  Scenario: Type in search field and list matches
    Given I am signed in
      And there is a setting_name
      And there is a setting_website
      
      And there is a customer with the name "Customer1" and the address "Rauschestr. 1" and the company "Glattbeck, Mephisto and Hildegard"
      And there is a entry with the title "Invoice1" and the delivery_date "2016-01-03 08:00:00 +0200"

      And there is a customer with the name "Customer2" and the address "Kunzestr. 1" and the company "Kilback, Pacocha and Dicki"
      And there is a entry with the title "Invoice2" and the delivery_date "2017-01-02 08:00:00 +0200" and the customer above
      And there is a item with the price "1234.56" and the count "60" with the entry above
    
      And there is a entry with the title "Invoice3" and the delivery_date "2017-01-03 08:00:00 +0200" and the customer above
      And there is a item with the price "2345.67" and the count "90" with the entry above
      And there is a item with the price "856.72" and the count "60" with the entry above

      And there is a customer with the name "Weirdboy1" and the address "Teufelsstr. 1" and the company "Paloma, Pinky & the Brain"
      And there is a entry with the title "Weirdstufff1" and the delivery_date "2016-02-03 08:00:00 +0200"

      And the "entry[customer_attributes][name]" field should contain "Customer2"
      And the "entry[customer_attributes][address]" field should contain "Kunzestr. 1"
      And the "entry[customer_attributes][company]" field should contain "Kilback, Pacocha and Dicki"

    When I hit on the "Customers" in the ".navbar-fixed"
      Then I should be on the edit admin customer page for the customer with the name "Customer2"
      And the "customer[name]" field should contain "Customer2"
      And the "customer[address]" field should contain "Kunzestr. 1"
      And the "customer[company]" field should contain "Kilback, Pacocha and Dicki"

      And I should see "1.234,56 €" in the HTML
      And I should see "3.202,39 €" in the HTML
      And I should see "4.436,95 € total" in the HTML
  


Feature: Bills shall be displayed correctly

  Scenario: Check Bill
    Given I am signed in
      And the date is 2017-06-01 12:00
      And there is a setting_name
      And there is a setting_website

      And there is a bill with the title "Laptop" and the price "1999.99" and the bill_date "2016-02-03 08:00:00 +0200"
      And there is a bill with the title "Buisness Lunch" and the price "79.99" and the bill_date "2017-06-23 08:00:00 +0200"
      And there is a bill with the title "Test Device" and the price "299.99" and the bill_date "2018-01-08 08:00:00 +0200"

      And there is a customer with the name "Customer4"
      And there is a entry with the title "Invoice4" and the delivery_date "2016-06-23 08:00:00 +0200" and the customer above

      And there is a item with the price "122.33" and with the count "60" with the entry above
      And there is a item with the price "2232.01" and with the count "90" with the entry above
      And there is a item with the price "200.21" and with the count "100" with the entry above

    When I go to the admin bills page


    Then I should see a table with exactly the following rows
      """
      | Title         | Bill date            | Total         | 
      | 2018 |
      | * Test Device *  | * 08.01.2018 *         | 299,99 €    | 
      | 2017 |
      | * Buisness Lunch *  | * 23.06.2017 *         | 79,99 €    | 
      | 2016 |
      | * Laptop *    | * 03.02.2016 *         | 1.999,99 €   | 
      """
      #When I click on the bill with the title "Laptop"
      When I hit on the "Laptop" in the ".bill--title"
      Then I should be on the edit admin bill page for the bill with the title "Laptop"
      Then show me the page

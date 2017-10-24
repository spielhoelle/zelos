Feature: There should be invoices visible in the admin entries page

  Scenario: Check invoice index view
    Given I am signed in
      And there is a setting_name
      And there is a setting_website
      
      And there is a customer with the name "Customer1"
      And there is a entry with the title "Invoice1" and the delivery_date "2016-01-03 08:00:00 +0200"

      And there is a customer with the name "Customer2"
      And there is a entry with the title "Invoice2" and the delivery_date "2017-01-02 08:00:00 +0200" and the customer above
      And there is a item with the price "1234.56" with the entry above

      And there is a customer with the name "Customer3"
      And there is a entry with the title "Invoice3" and the delivery_date "2013-12-08 08:00:00 +0200" and the customer above
      And there is a item with the price "150.31" with the entry above
      And there is a item with the price "170.72" with the entry above
      And there is a item with the price "199.99" with the entry above

      And there is a customer with the name "Customer4"
      And there is a entry with the title "Invoice4" and the delivery_date "2016-06-23 08:00:00 +0200" and the customer above

      And there is a item with the price "122.33" with the entry above
      And there is a item with the price "2232.01" with the entry above
      And there is a item with the price "200.21" with the entry above

    When I go to the admin invoice page

    Then I should see a table with exactly the following rows
      """
      | Type         | Title                 | Delivery date | Total        |
      | 2017 |
      | * Invoice2 * | * Customer2 *         | 02.01.2017    | 1.234,56 € * |
      | 2016 |
      | * Invoice4 * | * Customer4 *         | 23.06.2016    | 2.554,55 € * |
      | * Invoice1 * | * no customer set *   | 03.01.2016    | 0,00 € *     |
      | 2013 |
      | * Invoice3 * | * Customer3 *         | 08.12.2013    | 521,02 € *   |
      """

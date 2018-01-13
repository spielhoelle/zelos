User.create email: "admin@example.com", password: "password123", password_confirmation: "password123"
puts "User created"

Customer.create!([
  {name: "Example customer", company: "Corporate", address: "Example street 91"},
  {name: "Another example customer", company: "ACME", address: "Tree alley 54"}
])
puts "Customers created"

Entry.create!([
  {title: "My first cash this year", status: "paid", notes: "A note that will visible on the PDF", invoice_number: 149000001, invoice_date: ( Time.now - 3.days), delivery_date: (Time.now - 1.day), discount: 0, customer_id: Customer.first.id, private_note: "This note is just internally visible and will not be printed to the Invoice PDF"},
  {title: "Some stuff I did", status: "paid", notes: "A note that will visible on the PDF", invoice_number: 149000002, invoice_date: ( Time.now - 4.days), delivery_date: (Time.now - 1.months), discount: 0, customer_id: Customer.first.id, private_note: "This note is just internally visible and will not be printed to the Invoice PDF"},
  {title: "Example invoice title", status: "paid", notes: "A note that will visible on the PDF", invoice_number: 149000003, invoice_date: ( Time.now - 1.week), delivery_date: (Time.now - 2.months), discount: 0, customer_id: Customer.last.id, private_note: "This note is just internally visible and will not be printed to the Invoice PDF"},
  {title: "Older stuff", notes: "A note that will visible on the PDF", invoice_number: 149000005, invoice_date: ( Time.now - 2.weeks), delivery_date: (Time.now - 13.months), discount: 0, customer_id: Customer.last.id, private_note: "This note is just internally visible and will not be printed to the Invoice PDF"}
])
puts "Entries created"

Setting.create!([
  {var: "mail", value: "mail@example.com"},
  {var: "website", value: "www.example.com"},
  {var: "tax_id", value: "012345667"},
  {var: "bic", value: "ABCDEFG"},
  {var: "iban", value: "IBAN12345678990123456"},
  {var: "address", value: "Example Street, \n10000 Example City"},
  {var: "job", value: "Freelance Software Engeneer"},
  {var: "name", value: "My Name"}
])
puts "Settings created"

activity = ["Website development", "Plugin engineering", "Frontend design", "Backend architecture"]
Entry.all.each do |entry|
  (0..3).each do |index|
    Item.create!(entry_id: entry.id, name: activity.sample, price: rand(200..1300))
  end
end
Item.create!([
  {entry_id: Entry.first.id, name: "Website development", price: 500},
  {entry_id: Entry.first.id, name: "Frontend design", price: 700},
  {entry_id: Entry.find(1), name: "Plugin development", price: 800},
  {entry_id: Entry.find(2), name: "Website development", price: 500},
  {entry_id: Entry.find(2), name: "Frontend design", price: 700},
  {entry_id: Entry.find(3), name: "Plugin development", price: 800},
  {entry_id: Entry.find(3), name: "Website development", price: 500},
  {entry_id: Entry.last.id, name: "Frontend design", price: 700},
  {entry_id: Entry.last.id, name: "Plugin development", price: 800.21},
])
puts "Items created"
Bill.create!([
  {title: "Buisness lunch with Michael", price: 123.45, bill_date: (Time.now - 1.month), image: open("http://placecage.com/#{rand(200..400)}/#{rand(250..300)}"),},
  {title: "Laptop", price: 1999.99, bill_date: (Time.now - 3.month), image: open("http://placecage.com/#{rand(200..400)}/#{rand(250..300)}"),},
  {title: "Testdevise", price: 299.99, bill_date: (Time.now - 6.month - 1.year), image: open("http://placecage.com/#{rand(200..400)}/#{rand(250..300)}"),},
  {title: "Servercosts", price: 79.99, bill_date: (Time.now - 3.month), image: open("http://placecage.com/#{rand(200..400)}/#{rand(250..300)}"),},
  {title: "Domainservices", price: 29.99, bill_date: (Time.now - 4.month), image: open("http://placecage.com/#{rand(200..400)}/#{rand(250..300)}"),},
  {title: "Servercosts", price: 79.99, bill_date: (Time.now - 3.month - 1.year), image: open("http://placecage.com/#{rand(200..400)}/#{rand(250..300)}"),},
  {title: "Domainservices", price: 29.99, bill_date: (Time.now - 4.month - 1.year), image: open("http://placecage.com/#{rand(200..400)}/#{rand(250..300)}"),},
])
puts "Bills created"

User.create email: "admin@example.com", password: "password123", password_confirmation: "password123"

Customer.create!([
  {name: "Example customer", company: "Corporate", address: "Example street 91"},
  {name: "Another example customer", company: "ACME", address: "Tree alley 54"}
])

Entry.create!([
  {title: "My first cash this year", notes: "A note that will visible on the PDF", invoice_number: 149000001, invoice_date: Time.now, delivery_date: (Time.now - 1.month), discount: 0, customer_id: Customer.first.id, private_note: "This note is just internally visible and will not be printed to the Invoice PDF"},
  {title: "Example invoice title", notes: "A note that will visible on the PDF", invoice_number: 149000000, invoice_date: Time.now, delivery_date: (Time.now - 2.months), discount: 0, customer_id: Customer.last.id, private_note: "This note is just internally visible and will not be printed to the Invoice PDF"}
])

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

Item.create!([
  {entry_id: Entry.first.id, name: "Website development", price: 500},
  {entry_id: Entry.first.id, name: "Frontend design", price: 700},
  {entry_id: Entry.first.id, name: "Plugin development", price: 800},
  {entry_id: Entry.last.id, name: "Website development", price: 500},
  {entry_id: Entry.last.id, name: "Frontend design", price: 700},
  {entry_id: Entry.last.id, name: "Plugin development", price: 800},
  {entry_id: Entry.last.id, name: "Website development", price: 500},
  {entry_id: Entry.last.id, name: "Frontend design", price: 700},
  {entry_id: Entry.last.id, name: "Plugin development", price: 800},
])

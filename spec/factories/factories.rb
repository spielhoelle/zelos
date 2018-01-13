FactoryGirl.define do
  factory :setting do
    factory :setting_name do
      var "name"
      value "Tommy"
    end
    factory :setting_website do
      var "website"
      value "www.example.com"
    end
  end

  factory :entry do
    title { FFaker::Job.title }
    notes { FFaker::CheesyLingo.sentence }
    invoice_number 149000001 
    invoice_date { FFaker::Time.datetime } 
    delivery_date { FFaker::Time.datetime } 
    discount 0 
    private_note "This note is just internally visible and will not be printed to the Invoice PDF"
    #customer_id { Customer.first.id } 
  end

  factory :item do
    name { FFaker::Skill.tech_skill }
    price {rand(0..2000)}
  end
  factory :customer do
    name { FFaker::Name.first_name }
    company { FFaker::Company.name }
    address { FFaker::AddressDE.street_address }  
  end
  factory :bill do
    title { FFaker::Name.first_name }
    bill_date { FFaker::Time.datetime } 
    price {rand(0..2000)}
  end

end

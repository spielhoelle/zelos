FactoryBot.define do

  factory :user do
    email                                             { FFaker::Internet.email }
    password                                          {'secret42'}
    encrypted_password                                {'secret42'}
  end

  factory :raffle_entrant_user, class: 'User' do
    nickname { FFaker::Internet.user_name("Entrant") }
    email { FFaker::Internet.email }
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    password {'s3kr1t12234'}
    confirmed_at {1.day.ago}
    birthday {40.years.ago}
    zip_code {'12345'}
    country_code {'DE'}
    terms_regarding_use_and_data_protection_accepted {'1'}
  end

  factory :non_raffle_entrant_user, class: 'User' do
    nickname { FFaker::Internet.user_name("NonEntrant") }
    email { FFaker::Internet.email }
    password {'1337_s3kr1t'}
    confirmed_at {1.day.ago}
    zip_code {'12345'}
    country_code {'DE'}
    terms_regarding_use_and_data_protection_accepted {'1'}
    first_name {nil}
    last_name {nil}
    birthday {nil}
  end

end

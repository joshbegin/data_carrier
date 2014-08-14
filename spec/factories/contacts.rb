require 'faker'

FactoryGirl.define do
  factory :contact do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    phone { Faker::PhoneNumber.phone_number }
    address_line_1 { Faker::Address.street_address }
    address_line_2 { Faker::Address.secondary_address }
    address_line_3 { Faker::Address.secondary_address }
    city { Faker::Address.city }
    state_id (1..50).to_a.sample
    email { Faker::Internet.email }
    gender_id (1..2).to_a.sample
    title { Faker::Company.bs }
    notes { Faker::Lorem.paragraph(4) }
  end

  factory :minimal_contact , class: Contact do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
  end
end

require 'faker'

FactoryGirl.define do
  factory :company do
    company_type_id 1
    state_id State.all.sample.id
    name { Faker::Company.name }
    additional_name { Faker::Company.catch_phrase }
    address_line_1 { Faker::Address.street_address }
    address_line_2 { Faker::Address.secondary_address  }
    address_line_3 { Faker::Address.secondary_address }
    city { Faker::Address.city }
    zip { Faker::Address.zip_code }
    url { Faker::Internet.url }
    naic_code "NAIC 1"
    ai_carrier_code "AI Code 1"
    notes { Faker::Lorem.paragraph }
    parent_company_id ParentCompany.all.sample.id unless ParentCompany.first.nil?
  end

  factory :minimal_company, class: Company do
    name { Faker::Company.name }
    company_type_id 1
  end
end

require 'faker'

FactoryGirl.define do
  factory :parent_company do |f|
    f.name { Faker::Company.name }
    f.additional_name { Faker::Company.catch_phrase }
  end

  factory :minimal_parent_company, class: ParentCompany do |f|
    f.name { Faker::Company.name }
  end
end

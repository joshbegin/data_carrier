# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :company do
    parent_company nil
    company_type nil
    state nil
    name "MyString"
    additional_name "MyString"
    address_line_1 "MyString"
    address_line_2 "MyString"
    address_line_3 "MyString"
    city "MyString"
    zip "MyString"
    url "MyString"
    naic_code "MyString"
    ai_carrier_code "MyString"
    notes "MyText"
  end
end

require 'faker'

FactoryGirl.define do
  factory :feed do
    name { Faker::Company.name }
    notes { Faker::Lorem.paragraph }
    stage_feed_url { Faker::Internet.url }
    production_feed_url { Faker::Internet.url }
    production_start_date "2014-06-22 15:27:49"
    production_end_date "2014-06-22 15:27:49"
    company_id 1
    feed_status_id 1
    feed_frequency_id 1
    feed_type_id 1
    transaction_type "1125"
    sent_to_data_rail true
    enhanced_carrier_status true
    data_rail_api_key "12345abc"
    data_rail_password "verysecurepassword"
    data_rail_queue_priority 1
    data_view_username "test_user"
    data_view_password "verysecurepassword"
    partner { Faker::Company.name }
    split_by_data_rail true
    source_system_type_id 1
    destination_system_type_id 1
    source_transmission_type_id 1
    destination_transmission_type_id 1
    parent_feed_id 2
  end

  factory :minimal_feed, class: Feed do
    name { Faker::Company.name }
    company_id 1
    feed_status_id 1
    feed_type_id 1
  end
end

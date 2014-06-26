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
  end

  factory :minimal_feed, class: Feed do
    name { Faker::Company.name }
    company_id 1
    feed_status_id 1
    feed_type_id 1
  end
end

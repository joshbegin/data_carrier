# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email

states = {
      "Alabama" => "AL",
      "Alaska" => "AK",
      "Arizona" => "AZ",
      "Arkansas" => "AR",
      "California" => "CA",
      "Colorado" => "CO",
      "Connecticut" => "CT",
      "Delaware" => "DE",
      "Florida" => "FL",
      "Georgia" => "GA",
      "Hawaii" => "HI",
      "Idaho" => "ID",
      "Illinois" => "IL",
      "Indiana" => "IN",
      "Iowa" => "IA",
      "Kansas" => "KS",
      "Kentucky" => "KY",
      "Louisiana" => "LA",
      "Maine" => "ME",
      "Maryland" => "MD",
      "Massachusetts" => "MA",
      "Michigan" => "MI",
      "Minnesota" => "MN",
      "Mississippi" => "MS",
      "Missouri" => "MO",
      "Montana" => "MT",
      "Nebraska" => "NE",
      "Nevada" => "NV",
      "New Hampshire" => "NH",
      "New Jersey" => "NJ",
      "New Mexico" => "NM",
      "New York" => "NY",
      "North Carolina" => "NC",
      "North Dakota" => "ND",
      "Ohio" => "OH",
      "Oklahoma" => "OK",
      "Oregon" => "OR",
      "Pennsylvania" => "PA",
      "Rhode Island" => "RI",
      "South Carolina" => "SC",
      "South Dakota" => "SD",
      "Tennessee" => "TN",
      "Texas" => "TX",
      "Utah" => "UT",
      "Vermont" => "VT",
      "Virginia" => "VA",
      "Washington" => "WA",
      "West Virginia" => "WV",
      "Wisconsin" => "WI",
      "Wyoming" => "WY"
    }

states.each do |name, abbreviation|
  unless State.where(name: name).first
    State.create({name: name, abbreviation: abbreviation})
  end
end

puts "#{State.count} States"

CompanyType.create(name: "Carrier")
CompanyType.create(name: "Exam")

puts "#{CompanyType.count} Types of Companies"

frequencies = [
  "Real-time",
  "Every 15 minutes",
  "Every 30 minutes",
  "Hourly",
  "Hourly during business hours",
  "8 times per day",
  "7 times per day",
  "6 times per day",
  "5 times per day",
  "4 times per day",
  "3 times per day",
  "Twice a day",
  "Daily",
  "Twice a week",
  "Weekly",
  "Bi-weekly",
  "Monthly"]

frequencies.each do |frequency|
  FeedFrequency.create(name: frequency)
end

puts "#{FeedFrequency.count} types of feed frequencies"

statuses = [
  "In the pipeline",
  "Test",
  "Production"
]

statuses.each do |status|
  FeedStatus.create(name: status)
end

puts "#{FeedStatus.count} types of feed statuses"

types = [
  "Pending",
  "Inforce",
  "Commission",
  "License & Appointment",
  "Two-Way Messaging",
  "App Upload"
]

types.each do |type|
  FeedType.create(name: type)
end

puts "#{FeedType.count} types of feed types"
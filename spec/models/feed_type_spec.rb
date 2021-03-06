require 'rails_helper'

describe FeedType, :type => :model do

  it { is_expected.to respond_to(:name) }

  it "has the correct values" do
    types = [
      "Pending",
      "Inforce",
      "Commission",
      "License & Appointment",
      "Two-Way Messaging",
      "App Upload",
      "Partner Connections"
    ]

    types.each do |t|
      expect(FeedType.find_by_name(t)).to be_valid
    end
  end

  it { is_expected.to have_many(:feeds) }
end

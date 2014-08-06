require 'spec_helper'

describe FeedStatus, :type => :model do

  it { is_expected.to respond_to(:name) }

  it "has the correct values" do
    statuses = [
      "In the pipeline",
      "Test",
      "Production"
    ]

    statuses.each do |s|
      expect(FeedStatus.find_by_name(s)).to be_valid
    end
  end

  it { is_expected.to have_many(:feeds) }
end

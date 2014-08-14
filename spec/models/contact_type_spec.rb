require 'rails_helper'

RSpec.describe ContactType, :type => :model do

  it { is_expected.to respond_to(:name) }

  it "has the correct values" do
    contact_types = [
      "Business",
      "Technical",
      "Support",
      "iPipeline"
    ]

    contact_types.each do |f|
      expect(ContactType.find_by_name(f)).to be_valid
    end
  end

  it { is_expected.to have_many(:feed_contacts) }
end

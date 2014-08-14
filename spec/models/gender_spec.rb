require 'rails_helper'

RSpec.describe Gender, :type => :model do

  it { is_expected.to have_many(:contacts) }
  it { is_expected.to respond_to(:name) }

  it "has the correct values" do
    genders = [
      "Male",
      "Female"
    ]

    genders.each do |f|
      expect(Gender.find_by_name(f)).to be_valid
    end
  end

end

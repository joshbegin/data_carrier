require 'spec_helper'

describe SystemType, :type => :model do
  it { is_expected.to respond_to(:name) }

  it "has the correct values" do
    system_types = [
      "DataRail",
      "Carrier",
      "AMS",
      "iGO",
      "Partner"
    ]

    system_types.each do |f|
      expect(SystemType.find_by_name(f)).to be_valid
    end
  end

  it { is_expected.to have_many(:source_type_feeds).class_name('Feed') }
  it { is_expected.to have_many(:destination_type_feeds).class_name('Feed') }

end

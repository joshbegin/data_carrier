require 'spec_helper'

describe CompanyType, :type => :model do

    it { is_expected.to respond_to(:name) }

    it "has the correct values" do
      types = [
        "Carrier",
        "Exam"
      ]

      types.each do |t|
        expect(CompanyType.find_by_name(t)).to be_valid
      end
    end

    it { is_expected.to have_many(:companies) }
end

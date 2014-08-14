require 'rails_helper'

describe ParentCompany, :type => :model do

  before(:each) do
    @attr = {
      :name => "Example User",
      :additional_name => "Alias name"
    }
  end

  it { is_expected.to validate_presence_of(:name) }

  it do
    ParentCompany.create!(@attr)
    is_expected.to validate_uniqueness_of(:name)
  end

  it "should have a recently_updated method" do
    FactoryGirl.create_list(:parent_company, 3)
    expect(ParentCompany.recently_updated(5).count).to eq(3)
  end

  it { is_expected.to have_many(:companies) }
end

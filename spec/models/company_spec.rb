require 'rails_helper'

describe Company, :type => :model do

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:company_type_id) }
  it { is_expected.to validate_uniqueness_of(:name) }

  it "should have a recently_updated method" do
    FactoryGirl.create_list(:company, 3)
    expect(Company.recently_updated(5).count).to eq(3)
  end

  it { is_expected.to belong_to(:parent_company) }
  it { is_expected.to belong_to(:company_type) }
  it { is_expected.to belong_to(:state) }
end

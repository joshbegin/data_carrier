require 'spec_helper'

describe ParentCompany do

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

  it { should have_many(:companies) }
end

require 'spec_helper'

describe ParentCompany do

  before(:each) do
    @attr = {
      :name => "Example User",
      :additional_name => "Alias name"
    }
  end

  it { should validate_presence_of(:name) }

  it do
    ParentCompany.create!(@attr)
    should validate_uniqueness_of(:name)
  end
end

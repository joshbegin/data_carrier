require 'spec_helper'

describe CompanyType do
  before(:each) do
      FactoryGirl.create(:company_type)
    end

    it { is_expected.to respond_to(:name) }
end

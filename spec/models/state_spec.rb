require 'spec_helper'

describe State do
  before(:each) do
    FactoryGirl.create(:state)
  end

  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:abbreviation) }

end

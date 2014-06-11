require 'spec_helper'

describe Company do

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:company_type_id) }
  it { is_expected.to validate_uniqueness_of(:name) }
end

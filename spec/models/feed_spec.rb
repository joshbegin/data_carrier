require 'spec_helper'

describe Feed do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:company_id) }
  it { is_expected.to validate_uniqueness_of(:name) }
  it { is_expected.to validate_presence_of(:feed_status_id) }
  it { is_expected.to validate_presence_of(:feed_type_id) }

  it "should have a recently_updated method"

  it { should belong_to(:feed_frequency) }
  it { should belong_to(:feed_status) }
  it { should belong_to(:feed_type) }
  it { should belong_to(:company) }
end

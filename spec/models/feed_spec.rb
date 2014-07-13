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
  it { should belong_to(:source_system_type).class_name('SystemType') }
  it { should belong_to(:destination_system_type).class_name('SystemType') }
  it { should belong_to(:source_transmission_type).class_name('TransmissionType') }
  it { should belong_to(:destination_transmission_type).class_name('TransmissionType') }
  it { should have_many(:child_feeds).class_name('Feed') }
  it { should belong_to(:parent_feed).class_name('Feed') }

end

require 'rails_helper'

RSpec.describe FeedContact, :type => :model do
  it { is_expected.to validate_presence_of(:feed_id) }
  it { is_expected.to validate_presence_of(:contact_id) }
  it { is_expected.to validate_presence_of(:contact_type_id) }

  it { is_expected.to belong_to(:feed) }
  it { is_expected.to belong_to(:contact) }
  it { is_expected.to belong_to(:contact_type) }
end

require 'rails_helper'

RSpec.describe Contact, :type => :model do
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }

  it { is_expected.to have_many(:feeds).through(:feed_contacts) }
  it { is_expected.to belong_to(:gender) }
  it { is_expected.to belong_to(:state) }

  it "should have a full_name method" do
    @contact = FactoryGirl.create(:contact)
    FactoryGirl.create(:contact)
    expect(@contact.full_name).to eq("#{@contact.first_name} #{@contact.last_name}")
  end
end

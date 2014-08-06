require 'spec_helper'

describe Feed, :type => :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:company_id) }
  it { is_expected.to validate_uniqueness_of(:name) }
  it { is_expected.to validate_presence_of(:feed_status_id) }
  it { is_expected.to validate_presence_of(:feed_type_id) }

  it "should have a recently_updated method" do
    FactoryGirl.create_list(:feed, 3)
    expect(Feed.recently_updated(5).count).to eq(3)
  end

  it "should have a name_with_company method" do
    @feed = FactoryGirl.create(:feed)
    FactoryGirl.create(:company)
    expect(@feed.name_with_company).to eq("#{@feed.company.name} - #{@feed.name}")
  end

  it "should have a partner_connections method" do
    FactoryGirl.create_list(:feed, 3)
    @company = FactoryGirl.create(:company)
    Feed.last.update_attributes(destination_system_type_id: 5)
    expect(Feed.partner_connections(@company).count).to eq(1)
  end

  it "should not allow the Parent Feed to be the Feed" do
    @feed = FactoryGirl.create(:feed)
    @feed.parent_feed_id = @feed.id
    expect(@feed.save).to eq(false)
  end

  it "should ensure Parent Feed Company is the same as Feed Company" do
    @feed = FactoryGirl.create(:feed)
    @parent = FactoryGirl.create(:feed, company_id: 2)
    FactoryGirl.create(:company)
    @feed.parent_feed_id = @parent.id
    expect(@feed.save).to eq(false)
  end

  it { is_expected.to belong_to(:feed_frequency) }
  it { is_expected.to belong_to(:feed_status) }
  it { is_expected.to belong_to(:feed_type) }
  it { is_expected.to belong_to(:company) }
  it { is_expected.to belong_to(:source_system_type).class_name('SystemType') }
  it { is_expected.to belong_to(:destination_system_type).class_name('SystemType') }
  it { is_expected.to belong_to(:source_transmission_type).class_name('TransmissionType') }
  it { is_expected.to belong_to(:destination_transmission_type).class_name('TransmissionType') }
  it { is_expected.to have_many(:child_feeds).class_name('Feed') }
  it { is_expected.to belong_to(:parent_feed).class_name('Feed') }

end

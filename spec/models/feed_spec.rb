require 'spec_helper'

describe Feed do
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

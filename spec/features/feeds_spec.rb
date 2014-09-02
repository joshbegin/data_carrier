require 'rails_helper'

describe "Feeds", :type => :feature do

  subject { page }

  describe "as Admin user" do

    before do
      @admin = FactoryGirl.create(:admin)
      @company = FactoryGirl.create(:company)
      @feed = FactoryGirl.create(:feed)
      signin(@admin)
    end

    it "should be able to access Feeds (index) page" do
      visit feeds_path
      expect(current_path).to eq(feeds_path)
    end

    it "should be able to view show pages" do
      visit feed_path(@feed)
      expect(current_path).to eq(feed_path(@feed))
    end

    it "should be able to edit Feeds" do
      visit edit_feed_path(@feed)
      fill_in "Name", with: "Feed 123"
      click_button("Update Feed")
      expect(page).to have_text("Feed 123")
    end

    it "should raise an error when editing with a missing field" do
      visit edit_feed_path(@feed)
      fill_in "Name",                             with: ""
      click_button("Update Feed")
      expect(page).to have_selector("li", "Name can't be blank")
    end

    it "should be able to visit Add Feeds page" do
      visit new_feed_path
      expect(current_path).to eq(new_feed_path)
    end

    it "should be able to add new Feeds" do
      @feed2 = FactoryGirl.build(:feed)
      visit new_feed_path
      fill_in "Name",                                                 with: @feed2.name
      fill_in "Notes",                                                with: @feed2.notes
      fill_in "Stage Feed URL",                                       with: @feed2.stage_feed_url
      fill_in "Production Feed URL",                                  with: @feed2.production_feed_url
      fill_in "feed_production_start_date",                           with: @feed2.production_start_date
      fill_in "feed_production_end_date",                                  with: @feed2.production_end_date
      select(Company.find(@feed2.company_id).name,                    from: 'Company')
      choose(FeedStatus.find(@feed2.feed_status_id).name)
      select(FeedFrequency.find(@feed2.feed_frequency_id).name,       from: 'Feed Frequency')
      select(FeedType.find(@feed2.feed_type_id).name,                 from: 'Feed Type')
      fill_in "Transaction Type",                                     with: @feed2.transaction_type
      check("Sent to DataRail?")
      check("Enhanced Carrier Status?")
      fill_in "DataRail API Key",                                     with: @feed2.data_rail_api_key
      fill_in "DataRail Password",                                    with: @feed2.data_rail_password
      fill_in "DataRail Queue Priority",                              with: @feed2.data_rail_queue_priority
      fill_in "DataView Username",                                    with: @feed2.data_view_username
      fill_in "DataView Password",                                    with: @feed2.data_view_password
      fill_in "Partner (Partner Connections)",                        with: @feed2.partner
      check("Split by DataRail?")
      select(SystemType.find(@feed2.source_system_type_id).name,      from: "Source System Type")
      select(SystemType.find(@feed2.destination_system_type_id).name, from: "Destination System Type")

      click_button("Create Feed")
      expect(page).to have_text(@feed2.name)
    end

    it "should be able to choose Parent Feed" do
      @feed2 = FactoryGirl.create(:feed, company_id: "#{Company.all.sample.id}", name: "feed2")
      @feed3 = FactoryGirl.build(:feed, company_id: @feed2.company_id, name: "feed3")
      visit new_feed_path
      fill_in "Name",                                                 with: @feed3.name
      select(Company.find(@feed3.company_id).name,                    from: 'Company')
      choose(FeedStatus.find(@feed3.feed_status_id).name)
      select(FeedType.find(@feed3.feed_type_id).name,                 from: 'Feed Type')
      select(@feed2.name_with_company,                                from: "feed_parent_feed_id")
      click_button("Create Feed")
      expect(page).to have_text(@feed3.name)
    end

    it "should raise an error when adding with a missing Name" do
      visit new_feed_path
      click_button("Create Feed")
      expect(page).to have_selector('li', "Name can't be blank")
    end

    it "should be able to delete a Feed" do
      visit feeds_path
      within('tr', text: @feed.name) do
        click_link("Delete")
      end
      expect(page).to_not have_link(@feed.name)
    end

    it { is_expected.to have_link('Feeds', href: feeds_path) }

  end

  describe "as non-admin user" do
    before do
      @user = FactoryGirl.create(:user)
      @company = FactoryGirl.create(:company)
      @feed = FactoryGirl.create(:feed)
      signin(@user)
    end

    it "should be able to access Feeds (index) page" do
      visit feeds_path
      expect(current_path).to eq(feeds_path)
    end

    it "should be able to view show pages" do
      visit feed_path(@feed)
      expect(current_path).to eq(feed_path(@feed))
    end

    it "should not be able to edit Feeds" do
      visit edit_feed_path(@feed)
      expect(current_path).to eq(feeds_path)
    end

    it "should not be able to add Feeds" do
      visit new_feed_path
      expect(current_path).to eq(feeds_path)
    end

    it "should display show page when feed has minimal fields" do
      @minimal_feed = FactoryGirl.create(:minimal_feed)
      visit feed_path(@minimal_feed)
      expect(page).to have_text(@minimal_feed.name)
    end

    it "should be able to see every field for a feed" do
      @feed2 = FactoryGirl.create(:feed)
      visit feed_path(@feed)
      expect(page).to have_text(@feed.name)
      expect(page).to have_text(@feed.try(:notes))
      expect(page).to have_text(@feed.try(:stage_feed_url))
      expect(page).to have_text(@feed.try(:production_feed_url))
      expect(page).to have_text(@feed.try(:production_start_date).strftime("%m-%d-%Y"))
      expect(page).to have_text(@feed.try(:production_end_date).strftime("%m-%d-%Y"))
      expect(page).to have_text(@feed.try(:company).try(:name))
      expect(page).to have_text(@feed.try(:feed_status).try(:name))
      expect(page).to have_text(@feed.try(:feed_frequency).try(:name))
      expect(page).to have_text(@feed.try(:feed_type).try(:name))
      expect(page).to have_text(@feed.try(:transaction_type))
      expect(page).to have_text(@feed.try(:sent_to_data_rail))
      expect(page).to have_text(@feed.try(:enhanced_carrier_status))
      expect(page).to have_text(@feed.try(:data_rail_api_key))
      expect(page).to have_text(@feed.try(:data_rail_queue_priority))
      expect(page).to have_text(@feed.try(:data_view_username))
      expect(page).to have_text(@feed.try(:partner))
      expect(page).to have_text(@feed.try(:split_by_data_rail))
      expect(page).to have_text(@feed.try(:source_system_type).try(:name))
      expect(page).to have_text(@feed.try(:destination_system_type).try(:name))
      expect(page).to have_text(@feed.try(:source_transmission_type).try(:name))
      expect(page).to have_text(@feed.try(:destination_transmission_type).try(:name))
      expect(page).to have_text(@feed.try(:parent_feed).try(:name))
    end

    it "should obscure DR and DV password fields" do
      visit feed_path(@feed)
      expect(page).to have_text('DataRail Password:')
      expect(page).to_not have_text(@feed.try(:data_rail_password))
      expect(page).to have_text('DataView Password:')
      expect(page).to_not have_text(@feed.try(:data_view_password))
      expect(page).to have_text('********')
    end

    it "should take me back when I click the Back button from the Show page" do
      visit feeds_path
      click_link(@feed.name)
      click_link("Back")
      expect(current_path).to eq(feeds_path)
    end

    it { is_expected.to have_link('Feeds', href: feeds_path) }
  end

  describe "when not signed in" do
    before do
      @feed = FactoryGirl.create(:feed)
    end

    it "should not be able to access Feeds (index) page" do
      visit feeds_path
      expect(page).to have_selector('h3',    text: 'Log in')
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end

    it "should not be able to view show pages" do
      visit feed_path(@feed)
      expect(page).to have_selector('h3',    text: 'Log in')
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end

    it "should not be able to edit Feeds" do
      visit edit_feed_path(@feed)
      expect(page).to have_selector('h3',    text: 'Log in')
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end

    it { is_expected.not_to have_link('Feeds', href: feeds_path) }
  end
end
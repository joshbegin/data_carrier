require 'spec_helper'

describe "Feeds" do

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

    it "should be able to visit Add Feeds page" do
      visit new_feed_path
      expect(current_path).to eq(new_feed_path)
    end

    it "should be able to add new Feeds" do
      @feed2 = FactoryGirl.build(:feed)
      visit new_feed_path
      fill_in "Name",                             with: @feed2.name
      fill_in "Notes",                            with: @feed2.notes
      fill_in "Stage Feed URL",                   with: @feed2.stage_feed_url
      fill_in "Production Feed URL",              with: @feed2.production_feed_url
      fill_in "Production Start Date",            with: @feed2.production_start_date
      fill_in "Production End Date",              with: @feed2.production_end_date
      select(@company.name,                       from: 'Company')
      select(FeedStatus.first.name,               from: 'Feed Status')
      select(FeedFrequency.first.name,            from: 'Feed Frequency')
      select(FeedType.first.name,                 from: 'Feed Type')
      fill_in "Transaction Type",                 with: @feed2.transaction_type
      check("Sent to DataRail?")
      check("Enhanced Carrier Status?")
      fill_in "DataRail API Key",                 with: @feed2.data_rail_api_key
      fill_in "DataRail Password",                with: @feed2.data_rail_password
      fill_in "DataRail Queue Priority",          with: @feed2.data_rail_queue_priority
      fill_in "DataView Username",                with: @feed2.data_view_username
      fill_in "DataView Password",                with: @feed2.data_view_password
      fill_in "Partner (Partner Connections)",    with: @feed2.partner
      check("Split by DataRail?")
      click_button("Create Feed")
      expect(page).to have_text(@feed2.name)
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
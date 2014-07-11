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
      expect(current_path).to eq(edit_feed_path(@feed))
    end

    it "should be able to add Feeds" do
      visit new_feed_path
      expect(current_path).to eq(new_feed_path)
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
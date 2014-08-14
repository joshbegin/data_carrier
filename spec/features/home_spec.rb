require 'rails_helper'

describe "Home page", :type => :feature do

  subject { page }

  describe "when logged in" do
    before do
      @user = FactoryGirl.create(:user)
      @parent_company = FactoryGirl.create(:parent_company)
      @company = FactoryGirl.create(:company)
      @feed = FactoryGirl.create(:feed)
      @minimal_feed = FactoryGirl.create(:minimal_feed)
      signin(@user)
    end

    it "should be able to access Home page" do
      visit root_path
      expect(current_path).to eq(root_path)
      expect(page).to have_text("Dashboard")
    end

    it "should display recently updated Feeds" do
      visit root_path
      expect(page).to have_text(@feed.name)
    end

    it "should display recently updated Parent Companies" do
      visit root_path
      expect(page).to have_text(@parent_company.name)
    end

    it "should display recently updated Companies" do
      visit root_path
      expect(page).to have_text(@company.name)
    end

    it { is_expected.to have_link('Parent Companies', href: parent_companies_path) }
    it { is_expected.to have_link('Companies', href: companies_path) }
    it { is_expected.to have_link('Feeds', href: feeds_path) }
  end

  describe "when not signed in" do
    before do
      @feed = FactoryGirl.create(:feed)
    end

    it "should be able to access Home page" do
      visit root_path
      expect(current_path).to eq(root_path)
    end

    it "should not display carrier data" do
      visit root_path
      expect(page).to have_text("Please sign up or sign in to access Carrier Data")
    end

    it { is_expected.not_to have_link('Parent Companies', href: parent_companies_path) }
    it { is_expected.not_to have_link('Companies', href: companies_path) }
    it { is_expected.not_to have_link('Feeds', href: feeds_path) }
  end
end
require 'spec_helper'

describe "Companies" do

  subject { page }

  describe "as Admin user" do

    before do
      @admin = FactoryGirl.create(:admin)
      @company = FactoryGirl.create(:company)
      signin(@admin)
    end

    it "should be able to access Companies (index) page" do
      visit companies_path
      expect(current_path).to eq(companies_path)
    end

    it "should be able to view show pages" do
      visit company_path(@company)
      expect(current_path).to eq(company_path(@company))
    end

    it "should be able to edit Companies" do
      visit edit_company_path(@company)
      expect(current_path).to eq(edit_company_path(@company))
    end

    it "should be able to add Companies" do
      visit new_company_path
      expect(page).to have_selector('h3',     text: 'New Company')
    end

    it { is_expected.to have_link('Companies', href: companies_path) }

  end

  describe "as non-admin user" do
    before do
      @user = FactoryGirl.create(:user)
      @company = FactoryGirl.create(:company)
      signin(@user)
    end

    it "should be able to access Companies (index) page" do
      visit companies_path
      expect(current_path).to eq(companies_path)
    end

    it "should be able to view show pages" do
      visit company_path(@company)
      expect(current_path).to eq(company_path(@company))
    end

    it "should not be able to edit Companies" do
      visit edit_company_path(@company)
      expect(current_path).to eq(companies_path)
    end

    it "should not be able to add Companies" do
      visit new_company_path
      expect(current_path).to eq(companies_path)
    end

    it { is_expected.to have_link('Companies', href: companies_path) }
  end

  describe "when not signed in" do
    before do
      @company = FactoryGirl.create(:company)
    end

    it "should not be able to access Companies (index) page" do
      visit companies_path
      expect(page).to have_selector('h3',    text: 'Log in')
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end

    it "should not be able to view show pages" do
      visit company_path(@company)
      expect(page).to have_selector('h3',    text: 'Log in')
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end

    it "should not be able to edit Companies" do
      visit edit_company_path(@company)
      expect(page).to have_selector('h3',    text: 'Log in')
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end

    it { is_expected.not_to have_link('Companies', href: companies_path) }
  end
end
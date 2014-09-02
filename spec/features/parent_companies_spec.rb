require 'rails_helper'

describe "ParentCompanies", :type => :feature do

  subject { page }

  describe "as Admin user" do

    before do
      @admin = FactoryGirl.create(:admin)
      @parent_company = FactoryGirl.create(:parent_company)
      signin(@admin)
    end

    it "should be able to access Parent Companies (index) page" do
      visit parent_companies_path
      expect(page).to have_selector('h3',    text: 'Parent Companies')
    end

    it "should be able to view show pages" do
      visit parent_company_path(@parent_company)
      expect(page).to have_selector('h3',     text: "Parent Company Details - #{@parent_company.name}")
    end

    it "should be able to edit Parent Companies" do
      visit edit_parent_company_path(@parent_company)
      fill_in "parent_company_name",                             with: "Company DEF"
      click_button("Update Parent company")
      expect(page).to have_link("Company DEF")
    end

    it "should raise an error when editing with a missing Name" do
      visit edit_parent_company_path(@parent_company)
      fill_in "parent_company_name",                             with: ""
      click_button("Update Parent company")
      expect(page).to have_selector("li", "Name can't be blank")
    end

    it "should be able to visit add Parent Companies page" do
      visit new_parent_company_path
      expect(page).to have_selector('h3',     text: 'New Parent Company')
    end

    it "should be able to add new Parent Company" do
      visit new_parent_company_path
      fill_in "parent_company_name",                             with: "Company ABC"
      fill_in "parent_company_additional_name",                  with: "Addl Name"
      click_button("Create Parent company")
      expect(page).to have_link("Company ABC")
    end

    it "should raise an error when adding with a missing Name" do
      visit new_parent_company_path
      click_button("Create Parent company")
      expect(page).to have_selector('li', "Name can't be blank")
    end

    it "should display show page when parent company has minimal fields" do
      @minimal_parent_company = FactoryGirl.create(:minimal_parent_company)
      visit parent_company_path(@minimal_parent_company)
      expect(page).to have_text(@minimal_parent_company.name)
    end

    it { is_expected.to have_link('Parent Companies', href: parent_companies_path) }

    it "should display the correct child carriers" do
      @company = FactoryGirl.create(:company, parent_company_id: @parent_company.id)
      visit parent_company_path(@parent_company)
      expect(page).to have_link(@company.name)
    end

  end

  describe "as non-admin user" do
    before do
      @user = FactoryGirl.create(:user)
      @parent_company = FactoryGirl.create(:parent_company)
      signin(@user)
    end

    it "should be able to access Parent Companies (index) page" do
      visit parent_companies_path
      expect(page).to have_selector('h3',    text: 'Parent Companies')
    end

    it "should be able to view show pages" do
      visit parent_company_path(@parent_company)
      expect(page).to have_selector('h3',     text: "#{@parent_company.name}")
    end

    it "should not be able to edit Parent Companies" do
      visit edit_parent_company_path(@parent_company)
      expect(page).to have_selector('h3',     text: 'Parent Companies')
    end

    it "should not be able to add Parent Companies" do
      visit new_parent_company_path
      expect(page).to have_selector('h3',     text: 'Parent Companies')
    end

    it "should take me back when I click the Back button from the Show page" do
      visit parent_companies_path
      click_link(@parent_company.name)
      click_link("Back")
      expect(current_path).to eq(parent_companies_path)
    end

    it { is_expected.to have_link('Parent Companies', href: parent_companies_path) }
  end

  describe "when not signed in" do
    before do
      @parent_company = FactoryGirl.create(:parent_company)
    end

    it "should not be able to access Parent Companies (index) page" do
      visit parent_companies_path
      expect(page).to have_selector('h3',    text: 'Log in')
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end

    it "should not be able to view show pages" do
      visit parent_company_path(@parent_company)
      expect(page).to have_selector('h3',    text: 'Log in')
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end

    it "should not be able to edit Parent Companies" do
      visit edit_parent_company_path(@parent_company)
      expect(page).to have_selector('h3',    text: 'Log in')
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end

    it { is_expected.not_to have_link('Parent Companies', href: parent_companies_path) }
  end
end
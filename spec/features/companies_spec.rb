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
      fill_in "Name",                             with: "Company DEF"
      click_button("Update Company")
      expect(page).to have_link("Company DEF")
    end

    it "should raise an error when editing with a missing field" do
      visit edit_company_path(@company)
      fill_in "Name",                             with: ""
      click_button("Update Company")
      expect(page).to have_selector("li", "Name can't be blank")
    end

    it "should be able to visit add Companies page" do
      visit new_company_path
      expect(page).to have_selector('h3',     text: 'New Company')
    end

    it "should be able to add new Company" do
      @parent_company = FactoryGirl.create(:parent_company)
      visit new_company_path
      fill_in "Name",                             with: "Company ABC"
      fill_in "Additional Name",                  with: "Addl name"
      select(@parent_company.name,                from: 'Parent company')
      select(CompanyType.first.name,              from: 'Company type')
      select(State.first.name,                    from: 'State')
      fill_in "Address Line 1",                   with: "Address Line 1"
      fill_in "Address Line 2",                   with: "Address Line 2"
      fill_in "Address Line 3",                   with: "Address Line 3"
      fill_in "City",                             with: "City"
      fill_in "Zip",                              with: "Zip"
      fill_in "URL",                              with: "http://www.google.com"
      fill_in "NAIC Code",                        with: "61492"
      fill_in "AI Carrier Code",                  with: "64"
      click_button("Create Company")
      expect(page).to have_link("Company ABC")
    end

    it "should raise an error when adding with a missing Name" do
      visit new_company_path
      click_button("Create Company")
      expect(page).to have_selector('li', "Name can't be blank")
    end

    it "should be able to delete a Company" do
      visit companies_path
      within('tr', text: @company.name) do
        click_link("Delete")
      end
      expect(page).to_not have_link(@company.name)
    end

    it "should not be able to delete a company if it has child feeds" do
      @company2 = FactoryGirl.create(:company)
      @feed = FactoryGirl.create(:feed)
      visit companies_path
      within('tr', text: @company.name) do
        expect(page).to_not have_link("Delete")
      end
    end

    it "should display the correct feeds" do
      @feed = FactoryGirl.create(:feed)
      visit company_path(@company)
      expect(page).to have_link(@feed.name)
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

    it "should display show page when company has minimal fields" do
      @minimal_company = FactoryGirl.create(:minimal_company)
      visit company_path(@minimal_company)
      expect(page).to have_text(@minimal_company.name)
    end

    it "should take me back when I click the Back button from the Show page" do
      visit companies_path
      click_link(@company.name)
      click_link("Back")
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
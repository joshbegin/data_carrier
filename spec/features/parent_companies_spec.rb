require 'spec_helper'

describe "ParentCompanies" do
  # let(:parent_company) { FactoryGirl.create(:parent_company) }
  # let(:company) { FactoryGirl.create(:company) }
  # let(:company2) { FactoryGirl.create(:company) }

  subject { page }

  describe "as Admin user" do

    before do
      @admin = FactoryGirl.create(:admin)
      @parent_company = FactoryGirl.create(:parent_company)
      signin(@admin)
      # company.parent_company_id = parent_company.id
      # company.save
    end

    it "should be able to access Parent Companies (index) page" do
      visit parent_companies_path

      page.should have_selector('h3',    text: 'Parent Companies')
    end

    it "should be able to view show pages" do
      visit parent_company_path(@parent_company)

      page.should have_selector('h3',     text: "#{@parent_company.name} Details")
    end

    it "should be able to edit Parent Companies" do
      visit edit_parent_company_path(@parent_company)

      page.should have_selector('h3',     text: "Edit #{@parent_company.name}")
    end

    it "should be able to add Parent Companies" do
      visit new_parent_company_path

      page.should have_selector('h3',     text: 'New Parent Company')
    end

    it { should have_link('Parent Companies', href: parent_companies_path) }

    # it "should display the correct child carriers" do
    #   visit parent_company_path(parent_company)
    #   page.should have_content("#{company.naic_code}")
    #   page.should_not have_content("#{company2.naic_code}")
    # end

  end

  describe "as non-admin user" do
    before do
      @user = FactoryGirl.create(:user)
      @parent_company = FactoryGirl.create(:parent_company)
      signin(@user)
    end

    it "should be able to access Parent Companies (index) page" do
      visit parent_companies_path
      page.should have_selector('h3',    text: 'Parent Companies')
    end

    it "should be able to view show pages" do
      visit parent_company_path(@parent_company)
      page.should have_selector('h3',     text: "#{@parent_company.name}")
    end

    it "should not be able to edit Parent Companies" do
      visit edit_parent_company_path(@parent_company)
      page.should have_selector('h3',     text: 'Parent Companies')
    end

    it "should not be able to add Parent Companies" do
      visit new_parent_company_path
      page.should have_selector('h3',     text: 'Parent Companies')
    end

    it { should have_link('Parent Companies', href: parent_companies_path) }
  end

  describe "when not signed in" do
    before do
      @parent_company = FactoryGirl.create(:parent_company)
    end

    it "should not be able to access Parent Companies (index) page" do
      visit parent_companies_path
      page.should have_selector('h3',    text: 'Log in')
      page.should have_content('You need to sign in or sign up before continuing.')
    end

    it "should not be able to view show pages" do
      visit parent_company_path(@parent_company)
      page.should have_selector('h3',    text: 'Log in')
      page.should have_content('You need to sign in or sign up before continuing.')
    end

    it "should not be able to edit Parent Companies" do
      visit edit_parent_company_path(@parent_company)
      page.should have_selector('h3',    text: 'Log in')
      page.should have_content('You need to sign in or sign up before continuing.')
    end

    it { should_not have_link('Parent Companies', href: parent_companies_path) }
  end
end
require 'rails_helper'

describe "Contacts", :type => :feature do

  subject { page }

  describe "as Admin user" do

    before do
      @admin = FactoryGirl.create(:admin)
      @contact = FactoryGirl.create(:contact)
      signin(@admin)
    end

    it "should be able to access Contacts (index) page" do
      visit contacts_path
      expect(page).to have_selector('h3',    text: 'Contacts')
    end

    it "should be able to view show pages" do
      visit contact_path(@contact)
      expect(page).to have_selector('h3',     text: "#{@contact.full_name} Details")
    end

    it "should be able to edit Contact" do
      visit edit_contact_path(@contact)
      fill_in "First Name",                             with: "Michael"
      fill_in "Last Name",                              with: "Bluth"
      click_button("Update Contact")
      expect(page).to have_text("Michael Bluth Details")
    end

    it "should raise an error when editing with a missing Name" do
      visit edit_contact_path(@contact)
      fill_in "Last Name",                             with: ""
      click_button("Update Contact")
      expect(page).to have_selector("li", "Last Name can't be blank")
    end

    it "should be able to visit add Contact page" do
      visit new_contact_path
      expect(page).to have_selector('h3',     text: 'New Contact')
    end

    it "should be able to add new Contacts" do
      @contact2 = FactoryGirl.build(:contact)
      visit new_contact_path
      fill_in "First Name",                                           with: @contact2.first_name
      fill_in "Last Name",                                            with: @contact2.last_name
      fill_in "Phone",                                                with: @contact2.phone
      fill_in "Address Line 1",                                       with: @contact2.address_line_1
      fill_in "Address Line 2",                                       with: @contact2.address_line_2
      fill_in "Address Line 3",                                       with: @contact2.address_line_3
      fill_in "City",                                                 with: @contact2.city
      fill_in "Zip",                                                  with: @contact2.zip
      select(State.find(@contact2.state_id).name,                     from: 'State')
      select(Gender.find(@contact2.gender_id).name,                   from: 'Gender')
      fill_in "Title",                                                with: @contact2.title
      fill_in "Notes",                                                with: @contact2.notes

      click_button("Create Contact")
      expect(page).to have_text(@contact2.first_name)
    end

    it "should raise an error when adding with a missing Name" do
      visit new_contact_path
      click_button("Create Contact")
      expect(page).to have_selector('li', "First Name can't be blank")
    end

    it "should display show page when contact has minimal fields" do
      @minimal_contact = FactoryGirl.create(:minimal_contact)
      visit contact_path(@minimal_contact)
      expect(page).to have_text(@minimal_contact.first_name)
    end

    it { is_expected.to have_link('Contacts', href: contacts_path) }


  end

  describe "as non-admin user" do
    before do
      @user = FactoryGirl.create(:user)
      @contact = FactoryGirl.create(:contact)
      signin(@user)
    end

    it "should be able to access Contacts (index) page" do
      visit contacts_path
      expect(page).to have_selector('h3',    text: 'Contacts')
    end

    it "should be able to view show pages" do
      visit contact_path(@contact)
      expect(page).to have_selector('h3',     text: "#{@contact.full_name}")
    end

    it "should not be able to edit Contacts" do
      visit edit_contact_path(@contact)
      expect(page).to have_selector('h3',     text: 'Contacts')
    end

    it "should not be able to add Parent Companies" do
      visit new_contact_path
      expect(page).to have_selector('h3',     text: 'Contacts')
    end

    it "should take me back when I click the Back button from the Show page" do
      visit contacts_path
      click_link(@contact.first_name)
      click_link("Back")
      expect(current_path).to eq(contacts_path)
    end

    it { is_expected.to have_link('Contacts', href: contacts_path) }
  end

  describe "when not signed in" do
    before do
      @contact = FactoryGirl.create(:contact)
    end

    it "should not be able to access Contacts (index) page" do
      visit contacts_path
      expect(page).to have_selector('h3',    text: 'Log in')
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end

    it "should not be able to view show pages" do
      visit contact_path(@contact)
      expect(page).to have_selector('h3',    text: 'Log in')
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end

    it "should not be able to edit Contacts" do
      visit edit_contact_path(@contact)
      expect(page).to have_selector('h3',    text: 'Log in')
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end

    it { is_expected.not_to have_link('Contacts', href: contacts_path) }
  end
end
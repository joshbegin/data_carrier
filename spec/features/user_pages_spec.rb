require 'spec_helper'

describe "When not logged in", :type => :feature do
  it "should allow me to create an account" do
    visit new_user_registration_path
    fill_in "Name",                     with: "Test User"
    fill_in "Email",                    with: "test@test.com"
    fill_in "Password",                 with: "Password"
    fill_in "Password confirmation",    with: "Password"
    click_button "Sign up"
    expect(page).to have_text("Welcome! You have signed up successfully.")
  end
end

describe "All Users", :type => :feature do
  before :each do
    @user = FactoryGirl.create(:user)
    @parent = FactoryGirl.create(:parent_company)
  end

  it "should be able to sign in" do
    signin(@user)
    expect(page).to have_content 'successfully'
  end

  it "should see 'Signed in as {user's name}' in navigation bar" do
    signin(@user)
    expect(page).to have_selector('em', text: "Signed in as #{@user.name}")
  end

  it "should only see 'Signed in' in navigation bar if user does not have name" do
    @user.name = nil
    @user.save
    signin(@user)
    expect(page).to_not have_selector('em', text: "Signed in as")
  end

  it "should be able to access own /show page" do
    signin(@user)
    visit user_path(@user)
    expect(current_path).to eq(user_path(@user))
  end

  it "should be able to edit own profile" do
    signin(@user)
    visit edit_user_registration_path(@user)
    fill_in "Name", with: "New Name"
    fill_in "Current password", with: "Password"
    click_button("Update")
    expect(page).to have_text("New Name")
  end

  it "should be able to delete themselves" do
    signin(@user)
    visit edit_user_registration_path(@user)
    click_link("Cancel my account")
    expect(page).to have_text("Bye! Your account was successfully cancelled. We hope to see you again soon.")
  end
end

describe "Non-admin Users", :type => :feature do
  before :each do
    @user = FactoryGirl.create(:user)
  end

  describe "after sign in" do
    before :each do
      signin(@user)
    end

    it "should not see Users link in navigation" do
      expect(page).to_not have_link('Users', href: users_path)
    end

    it "should not be able to access other /show pages" do
      @user2 = FactoryGirl.create(:user)
      visit user_path(@user2)
      expect(current_path).to_not eq(user_path(@user2))
    end

    it "should not be able to access /users page" do
      visit users_path
      expect(page).to have_selector('div.alert.alert-danger', text: 'Access denied.')
    end
  end
end

describe "Admin Users", :type => :feature do
  before :each do
    @admin = FactoryGirl.create(:admin)
    signin(@admin)
    @user = FactoryGirl.create(:user)
    visit users_path
  end

  it "should see Users link in navigation" do
    expect(page).to have_link('Users')
  end

  it "should be able to access /users page" do
    expect(page).to have_selector('h3', text: 'Users')
  end

  it "should be able to access other /show pages" do
    @user2 = FactoryGirl.create(:user)
    visit user_path(@user2)
    expect(current_path).to eq(user_path(@user2))
  end

  it "should be able to change user roles" do
    expect(page).to have_button('Change Role')
  end

  it "should be able to delete users" do
    within('tr', text: @user.email) do
      click_link("Delete user")
    end
    expect(page).to_not have_link(@user.email)
  end

  it "should not be able to change their own role" do
    within('tr', text: @admin.email) do
      expect(page).to_not have_link("Change Role")
    end
  end

  it "should not be able to delete themselves from the index page" do
    within('tr', text: @admin.email) do
      expect(page).to_not have_link("Delete user")
    end
  end
end
require 'spec_helper'

describe "When not logged in"

describe "All Users" do
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
end

describe "Non-admin Users" do
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

    it "should not be able to access /users page" do
      visit users_path
      expect(page).to have_selector('div.alert.alert-danger', text: 'Access denied.')
    end
  end
end

describe "Admin Users" do
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

  it "should be able to change user roles" do
    expect(page).to have_button('Change Role')
  end

  it "should be able to delete users"

  it "should not be able to change their own role"

  it "should not be able to delete themselves from the index page"
end
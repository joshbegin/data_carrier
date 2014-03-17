require 'spec_helper'

describe "Authentication" do

  describe "the signin process" do
    before :each do
      @user = FactoryGirl.create(:user)
    end

    it "signs me in" do
      visit 'users/sign_in'
      fill_in 'Email', :with => @user.email
      fill_in 'Password', :with => @user.password
      click_button 'Log in'
      expect(page).to have_content 'successfully'
    end

    describe "with no credentials" do
      it "generates an invalid email or password error" do
        visit 'users/sign_in'
        click_button 'Log in'
        expect(page).to have_selector('div.alert.alert-danger', text: 'Invalid email')
      end
    end
  end

  describe "the Login button" do
    before :each do
      visit root_path
      click_button 'Login'
    end

    it "takes me to the signin page" do
      expect(page).to have_content 'Log in'
    end

    it "does not generate an invalid email or password error" do
      expect(page).to_not have_selector('div.alert.alert-danger', text: 'Invalid email')
    end
  end
end
require 'spec_helper'

describe UsersController do
  describe "All Users" do
    login_user

    it "should have a current_user" do
      expect(subject.current_user).to_not be_nil
    end
  end

  describe "Non-Admin Users" do
    login_user
    before :each do
      @user1 = FactoryGirl.create(:user)
    end

    it "should not get index" do
      get 'index'
      expect(response).to_not be_success
    end

    it "should not be able to delete users other than themselves" do
      @user2 = FactoryGirl.create(:user)
      expect{ delete :destroy, id: @user2 }.to change(User,:count).by(0)
    end

  end

  describe "Admin Users" do
    login_admin

    it "should get index" do
      get 'index'
      expect(response).to be_success
    end

    describe "DELETE #destroy" do
      before :each do
        @user1 = FactoryGirl.create(:user)
      end

      it "deletes the user" do
        expect{ delete :destroy, id: @user1 }.to change(User,:count).by(-1)
      end

      it "redirects to users#index" do
        delete :destroy, id: @user1
        expect(response).to redirect_to users_url
      end
    end

    it "should not be able to delete themselves" do
      @admin = User.first
      expect{ delete :destroy, id: @admin }.to change(User,:count).by(0)
    end
  end
end
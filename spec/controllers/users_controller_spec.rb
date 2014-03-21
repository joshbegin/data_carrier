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

    it "should not get index" do
      get 'index'
      expect(response).to_not be_success
    end

    it "should not be able to change roles"

    it "should not be able to delete users other than themselves"

    it "should be able to delete themselves"

  end

  describe "Admin Users" do
    login_admin

    it "should get index" do
      get 'index'
      expect(response).to be_success
    end

    it "should not be able to change their own role"

    it "should not be able to delete themselves"
  end
end
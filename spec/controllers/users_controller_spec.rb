require 'spec_helper'

describe UsersController do
  describe "All Users" do
    login_user

    it "should have a current_user" do
      expect(subject.current_user).to_not be_nil
    end

    describe "Non-Admin Users" do

      it "should not get index" do
        get 'index'
        expect(response).to_not be_success
      end
    end

    describe "Admin Users" do
      login_admin

      it "should get index" do
        get 'index'
        expect(response).to be_success
      end
    end
  end
end
require 'spec_helper'

describe User do

  before(:each) do
    @attr = {
      :name => "Example User",
      :email => "user@example.com",
      :password => "changeme",
      :password_confirmation => "changeme"
    }
  end

  it "should create a new instance given a valid attribute" do
    User.create!(@attr)
  end

  it { is_expected.to validate_presence_of(:email) }

  it { is_expected.to allow_value('user@foo.com', 'THE_USER@foo.bar.org', 'first.last@foo.jp').for(:email) }

  it { is_expected.not_to allow_value('asdfjkl').for(:email) }
  it { is_expected.not_to allow_value('user@foo,com').for(:email) }
  it { is_expected.not_to allow_value('user_at_foo.org').for(:email) }
  it { is_expected.not_to allow_value('example.user@foo.').for(:email) }

  it do
    User.create!(@attr)
    is_expected.to validate_uniqueness_of(:email)
  end

  it "should reject email addresses identical up to case" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    is_expected.to validate_uniqueness_of(:email)
  end

  describe "passwords" do

    before(:each) do
      @user = User.new(@attr)
    end

    it { is_expected.to validate_presence_of(:password) }
  end

  describe "password validations" do

    it { is_expected.to ensure_length_of(:password).is_at_least(8) }
    it { is_expected.to validate_confirmation_of(:password) }
  end

  describe "password encryption" do

    before(:each) do
      @user = User.create!(@attr)
    end

    it "should have an encrypted password attribute" do
      expect(@user).to respond_to(:encrypted_password)
    end

    it "should set the encrypted password attribute" do
      expect(@user.encrypted_password).not_to be_blank
    end

  end

end
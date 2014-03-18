include ApplicationHelper

def sign_up_admin
  visit signup_path
  fill_in "Name",                             with: "Admin User"
  fill_in "Email",                            with: "admin@email.com"
  fill_in "Password",                         with: "Password"
  fill_in "Confirm Password",                 with: "Password"
  click_button("Sign up")
  @user = User.find_by_email("admin@email.com")
  @user.toggle!(:admin)
end

def sign_up_user
  visit signup_path
  fill_in "Name",                             with: "User User"
  fill_in "Email",                            with: "user@email.com"
  fill_in "Password",                         with: "Password"
  fill_in "Confirm Password",                 with: "Password"
  click_button("Sign up")
  @user = User.find_by_email("user@email.com")
end

def signin(user)
  visit 'users/sign_in?'
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Log in"
end
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/reporters'
Minitest::Reporters.use!

require 'capybara/rails'
require 'capybara/email'
Capybara.default_max_wait_time = 5

# Add more helper methods to be used by all tests here...
include Warden::Test::Helpers

#
class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical
  # order.
  fixtures :all
end

class ActionController::TestCase
  include Devise::TestHelpers
end

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL
  include Capybara::Email::DSL
  Capybara.default_max_wait_time = 10
end

def create_user (str_l_name, str_f_name, str_email, str_pwd)
  # Sign up
  clear_emails # Clear the message queue
  visit new_user_registration_path
  fill_in('Last name', with: str_l_name)
  fill_in('First name', with: str_f_name)
  fill_in('Email', with: str_email)
  fill_in('Password', with: str_pwd)
  fill_in('Password confirmation', with: str_pwd)
  click_button('Sign up')
  assert_text 'confirmation link has been sent to your email address'
  u1 = User.find_by(email: str_email)
  assert_equal u1.last_name.to_s, str_l_name
  assert_equal u1.first_name.to_s, str_f_name
  assert_nil u1.confirmed_at
  assert_not_nil u1.confirmation_token
  assert_not_nil u1.confirmation_sent_at

  # Confirm account
  open_email(str_email)
  current_email.click_link 'Confirm my account'
  assert_text 'Your email address has been successfully confirmed.'
  clear_emails # Clear the message queue
end

# Prerequisite: create_user
def login_user (str_email, str_pwd, status_remember)
  begin
    logout(:user)
  rescue
    print
  end
  visit new_user_session_path
  fill_in('Email', with: str_email)
  fill_in('Password', with: str_pwd)
  if status_remember == true
    check('Remember me')
  else
    uncheck('Remember me')
  end
  click_button('Log in')
  assert_text 'Signed in successfully.'
  assert_equal(current_path, root_path)
  page.has_no_button?('Sign in')
  page.has_no_link? new_user_session_path
  page.has_link? destroy_user_session_path
  u1 = User.find_by(email: str_email)
  click_on 'Profile'
  assert_text u1.last_name
  assert_text u1.first_name
end

# Prerequisite: login_user
def logout_user
  click_on('Logout')
  page.has_button?('Sign in')
  page.has_link? new_user_session_path
  page.has_no_link? destroy_user_session_path
end

def create_admin (str_l_name, str_f_name, str_email, str_pwd, is_super)
  if is_super == true
    Admin.create!(last_name: str_l_name, first_name: str_f_name,
      email: str_email, password: str_pwd, password_confirmation: str_pwd,
      super: true, confirmed_at: Time.now)
  else
    Admin.create!(last_name: str_l_name, first_name: str_f_name,
      email: str_email, password: str_pwd, password_confirmation: str_pwd,
      super: false, confirmed_at: Time.now)
  end
end

# Prerequisite: create_admin
def login_admin (str_email, str_pwd, status_remember)
  begin
    logout(:admin)
    sleep (0.5)
  rescue
    print
  end
  visit new_admin_session_path
  assert_text 'Email'
  assert_text 'Password'
  fill_in('Email', with: str_email)
  fill_in('Password', with: str_pwd)
  if status_remember == true
    check('Remember me')
  else
    uncheck('Remember me')
  end
  click_button('Log in')
  assert_text 'Signed in successfully.'
  assert_equal(current_path, root_path)
  page.has_no_button?('Sign in')
  page.has_no_link? new_admin_session_path
  page.has_link? destroy_admin_session_path
  page.has_link? admins_path
  page.has_link? users_path
  a1 = Admin.find_by(email: str_email)
  click_on 'Profile'
  assert_text a1.last_name
  assert_text a1.first_name
end

# Prerequisite: login_admin
def logout_admin
  click_on('Logout')
  page.has_button?('Sign in')
  page.has_link? new_user_session_path
  page.has_no_link? destroy_user_session_path
end

# Uses test admins and users from test/fixtures/*.yml
def setup_admins_users
  begin
    click_on('Logout')
  rescue
    print
  end

  Warden.test_reset!

  @a1 = admins(:elle_woods)
  @a2 = admins(:vivian_kensington)
  @a3 = admins(:emmett_richmond)

  @u1 = users(:connery)
  @u2 = users(:moore)
  @u3 = users(:brosnan)
end

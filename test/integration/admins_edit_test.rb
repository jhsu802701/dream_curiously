require 'test_helper'

# Based on https://github.com/dockyard/capybara-email
class AdminsEditTest < ActionDispatch::IntegrationTest
  test 'signup, confirm, edit, and delete' do
    Admin.create!(last_name: 'Crockett', first_name: 'James',
      email: 'jcrockett@example.com', password: 'Miami Vice',
      password_confirmation: 'Miami Vice', confirmed_at: Time.now)

    # From test/test_helper.rb
    login_admin('jcrockett@example.com', 'Miami Vice', false)

    # Change name
    click_on 'Edit Settings'
    fill_in('admin_last_name', with: 'Knight')
    fill_in('admin_first_name', with: 'Michael')
    fill_in('admin_current_password', with: 'Miami Vice')
    click_on 'Update'
    assert_text 'Your account has been updated successfully.'

    # Change email address
    click_on 'Edit Settings'
    fill_in('admin_email', with: 'mknight@example.com')
    fill_in('admin_current_password', with: 'Miami Vice')
    click_on 'Update'
    assert_text 'Please check your email and follow the confirm link'

    # From test/test_helper.rb
    logout_admin

    # Will find an email sent to `mknight@example.com`
    # and set `current_email`
    open_email('mknight@example.com')
    current_email.click_link 'Confirm my account'
    assert_text 'Your email address has been successfully confirmed.'
    clear_emails # Clear the message queue

    # From test/test_helper.rb
    login_admin('mknight@example.com', 'Miami Vice', false)

    # Change password
    click_on 'Edit Settings'
    fill_in('admin_password', with: 'Knight Rider')
    fill_in('admin_password_confirmation', with: 'Knight Rider')
    fill_in('admin_current_password', with: 'Miami Vice')
    click_on 'Update'
    assert_text 'Your account has been updated successfully.'

    # From test/test_helper.rb
    logout_admin

    # From test/test_helper.rb
    login_admin('mknight@example.com', 'Knight Rider', false)

    # From test/test_helper.rb
    logout_admin

    # From test/test_helper.rb
    login_admin('mknight@example.com', 'Knight Rider', false)

    # Delete admin
    click_on 'Edit Settings'
    click_button 'Cancel my account'
    assert_text 'Bye! Your account has been successfully cancelled.'

    # Try to log back in
    visit new_admin_session_path
    fill_in('Email', with: 'mknight@example.com')
    fill_in('Password', with: 'Knight Rider')
    uncheck('Remember me')
    click_button('Log in')
    assert_equal(current_path, new_admin_session_path)
    page.has_button?('Sign in')
    page.has_link? new_admin_session_path
    page.has_no_link? destroy_admin_session_path
    assert_text 'Invalid email or password.'
  end
end

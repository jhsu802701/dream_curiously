require 'test_helper'

# Based on https://github.com/dockyard/capybara-email
class UsersEditTest < ActionDispatch::IntegrationTest
  test 'signup, confirm, edit, and delete' do
    # From test/test_helper.rb
    create_user('Curie', 'Marie', 'marie_curie@example.com',
                'polonium')

    # From test/test_helper.rb
    login_user('marie_curie@example.com', 'polonium', false)

    # Change name
    click_on 'Edit Settings'
    fill_in('user_last_name', with: 'Angelou')
    fill_in('user_first_name', with: 'Maya')
    fill_in('user_current_password', with: 'polonium')
    click_on 'Update'
    assert_text 'Your account has been updated successfully.'

    # Change email address
    click_on 'Edit Settings'
    fill_in('user_email', with: 'maya_angelou@example.com')
    fill_in('user_current_password', with: 'polonium')
    click_on 'Update'
    assert_text 'Please check your email and follow the confirm link'

    # From test/test_helper.rb
    logout_user

    # Confirm email
    open_email('maya_angelou@example.com')
    current_email.click_link 'Confirm my account'
    assert_text 'Your email address has been successfully confirmed.'
    clear_emails # Clear the message queue

    # From test/test_helper.rb
    login_user('maya_angelou@example.com', 'polonium', false)

    # Change password
    click_on 'Edit Settings'
    fill_in('user_password', with: 'Caged Bird')
    fill_in('user_password_confirmation', with: 'Caged Bird')
    fill_in('user_current_password', with: 'polonium')
    click_on 'Update'
    assert_text 'Your account has been updated successfully.'

    # From test/test_helper.rb
    logout_user

    # From test/test_helper.rb
    login_user('maya_angelou@example.com', 'Caged Bird', false)

    # From test/test_helper.rb
    logout_user

    # From test/test_helper.rb
    login_user('maya_angelou@example.com', 'Caged Bird', false)

    # Delete user
    click_on 'Edit Settings'
    click_button 'Cancel my account'
    assert_text 'Bye! Your account has been successfully cancelled.'

    # Try to log back in
    visit new_user_session_path
    fill_in('Email', with: 'maya_angelou@example.com')
    fill_in('Password', with: 'Caged Bird')
    uncheck('Remember me')
    click_button('Log in')
    assert_equal(current_path, new_user_session_path)
    page.has_button?('Sign in')
    page.has_link? new_user_session_path
    page.has_no_link? destroy_user_session_path
    assert_text 'Invalid email or password.'
  end
end

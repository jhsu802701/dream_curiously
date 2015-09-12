require 'test_helper'

#
class UserPasswordResetTest < ActionDispatch::IntegrationTest
  test 'reset password' do
    # From test/test_helper.rb
    create_user('Bourne', 'Jason', 'jason_bourne@example.com',
                'Mission Impossible')

    # From test/test_helper.rb
    login_user('jason_bourne@example.com', 'Mission Impossible', false)

    # From test/test_helper.rb
    logout_user

    # Forget password and request a password reset
    visit new_user_session_path
    click_on 'Forgot your password?'
    fill_in('Email', with: 'jason_bourne@example.com')
    click_button('Send me reset password instructions')
    assert_text('an email with instructions on how to reset your password')

    # Will find an email sent to `jason_bourne@example.com`
    # and set `current_email`
    open_email('jason_bourne@example.com')
    current_email.click_link 'Change my password'
    assert_text 'Change your password'
    assert_text 'New password'
    assert_text 'Confirm new password'
    assert_text 'KeePassX'
    clear_emails # Clear the message queue
    fill_in('New password', with: 'Matt Damon')
    fill_in('Confirm new password', with: 'Matt Damon')
    click_button('Change my password')
    assert_text 'Your password has been changed successfully.'
    assert_text 'You are now signed in.'

    logout_user
    login_user('jason_bourne@example.com', 'Matt Damon', false)
    logout_user
  end
end

require 'test_helper'

#
class AdminPasswordResetTest < ActionDispatch::IntegrationTest
  test 'reset password' do
    # Create admin
    Admin.create!(last_name: 'Quaid', first_name: 'Douglas',
      email: 'dquaid@example.com', password: 'Total Recall',
      password_confirmation: 'Total Recall', confirmed_at: Time.now)

    # From test/test_helper.rb
    login_admin('dquaid@example.com', 'Total Recall', false)

    # From test/test_helper.rb
    logout_admin

    # Forget password and request a password reset
    visit new_admin_session_path
    click_on 'Forgot your password?'
    fill_in('Email', with: 'dquaid@example.com')
    click_button('Send me reset password instructions')
    assert_text('an email with instructions on how to reset your password')

    # Will find an email sent to `jason_bourne@example.com`
    # and set `current_email`
    open_email('dquaid@example.com')
    current_email.click_link 'Change my password'
    assert_text 'Change your password'
    assert_text 'New password'
    assert_text 'Confirm new password'
    assert_text 'KeePassX'
    clear_emails # Clear the message queue
    fill_in('New password', with: 'Consider that a divorce.')
    fill_in('Confirm new password', with: 'Consider that a divorce.')
    click_button('Change my password')
    assert_text 'Your password has been changed successfully.'
    assert_text 'You are now signed in.'

    # From test/test_helper.rb
    logout_admin

    # From test/test_helper.rb
    login_admin('dquaid@example.com', 'Consider that a divorce.', false)

    # From test/test_helper.rb
    logout_admin
  end
end

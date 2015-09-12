require 'test_helper'

#
class AdminsLoginTest < ActionDispatch::IntegrationTest
  #
  def setup
    setup_admins_users # From test/test_helper.rb
  end

  test 'login with invalid information, no remembering' do
    visit new_admin_session_path
    assert_text 'Email'
    assert_text 'Password'
    fill_in('Email', with: 'elle_woods@example.com')
    fill_in('Password', with: 'quitting Harvard Law')
    uncheck('Remember me')
    click_button('Log in')
    assert_equal(current_path, new_admin_session_path)
    page.has_button?('Sign in')
    page.has_link? new_admin_session_path
    page.has_no_link? admin_path(@a1)
    page.has_no_link? destroy_admin_session_path
    assert_text 'Invalid email or password.'
  end

  test 'login with invalid information, with remembering' do
    visit new_admin_session_path
    assert_text 'Email'
    assert_text 'Password'
    fill_in('Email', with: 'elle_woods@example.com')
    fill_in('Password', with: 'quitting Harvard Law')
    check('Remember me')
    click_button('Log in')
    assert_equal(current_path, new_admin_session_path)
    page.has_button?('Sign in')
    page.has_link? new_admin_session_path
    page.has_no_link? admin_path(@a1)
    page.has_no_link? destroy_admin_session_path
    assert_text 'Invalid email or password.'
  end

  test 'login and logout with valid information, no remembering' do
    # From test/test_helper.rb
    login_admin('elle_woods@example.com', 'Harvard Law', false)

    # From test/test_helper.rb
    logout_admin
  end

  # NOTE: only makes sure that the login process is successful
  test 'login and logout with valid information, with remembering' do
    @a1 = admins(:elle_woods) # From test/fixtures/admin.yml

    # From test/test_helper.rb
    login_admin('elle_woods@example.com', 'Harvard Law', false)

    # From test/test_helper.rb
    logout_admin
  end
end

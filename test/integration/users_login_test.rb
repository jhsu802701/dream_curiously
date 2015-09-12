require 'test_helper'

#
class UsersLoginTest < ActionDispatch::IntegrationTest
  #
  def setup
    setup_admins_users # From test/test_helper.rb
  end

  test 'login with invalid information, no remembering' do
    visit new_user_session_path
    fill_in('Email', with: 'sean_connery@example.com')
    fill_in('Password', with: 'Peter Franks')
    uncheck('Remember me')
    click_button('Log in')
    assert_equal(current_path, new_user_session_path)
    page.has_button?('Sign in')
    page.has_link? new_user_session_path
    page.has_no_link? destroy_user_session_path
    assert_text 'Invalid email or password.'
  end

  test 'login with invalid information, with remembering' do
    visit new_user_session_path
    fill_in('Email', with: 'sean_connery@example.com')
    fill_in('Password', with: 'Peter Franks')
    check('Remember me')
    click_button('Log in')
    assert_equal(current_path, new_user_session_path)
    page.has_button?('Sign in')
    page.has_link? new_user_session_path
    page.has_no_link? destroy_user_session_path
    assert_text 'Invalid email or password.'
  end

  test 'login for unconfirmed user, no remembering' do
    @u2 = users(:lazenby) # From test/fixtures/user.yml
    visit new_user_session_path
    fill_in('Email', with: 'george_lazenby@example.com')
    fill_in('Password', with: 'ohmss1969')
    uncheck('Remember me')
    click_button('Log in')
    assert_equal(current_path, new_user_session_path)
    page.has_button?('Sign in')
    page.has_link? new_user_session_path
    page.has_no_link? destroy_user_session_path
    assert_text 'You have to confirm your email address'
  end

  test 'login for unconfirmed user, with remembering' do
    @u2 = users(:lazenby) # From test/fixtures/user.yml
    visit new_user_session_path
    fill_in('Email', with: 'george_lazenby@example.com')
    fill_in('Password', with: 'ohmss1969')
    check('Remember me')
    click_button('Log in')
    assert_equal(current_path, new_user_session_path)
    page.has_button?('Sign in')
    page.has_link? new_user_session_path
    page.has_no_link? destroy_user_session_path
    assert_text 'You have to confirm your email address'
  end

  test 'login and logout with valid information, no remembering' do
    login_user('sean_connery@example.com', 'Goldfinger', false)
    logout_user
  end

  # NOTE: only makes sure that the login process is successful
  test 'login and logout with valid information, with remembering' do
    login_user('sean_connery@example.com', 'Goldfinger', true)
    logout_user
  end
end

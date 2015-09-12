require 'test_helper'

#
class AdminsViewTest < ActionDispatch::IntegrationTest
  #
  def setup
    setup_admins_users # From test/test_helper.rb
  end

  test 'user index page is not publicly accessible' do
    visit users_path
    assert_text 'Sign up'
  end

  test 'user index page is not accessible to users' do
    login_user('sean_connery@example.com', 'Goldfinger', false)
    visit users_path
    assert_text 'You are logged in as a user.'
  end

  test 'user index page has expected content' do
    login_admin('elle_woods@example.com', 'Harvard Law', false)
    click_on 'User Index'
    assert_text 'Sean'
    assert_text 'Connery'
    assert_text 'Roger'
    assert_text 'Moore'
    assert_text 'Pierce'
    assert_text 'Brosnan'

    click_on 'sean_connery@example.com'
    assert_text 'Sean'
    assert_text 'Connery'
    click_on 'User Index'

    click_on 'roger_moore@example.com'
    assert_text 'Roger'
    assert_text 'Moore'
    click_on 'User Index'

    click_on 'pierce_brosnan@example.com'
    assert_text 'Pierce'
    assert_text 'Brosnan'
    click_on 'User Index'

    logout_admin
  end

  test 'should allow admin to delete user' do
    assert_difference 'User.count', -1 do
      # Log in as user
      login_user('sean_connery@example.com', 'Goldfinger', false)
      logout_user

      # Delete user
      login_admin('elle_woods@example.com', 'Harvard Law', false)
      click_on 'User Index'
      assert_text 'Delete Sean Connery'
      click_on 'Delete Sean Connery'
      logout_admin
    end
  end
end

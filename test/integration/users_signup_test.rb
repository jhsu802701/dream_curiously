require 'test_helper'

#
class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'invalid signup information' do
    visit new_user_registration_path
    fill_in('Last name', with: 'Higgins')
    fill_in('First name', with: 'Jonathan')
    fill_in('Email', with: 'jonathan_higgins@example.com')
    fill_in('Password', with: 'Robin Masters')
    fill_in('Password confirmation', with: 'Zeus and Apollo')
    click_button('Sign up')
    assert_text 'prohibited this user from being saved'
    u1 = User.find_by(email: 'jonathan_higgins@example.com')
    assert_nil u1
  end

  test 'valid signup information' do
    create_user('Higgins', 'Jonathan', 'jonathan_higgins@example.com',
                'Higgy Baby')
    login_user('jonathan_higgins@example.com', 'Higgy Baby', false)
    logout_user
  end
end

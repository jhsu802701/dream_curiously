require 'test_helper'

#
class UsersControllerTest < ActionController::TestCase
  #
  def setup
    setup_admins_users # From test/test_helpr.rb
  end

  #
  def teardown
    Warden.test_reset!
  end

  test 'should not redirect index when logged in as an admin' do
    login_as @a1
    get :index
    assert :success
    logout :admin

    login_as @a2
    get :index
    assert :success
    logout :admin

    login_as @a3
    get :index
    assert :success
    logout :admin
  end

  test 'should redirect index when logged in as a user' do
    login_as @u1
    get :index
    assert_redirected_to root_path
    logout :user

    login_as @u2
    get :index
    assert_redirected_to root_path
    logout :user

    login_as @u3
    get :index
    assert_redirected_to root_path
    logout :user
  end

  test 'should redirect index when not logged in' do
    get :index
    assert_redirected_to root_path
  end

  test 'should not redirect profile page when logged in as an admin' do
    login_as @a1
    get :show, id: @u1
    assert :success
    logout :admin
  end

  test 'should allow users to see their own profile pages' do
    login_as @u1
    get :show, id: @u1
    assert :success
    logout :user

    login_as @u2
    get :show, id: @u2
    assert :success
    logout :user

    login_as @u3
    get :show, id: @u3
    assert :success
    logout :user
  end

  test 'should not allow user to see profile of another user' do
    login_as @u1
    get :show, id: @u2
    assert_redirected_to root_path
    get :show, id: @u3
    assert_redirected_to root_path
    logout :user
  end

  test 'should redirect profile page when not logged in' do
    get :show, id: @u1
    assert_redirected_to root_path
    get :show, id: @u2
    assert_redirected_to root_path
    get :show, id: @u3
    assert_redirected_to root_path
  end

  test 'should allow admin to delete user' do
    login_as @a1
    get :destroy, id: @u1
    assert :success
    logout :admin
  end

  test 'should not allow user to delete another user' do
    login_as @u1
    get :destroy, id: @u2
    assert_redirected_to root_path
    logout :user
  end

  test 'should not allow user to delete self with user controller only' do
    login_as @u1
    get :destroy, id: @u1
    assert_redirected_to root_path
    logout :user
  end
end

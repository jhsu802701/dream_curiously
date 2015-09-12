require 'test_helper'

#
class AdminsControllerTest < ActionController::TestCase
  #
  def setup
    setup_admins_users # From test/test_helper.rb
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
  end

  test 'should redirect index when not logged in' do
    get :index
    assert_redirected_to root_path
  end

  test 'should not redirect profile page when logged in as an admin' do
    login_as @a1
    get :show, id: @a1
    assert :success
    logout :admin
  end

  test 'should redirect profile page when logged in as a user' do
    login_as @u1
    get :show, id: @a1
    assert_redirected_to root_path
    get :show, id: @a2
    assert_redirected_to root_path
    get :show, id: @a3
    assert_redirected_to root_path
    logout :user
  end

  test 'should redirect profile page when not logged in' do
    get :show, id: @a1
    assert_redirected_to root_path
    get :show, id: @a2
    assert_redirected_to root_path
    get :show, id: @a3
    assert_redirected_to root_path
  end
end

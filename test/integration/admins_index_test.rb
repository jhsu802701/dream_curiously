require 'test_helper'

#
class AdminsViewTest < ActionDispatch::IntegrationTest
  #
  def setup
    setup_admins_users # From test/test_helper.rb
  end

  test 'admin index page has expected content' do
    login_admin('elle_woods@example.com', 'Harvard Law', false)
    click_on 'Admin Index'
    assert_text 'Vivian'
    assert_text 'Kensington'
    assert_text 'Elle'
    assert_text 'Woods'
    assert_text 'Emmett'
    assert_text 'Richmond'

    click_on 'vkensingston@example.com'
    assert_text 'Vivian'
    assert_text 'Kensington'
    click_on 'Admin Index'

    click_on 'elle_woods@example.com'
    assert_text 'Elle'
    assert_text 'Woods'
    click_on 'Admin Index'

    click_on 'erichmond@example.com'
    assert_text 'Emmett'
    assert_text 'Richmond'
    click_on 'Admin Index'

    logout_admin
  end
end

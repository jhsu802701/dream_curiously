require 'test_helper'
include ApplicationHelper

#
class TicketsHelperTest < ActionView::TestCase
  test 'full_title function works properly' do
    assert_equal full_title(''), 'Rails Tutorial'
    assert_equal full_title('Help'), 'Help | Rails Tutorial'
  end
end

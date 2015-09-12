require 'test_helper'
include ApplicationHelper

#
class TicketsHelperTest < ActionView::TestCase
  test 'full_title function works properly' do
    assert_equal full_title(''), 'Dream Curiously'
    assert_equal full_title('Help'), 'Help | Dream Curiously'
  end
end

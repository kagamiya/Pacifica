require 'test_helper'

class UsersHelperTest < ActionView::TestCase
  include UsersHelper

  def setup
    @user = users(:michael)
  end

  test "icon_for should return the right image" do
  end
end

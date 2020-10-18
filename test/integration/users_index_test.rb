require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:michael)
    @non_admin = users(:archer)
  end

  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination', count: 2
    User.paginate(page: 1, per_page: 15).each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      assert_select 'div.user_profile', text: user.profile
      # confirm delete links are there when logged in as admin
      assert_select 'a[href=?]', user_path(user), text: 'delete' unless user == @admin
    end

    # delete an user by admin
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end

  test "index as non-admin" do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end
end

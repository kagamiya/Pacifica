require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:michael)
  end

  test "profile display" do
    # user's profile
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'a', text: @user.name
    assert_select 'p', text: @user.profile
    assert_select 'img.user_icon'

    # user's posts
    assert_match @user.posts.count.to_s, response.body
    assert_select 'div.pagination', count: 1
    @user.posts.paginate(page: 1, per_page: 10).each do |post|
      assert_select 'a[href=?]', post_path(post)
    end
  end
end

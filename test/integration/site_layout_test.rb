require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @non_post_user = users(:malory)
  end

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", signup_path, count: 2
    assert_select "a[href=?]", user_path(Post.last.user)
    # assert_select "a[href=?]", help_path
    get help_path
    assert_select "title", full_title("Help")
  end

  test "render specific view when logged in or not" do
    # when not logged in
    get root_path
    assert_template 'static_pages/home'
    # log in as an user having feed to show
    log_in_as(@user)
    get root_path
    assert_template 'static_pages/home_feed'
    delete logout_path
    # log in as an user having no feed to show
    log_in_as(@non_post_user)
    get root_path
    assert_template 'static_pages/home_feed_nil'
  end
end

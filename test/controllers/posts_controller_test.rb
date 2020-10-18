require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @post = posts(:orange)
    @other_users_post = posts(:ants)
    @user = users(:michael)
  end

  test "should redirect show when not logged in" do
    get post_path(@post)
    assert_redirected_to login_url
  end

  test "should redirect new when not logged in" do
    get new_post_path
    assert_redirected_to login_url
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { content: "Lorem ipsum" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Post.count' do
      delete post_path(@post)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy for wrong post" do
    log_in_as(users(:michael))
    post = posts(:ants)
    assert_no_difference 'Post.count' do
      delete post_path(post)
    end
    assert_redirected_to root_url
  end

  test "should redirect edit when not logged in" do
    get edit_post_path(@post)
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@user)
    get edit_post_path(@other_users_post)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when not logged in" do
    get edit_post_path(@post)
    patch post_path(@post), params: { post: { content: "foobar" } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@user)
    patch post_path(@other_users_post), params: { post: { content: "foobar" } }
    assert flash.empty?
    assert_redirected_to root_url
  end
end

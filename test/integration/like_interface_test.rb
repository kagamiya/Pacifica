require 'test_helper'

class LikeInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @post = posts(:zone)
    log_in_as(@user)
  end

  test "should like a post with the standard way" do
    assert_difference 'Like.count', 1 do
      post user_likes_path(@user), params: { post_id: @post.id }
    end
  end

  test "should like a post with Ajax" do
    assert_difference 'Like.count', 1 do
      post user_likes_path(@user), xhr: true, params: { post_id: @post.id }
    end
  end

  test "should unlike a post with the standard way" do
    @user.like(@post)
    assert_difference 'Like.count', -1 do
      delete user_like_path(@user, @post), params: { post_id: @post.id }
    end
  end

  test "should unlike a post with Ajax" do
    @user.like(@post)
    assert_difference 'Like.count', -1 do
      delete user_like_path(@user, @post), xhr: true, params: { post_id: @post.id }
    end
  end

  test "liked posts are exactly showed on index page" do
    # post link should NOT be there before user like it
    get user_likes_path(@user)
    assert_template 'likes/index'
    assert_select 'a[href=?]', post_path(@post), count: 0

    # post link should be there after user liked it
    @user.like(@post)
    get user_likes_path(@user)
    assert_template 'likes/index'
    assert_select 'a[href=?]', post_path(@post)
    # other liked posts
    @user.like_posts.each do |like_post|
      assert_select 'a[href=?]', user_path(like_post.user)
      assert_select 'a[href=?]', post_path(like_post)
    end

    # post link should not be there after user unliked it
    @user.unlike(@post)
    get user_likes_path(@user)
    assert_select 'a[href=?]', post_path(@post), count: 0
  end
end

require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @post = posts(:ants)
  end

  test "should get index" do
    log_in_as(@user)
    get user_likes_path(@user)
    assert_response :success
    assert_template 'likes/index'
  end

  test "should redirect index when not logged in" do
    get user_likes_path(@user)
    assert_redirected_to login_url
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Like.count' do
      post user_likes_path(@user, @post)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Like.count' do
      delete user_like_path(@user, @post)
    end
    assert_redirected_to login_url
  end
end

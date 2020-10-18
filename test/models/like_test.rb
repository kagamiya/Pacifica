require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  def setup
    @post = posts(:ants)
    @user = users(:michael)
    @like = Like.new(post_id: @post.id, user_id: @user.id)
  end

  test "should be valid" do
    assert @like.valid?
  end

  test "should require post_id" do
    @like.post_id = nil
    assert_not @like.valid?
  end

  test "should require user_id" do
    @like.user_id = nil
    assert_not @like.valid?
  end
end

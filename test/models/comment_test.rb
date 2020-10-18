require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @post = posts(:ants)
    @comment = @post.comments.build(user_id: @user.id, content: "comment content")
  end

  test "should be valid" do
    assert @comment.valid?
  end

  test "content should be present" do
    @comment.content = ""
    assert_not @comment.valid?
  end

  test "content should not be too long" do
    @comment.content = "a" * 141
    assert_not @comment.valid?
  end
end
